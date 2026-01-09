import 'package:flutter/widgets.dart';
import 'package:geogestao_front/presentations/pages/maps/controller/cep_controller.dart';
import 'package:geogestao_front/presentations/pages/maps/controller/map_controller.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '/core/core.dart';
import '/domain/domain.dart';
import '../../../presentations.dart';

class HomeController extends BaseController<HomeState> {
  final GetListFormsUsecase getListFormsUsecase;
  final CreateFormsUsecase createFormsUsecase;
  HomeController(this.getListFormsUsecase, this.createFormsUsecase)
    : super(HomeInitialStates());
  MapController mapController = Modular.get<MapController>();
  TextEditingController searchController = TextEditingController();

  ClientController clientController = Modular.get<ClientController>();
  CepController cepController = Modular.get<CepController>();

  @override
  void init() async {}

  void goToCreateForm() {
    Modular.to.pushNamed(CreateFormsDependency.routePath);
  }

  void goToFormView(FormsEntity form) {
    Modular.to.pushNamed('/to/${form.slug}');
  }

  void goToCreateFormFromTemplate(FormsEntity form) {
    Modular.to.pushNamed(
      '${CreateFormsDependency.routePath}${form.id}',
      arguments: form.id,
    );
  }

  Meta meta = Meta(
    title: 'GeoGestão - Home',
    description: 'Welcome to GeoGestão, your task management platform.',
    keywords: 'GeoGestão, home, task management, project management',
    author: 'Tech Alliances',
    viewport: 'width=device-width, initial-scale=1',
    robots: 'index, follow',
    ogTitle: 'GeoGestão - Home',
    ogDescription: 'Welcome to GeoGestão, your task management platform.',
    ogUrl: 'https://GeoGestão.com/home/',
    ogType: 'website',
    ogSiteName: 'GeoGestão',
    ogLocale: 'en_US',
    ogLocaleAlternate: 'es_ES',
    ogImage: 'assets/images/logos/logo_GeoGestão.png',
    h1: 'Welcome to GeoGestão',
    h2: 'Your task management platform',
    h3: 'Get started with GeoGestão',
    h4: 'Manage your tasks and projects efficiently',
    h5: 'Join us today',
    h6: 'GeoGestão - Home',
  );
  final List<LatLng> markers = const [
    LatLng(-23.5505, -46.6333), // São Paulo
  ];
  addMaker(MapboxMapController mapController) {
    mapController.addSymbol(
      SymbolOptions(
        geometry: LatLng(0.0, 0.0),
        iconImage: "marker-15",
        iconSize: 1.5,
      ),
    );
  }
}
