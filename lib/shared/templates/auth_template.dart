import 'package:flutter/material.dart';

import '/core/core.dart';
import '/shared/shared.dart';

class AuthTemplate extends StatelessWidget {
  const AuthTemplate({super.key, required this.child, this.metas});
  final Widget child;

  final Meta? metas;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      metas: metas,
      backgroundColor: null,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(context.image.backgroundAuth, fit: BoxFit.cover),

          // 🔹 DEGRADÊ SOBRE A IMAGEM
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [context.theme.colorScheme.onPrimary.withAlpha(150), context.theme.colorScheme.onPrimary.withAlpha(150)],
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          Column(
                            children: [
                              Image.asset(context.image.logoPrimary, fit: BoxFit.cover, height: 50),
                              SpaceWidget.medium(),
                              Text(
                                context.text.spreadsheetDataAnalysis,
                                style: context.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () async {
                              AppLogger logger = AppLogger();
                              await logger.openConsole(context);
                            },
                            icon: Icon(context.icon.logger, color: context.theme.colorScheme.primary),
                          ),
                        ],
                      ),
                      SpaceWidget.medium(),
                      CardWidget(width: context.sizewidth > 600 ? 400 : context.sizewidth - 40, isBoxShadow: false, child: child),
                      SpaceWidget.medium(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flex(
                                  direction: context.sizewidth > 600 ? Axis.horizontal : Axis.vertical,
                                  children: [
                                    Text(context.text.signInTerms, style: context.textTheme.labelLarge),
                                    SpaceWidget.extraSmall(),
                                    ButtonTermsAndPrivacyWidget(),
                                  ],
                                ),
                              ],
                            ),
                            SpaceWidget.small(),
                            Text(context.text.copyright, style: context.textTheme.labelLarge, textAlign: TextAlign.center),
                            SpaceWidget.small(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonTermsAndPrivacyWidget extends StatelessWidget {
  const ButtonTermsAndPrivacyWidget({super.key, this.direction = Axis.horizontal});
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: direction,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TextButtonWidget(
              text: context.text.signInTermsOfService,
              onPressed: () => showDialogInfo(context, title: context.text.signInTermsOfService, content: context.text.textTermsOfService),
            ),
            SpaceWidget.extraSmall(),
            Text(context.text.signInAnd, style: context.textTheme.labelLarge),
            SpaceWidget.extraSmall(),
          ],
        ),
        TextButtonWidget(
          text: context.text.signInPrivacyPolicy,
          onPressed: () => showDialogInfo(context, title: context.text.signInPrivacyPolicy, content: context.text.textPrivacyPolicy),
        ),
      ],
    );
  }
}

void showDialogInfo(BuildContext context, {required String title, required String content}) {
  showDialog(
    context: context,
    barrierDismissible: false, // impede fechar ao tocar fora
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7, maxWidth: 500),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(child: Text(content, style: TextStyle(fontSize: 16))),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Fecha o diálogo
                    },
                    child: Text(context.text.understand),
                  ),
                  const SizedBox(width: 8),
                  // ElevatedButtonWidget(
                  //   onPressed: () async {
                  //     Navigator.of(context).pop();
                  //   },
                  //   text: context.text.understand,
                  // ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
