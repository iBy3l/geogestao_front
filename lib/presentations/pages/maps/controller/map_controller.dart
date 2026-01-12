import 'dart:html' as html;
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geogestao_front/core/consts/strings_const.dart';
import 'package:geogestao_front/domain/domain.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapController extends ChangeNotifier {
  final SearchAddressUsecase searchAddress;
  final GenerateRandomMarkersUsecase generateMarkers;
  final AutocompleteAddressUsecase autocompleteAddress;

  MapController({
    required this.searchAddress,
    required this.generateMarkers,
    required this.autocompleteAddress,
  });
  MapboxMapController? mapbox;
  final markers = <MapMarker>[];

  final double minZoom = 9;
  final double maxZoom = 18;

  double _currentZoom = 12;
  double get currentZoom => _currentZoom;
  String get mapboxToken => StringsConst().mapbox;

  final suggestions = <AddressSuggestion>[];

  void onMapCreated(MapboxMapController controller) {
    mapbox = controller;
    _currentZoom = controller.cameraPosition?.zoom ?? _currentZoom;

    controller.addListener(() {
      if (controller.isCameraMoving) {
        _updateScreenMarkers(); // ✅ ESSENCIAL
      }

      final z = controller.cameraPosition?.zoom;
      if (z != null && z != _currentZoom) {
        _currentZoom = z;
        notifyListeners();
      }
    });
  }

  void onCameraIdle() {
    _updateScreenMarkers();
  }

  moveToLocation(LatLng latLng, double zoom) async {
    if (mapbox == null) return;
    await mapbox!.animateCamera(CameraUpdate.newLatLngZoom(latLng, zoom));
  }

  Future<void> autocomplete(String value) async {
    final result = await autocompleteAddress(value, mapboxToken);

    result.ways((list) {
      suggestions
        ..clear()
        ..addAll(list);
      notifyListeners();
    }, (_) {});
  }

  void addRandomMarkers(LatLngBounds bounds, int amount) {
    markers.addAll(generateMarkers(amount: amount, bounds: bounds));
    _updateScreenMarkers(); // ✅
  }

  void onLayoutChanged() {
    if (mapbox == null) return;

    final camera = mapbox!.cameraPosition;
    if (camera == null) return;

    // 🔥 FORÇA O MAPA A REDESENHAR
    mapbox!.moveCamera(CameraUpdate.newCameraPosition(camera));

    // Atualiza markers depois do redraw
    _updateScreenMarkers();
  }

  final screenMarkers = <ScreenMarker>[];

  bool get canZoomIn => _currentZoom < maxZoom;
  bool get canZoomOut => _currentZoom > minZoom;

  Future<void> zoomIn() async {
    if (!canZoomIn || mapbox == null) return;
    await mapbox!.animateCamera(CameraUpdate.zoomTo(_currentZoom + 1));
  }

  Future<void> zoomOut() async {
    if (!canZoomOut || mapbox == null) return;
    await mapbox!.animateCamera(CameraUpdate.zoomTo(_currentZoom - 1));
  }

  static const LatLng saoPauloCenter = LatLng(-23.5505, -46.6333);

  Future<void> goToSaoPaulo() async {
    if (mapbox == null) return;

    await mapbox!.animateCamera(CameraUpdate.newLatLngZoom(saoPauloCenter, 11));
  }

  Future<void> fitMarkers() async {
    if (mapbox == null || markers.isEmpty) return;

    final lats = markers.map((m) => m.position.latitude);
    final lngs = markers.map((m) => m.position.longitude);

    final bounds = LatLngBounds(
      southwest: LatLng(lats.reduce(min), lngs.reduce(min)),
      northeast: LatLng(lats.reduce(max), lngs.reduce(max)),
    );

    await mapbox!.animateCamera(
      CameraUpdate.newLatLngBounds(
        bounds,
        left: 50,
        right: 50,
        top: 50,
        bottom: 50,
      ),
    );
  }

  final LatLngBounds saoPauloBounds = LatLngBounds(
    southwest: LatLng(-24.008, -46.825),
    northeast: LatLng(-23.356, -46.365),
  );

  Future<void> fitSaoPaulo() async {
    if (mapbox == null) return;

    await mapbox!.animateCamera(
      CameraUpdate.newLatLngBounds(
        saoPauloBounds,
        left: 50,
        right: 50,
        top: 50,
        bottom: 50,
      ),
    );
  }

  String? _lastClientsHash;

  void setClientMarkers(List<ClientEntity> clients) {
    final hash = clients.map((c) => c.id).join(',');

    if (_lastClientsHash == hash) return; // 🚫 evita loop

    _lastClientsHash = hash;

    markers
      ..clear()
      ..addAll(
        clients
            .where((c) => c.longitude != null)
            .map(
              (c) => MapMarker(
                id: c.id,
                position: LatLng(c.latitude, c.longitude),
              ),
            ),
      );

    _updateScreenMarkers();
  }

  bool _isFullscreen = false;
  bool get isFullscreen => _isFullscreen;

  void toggleFullscreenWeb() {
    if (html.document.fullscreenElement == null) {
      html.document.documentElement?.requestFullscreen();
      _isFullscreen = true;
    } else {
      html.document.exitFullscreen();
      _isFullscreen = false;
    }
    notifyListeners();
  }

  void toggleFullscreen() {
    if (kIsWeb) {
      toggleFullscreenWeb();
    }
  }

  MapMarker? searchMarker;

  Future<LatLng?> searchAutocomplete(String query) async {
    final result = await searchAddress(query, mapboxToken);
    LatLng? latLng;
    result.ways((success) {
      if (success != null) {
        latLng = LatLng(success.latitude, success.longitude);
      }
    }, (_) {});
    return latLng;
  }

  Future<void> search(String value) async {
    suggestions.clear();
    notifyListeners();

    final result = await searchAddress(value, mapboxToken);
    if (mapbox == null) return;

    result.ways((success) async {
      if (success == null) return;

      final latLng = LatLng(success.latitude, success.longitude);

      // move câmera
      await mapbox!.animateCamera(
        CameraUpdate.newLatLngZoom(latLng, 17), // zoom de rua
      );

      // cria ou move marker
      searchMarker = MapMarker(id: 'search', position: latLng);

      _updateScreenMarkers();
    }, (_) {});
  }

  Future<void> _updateScreenMarkers() async {
    if (mapbox == null) return;

    final allMarkers = <MapMarker>[
      ...markers,
      if (searchMarker != null) searchMarker!,
    ];

    if (allMarkers.isEmpty) return;

    final latLngs = allMarkers.map((m) => m.position).toList();
    final points = await mapbox!.toScreenLocationBatch(latLngs);

    screenMarkers
      ..clear()
      ..addAll(
        List.generate(points.length, (i) {
          return ScreenMarker(
            id: allMarkers[i].id,
            screenPosition: Point(
              points[i].x.toDouble(),
              points[i].y.toDouble(),
            ),
            color: allMarkers[i].id == 'search'
                ? Colors
                      .blue // 🔵 marcador da rua
                : Colors.red,
          );
        }),
      );

    notifyListeners();
  }

  Offset? contextMenuPosition;

  LatLng? contextLatLng;

  bool get isContextMenuOpen => contextMenuPosition != null;
  void openContextMenu({required Offset position, required LatLng latLng}) {
    contextMenuPosition = position;
    contextLatLng = latLng;
    notifyListeners();
  }

  void closeContextMenu() {
    contextMenuPosition = null;
    contextLatLng = null;
    notifyListeners();
  }
}
