import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geogestao_front/shared/map/geo_point.dart';
import 'package:latlong2/latlong.dart';

class GeoZone {
  final String id;
  final List<LatLng> points;
  final Color fillColor;
  final Color borderColor;

  GeoZone({required this.id, required this.points, this.fillColor = const Color(0x334A90E2), this.borderColor = const Color(0xFF4A90E2)});
}

class GeoMap extends StatefulWidget {
  final String mapboxAccessToken;
  final double height;

  /// pontos (clientes)
  final List<GeoPoint> points;

  /// zonas (polígonos)
  final List<GeoZone> zones;

  /// centro inicial
  final LatLng initialCenter;
  final double initialZoom;

  const GeoMap({
    super.key,
    required this.mapboxAccessToken,
    this.height = 500,
    this.points = const [],
    this.zones = const [],
    this.initialCenter = const LatLng(-23.5505, -46.6333), // SP
    this.initialZoom = 11,
  });

  @override
  State<GeoMap> createState() => _GeoMapState();
}

class _GeoMapState extends State<GeoMap> {
  late final MapController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MapController();
  }

  String get _tileUrl => 'https://api.mapbox.com/styles/v1/mapbox/streets-v12/tiles/256/{z}/{x}/{y}@2x?access_token=${widget.mapboxAccessToken}';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FlutterMap(
          mapController: _controller,
          options: MapOptions(
            initialCenter: widget.initialCenter,
            initialZoom: widget.initialZoom,
            minZoom: 2,
            maxZoom: 20,
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.all, // pan + zoom + scroll wheel + etc
            ),
          ),
          children: [
            TileLayer(urlTemplate: _tileUrl, userAgentPackageName: 'geogestao_front'),

            // ZONAS (polígonos)
            PolygonLayer(
              polygons: widget.zones.map((z) {
                return Polygon(points: z.points, color: z.fillColor, borderColor: z.borderColor, borderStrokeWidth: 2);
              }).toList(),
            ),

            // PONTOS (clientes)
            MarkerLayer(
              markers: widget.points.map((p) {
                return Marker(
                  point: p.position,
                  width: 44,
                  height: 44,
                  child: _Pin(color: p.color),
                );
              }).toList(),
            ),

            // Controles de zoom (+ / -)
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _ZoomButton(icon: Icons.add, onTap: () => _controller.move(_controller.camera.center, _controller.camera.zoom + 1)),
                    const SizedBox(height: 8),
                    _ZoomButton(icon: Icons.remove, onTap: () => _controller.move(_controller.camera.center, _controller.camera.zoom - 1)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Pin extends StatelessWidget {
  final Color color;
  const _Pin({required this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.location_on, size: 42, color: color),
        const Positioned(top: 12, child: CircleAvatar(radius: 5, backgroundColor: Colors.white)),
      ],
    );
  }
}

class _ZoomButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ZoomButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 3,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(width: 44, height: 44, child: Icon(icon)),
      ),
    );
  }
}
