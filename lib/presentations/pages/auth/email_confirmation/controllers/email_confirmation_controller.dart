import '/core/core.dart';
import '/domain/usecases/usecases.dart';
import '/presentations/pages/pages.dart';

class EmailConfirmationController
    extends BaseController<EmailConfirmationState> {
  final SignUpUsecase signUpUsecase;
  EmailConfirmationController(this.signUpUsecase)
    : super(EmailConfirmationInitialStates());

  @override
  void init() async {}

  goToSignIn() {
    Modular.to.pushReplacementNamed(SignInDependency.routePath);
  }

  Meta meta = Meta(
    title: 'Confirmação de E-mail',
    description: 'Confirme seu e-mail para ativar sua conta',
    keywords:
        'GeoGestão, confirmação de e-mail, autenticação, análise de dados de planilhas',
    author: 'Tech Alliances',
    viewport: 'width=device-width, initial-scale=1',
    robots: 'index, follow',
    ogTitle: 'Confirmação de E-mail',
    ogDescription: 'Confirme seu e-mail para ativar sua conta no GeoGestão',
    ogImage: 'assets/images/logos/logo_GeoGestão.png',
    ogUrl: 'https://GeoGestão.com/auth/email-confirmation/',
    ogType: 'website',
    ogSiteName: 'GeoGestão',
    ogLocale: 'pt_BR',
    ogLocaleAlternate: 'en_US',
    h1: 'Confirmação de E-mail',
    h2: 'Verifique seu e-mail',
    h3: 'Ative sua conta',
    h4: 'Clique no link de confirmação enviado para o seu e-mail',
    h5: 'Acesse todos os recursos do GeoGestão',
    h6: 'Junte-se a nós hoje mesmo',
  );
}
