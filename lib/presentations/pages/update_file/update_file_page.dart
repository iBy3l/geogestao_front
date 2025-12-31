import 'package:flutter/material.dart';
import '/core/core.dart';
import '/presentations/pages/update_file/widgets/file_upload_card.dart';
import '/shared/shared.dart';

import 'controllers/update_file_controller.dart';
import 'widgets/file_display_coluns.dart';

class UpdateFilePage extends StatefulWidget {
  const UpdateFilePage({super.key});

  @override
  State<UpdateFilePage> createState() => _UpdateFilePageState();
}

class _UpdateFilePageState extends BasePage<UpdateFilePage, UpdateFileController> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      // metas: controller.meta,
      child: BaseBuilder(
        controller: controller,
        build: (context, state) {
          final isSep = (controller.steps.any((element) => element.isSelected == true) && controller.selectedStepIndex > 0);
          return Container(
            height: context.sizeheight,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      context.text.uploadSpreadsheet,
                      style: context.theme.textTheme.headlineMedium?.copyWith(color: context.theme.colorScheme.scrim, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      context.text.uploadSpreadsheetSubtitle,
                      style: context.theme.textTheme.bodyMedium?.copyWith(color: context.theme.colorScheme.outline, fontWeight: FontWeight.w400),
                    ),
                    SpaceWidget.medium(),
                    Divider(color: context.theme.colorScheme.outline.withAlpha(100), height: 1, thickness: 8),
                    SpaceWidget.medium(),
                    MyStepByStepWidget(controller: controller),
                    SpaceWidget.small(),
                  ],
                ),
                Expanded(
                  child: IndexedStack(
                    index: controller.selectedStepIndex,
                    children: [
                      // --- Step 0: File Upload ---
                      FileUploadCard(
                        eneble: controller.enableGlobal,
                        selectedFile: controller.selectedFile,
                        onFileSelected: (file) {
                          setState(() {
                            controller.selectedFile = file;
                          });
                        },
                      ),

                      controller.selectedFileFinal != null
                          ? FileColumnDisplayCard(file: controller.selectedFileFinal!)
                          : CardWidget(
                              width: context.sizewidth,
                              height: context.sizeheight,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.info_outline, size: 40, color: Theme.of(context).colorScheme.outline),
                                    const SizedBox(height: 16),
                                    Text('Por favor, selecione um arquivo na etapa anterior para visualizar as colunas.', textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium),
                                  ],
                                ),
                              ),
                            ),

                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.settings_suggest, size: 40, color: Theme.of(context).colorScheme.tertiary),
                            const SizedBox(height: 16),
                            Text('Esta é a terceira etapa!', textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium),
                            if (controller.selectedFile != null) Padding(padding: const EdgeInsets.all(8.0), child: Text('Arquivo selecionado: ${controller.selectedFile!.name}')),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SpaceWidget.small(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (!isSep) SpaceWidget.expanded(),
                    if (isSep)
                      ElevatedButtonWidget(
                        fixedSize: (context).sizewidth > 600 ? const Size(200, 48) : Size(48, 48),
                        text: (context).sizewidth > 600 ? context.text.next : null,
                        onPressed: () async {
                          setState(() {
                            controller.steps[controller.selectedStepIndex].isSelected = true;
                            final nextIndex = controller.selectedStepIndex - 1;
                            if (nextIndex >= 0) {
                              controller.onStepSelected(nextIndex);
                            }
                          });
                        },
                        child: (context).sizewidth < 600 ? Center(child: Icon(Icons.arrow_back_ios_outlined, color: Colors.white)) : null,
                      ),
                    ElevatedButtonWidget(
                      enable: controller.selectedFile != null,
                      fixedSize: (context).sizewidth > 600 ? const Size(200, 48) : Size(48, 48),
                      text: (context).sizewidth > 600
                          ? controller.selectedStepIndex == controller.steps.length - 1
                                ? context.text.finish
                                : context.text.next
                          : null,
                      iconPrefix: (context).sizewidth > 600 ? context.icon.arrowRight : null,
                      onPressed: () async {
                        controller.enableGlobal = false;
                        await Future.delayed(const Duration(milliseconds: 100));
                        setState(() {
                          controller.steps[controller.selectedStepIndex].isSelected = true;
                          final nextIndex = controller.selectedStepIndex + 1;
                          if (nextIndex < controller.steps.length) {
                            controller.onStepSelected(nextIndex);
                            controller.enableGlobal = true;
                            controller.selectedFileFinal = controller.selectedFile;
                          }
                        });
                      },
                      child: (context).sizewidth < 600 ? Center(child: Icon(Icons.arrow_forward_ios_outlined, color: Colors.white)) : null,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MyStepByStepWidget extends StatefulWidget {
  final UpdateFileController controller;
  const MyStepByStepWidget({super.key, required this.controller});

  @override
  State<MyStepByStepWidget> createState() => _MyStepByStepWidgetState();
}

class _MyStepByStepWidgetState extends State<MyStepByStepWidget> {
  late UpdateFileController controller;
  @override
  initState() {
    super.initState();
    controller = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        width: double.infinity,
        child: (context).sizewidth > 600
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: controller.steps.asMap().entries.map((entry) {
                  final index = entry.key;
                  final step = entry.value;
                  final selectedColor = context.theme.colorScheme.primary;
                  final unselectedColor = context.theme.colorScheme.outline;
                  final isSelected = index == controller.selectedStepIndex;
                  final color = isSelected ? selectedColor : unselectedColor;
                  final textStyle = isSelected ? FontWeight.bold : FontWeight.w400;
                  final primary = isSelected ? context.theme.colorScheme.primary : context.theme.colorScheme.outline;
                  final coloricon = step.isSelected ? context.theme.colorScheme.onPrimary : primary;
                  return ButtonStepFile(
                    colorCard: color,
                    onTap: step.isSelected
                        ? () {
                            setState(() {
                              controller.selectedStepIndex = index;
                              controller.onStepSelected(index);
                            });
                          }
                        : null,
                    step: step,
                    color: primary,
                    fontWeight: textStyle,
                    coloricon: coloricon,
                  );
                }).toList(),
              )
            : SpaceWidget.extraSmall(),
      ),
    );
  }
}
