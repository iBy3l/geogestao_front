import 'package:flutter/widgets.dart';

import '/core/core.dart';
import '/domain/domain.dart';
import '../../../presentations.dart';

class HomeController extends BaseController<HomeState> {
  final GetListFormsUsecase getListFormsUsecase;
  final CreateFormsUsecase createFormsUsecase;
  HomeController(this.getListFormsUsecase, this.createFormsUsecase) : super(HomeInitialStates());

  TextEditingController searchController = TextEditingController();

  @override
  void init() async {}

  void goToCreateForm() {
    Modular.to.pushNamed(CreateFormsDependency.routePath);
  }

  void goToFormView(FormsEntity form) {
    Modular.to.pushNamed('/to/${form.slug}');
  }

  void goToCreateFormFromTemplate(FormsEntity form) {
    Modular.to.pushNamed('${CreateFormsDependency.routePath}${form.id}', arguments: form.id);
  }

  Meta meta = Meta(
    title: 'Sympllizy - Home',
    description: 'Welcome to Sympllizy, your task management platform.',
    keywords: 'sympllizy, home, task management, project management',
    author: 'Tech Alliances',
    viewport: 'width=device-width, initial-scale=1',
    robots: 'index, follow',
    ogTitle: 'Sympllizy - Home',
    ogDescription: 'Welcome to Sympllizy, your task management platform.',
    ogUrl: 'https://sympllizy.com/home/',
    ogType: 'website',
    ogSiteName: 'Sympllizy',
    ogLocale: 'en_US',
    ogLocaleAlternate: 'es_ES',
    ogImage: 'assets/images/logos/logo_sympllizy.png',
    h1: 'Welcome to Sympllizy',
    h2: 'Your task management platform',
    h3: 'Get started with Sympllizy',
    h4: 'Manage your tasks and projects efficiently',
    h5: 'Join us today',
    h6: 'Sympllizy - Home',
  );
}
