// lib/ui/widgets/file_column_display_card.dart (Remains mostly the same structure)
import 'dart:async';
import 'dart:html' as html;

import 'package:flutter/material.dart';
// Import your correctly named controller and states
import '/core/core.dart';
import '/presentations/pages/update_file/controllers/file_columns_state.dart';
import '/presentations/pages/update_file/states/file_columns_state.dart';
import '/shared/shared.dart';

class FileColumnDisplayCard extends StatefulWidget {
  const FileColumnDisplayCard({super.key, required this.file});

  final html.File file;

  @override
  State<FileColumnDisplayCard> createState() => _FileColumnDisplayCardState();
}

class _FileColumnDisplayCardState extends State<FileColumnDisplayCard> {
  late final FileColumnsController _controller; // Renamed
  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  @override
  void initState() {
    super.initState();
    _controller = FileColumnsController(); // Renamed
    _controller.parseFile(widget.file, context);
  }

  @override
  void didUpdateWidget(covariant FileColumnDisplayCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.file.name != oldWidget.file.name || widget.file.size != oldWidget.file.size) {
      debugPrint('[_FileColumnDisplayCardState] File changed, re-parsing via controller...');
      _controller.parseFile(widget.file, context);
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      width: context.sizewidth,
      height: context.sizeheight,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Confirmar Colunas', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            SpaceWidget.small(),
            Text('Arquivo: ${widget.file.name}. Verifique as colunas encontradas.', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey[600])),
            SpaceWidget.medium(),
            Expanded(
              child: BaseBuilder<FileColumnsController, FileColumnsStates>(
                controller: _controller,
                build: (context, state) {
                  if (state is FileColumnsLoadingState) {
                    return Center(
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text('${state.message}...')]),
                    );
                  }
                  if (state is FileColumnsErrorState) {
                    return Center(
                      child: Text(
                        state.message,
                        style: context.theme.textTheme.titleMedium?.copyWith(color: context.theme.colorScheme.error),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else if (state is FileColumnsEmptyState) {
                    return Center(
                      child: Text(state.message, style: context.theme.textTheme.titleMedium, textAlign: TextAlign.center),
                    );
                  } else if (state is FileColumnsSuccessState) {
                    // Renamed
                    final parsedColumns = state.parsedColumns;
                    if (parsedColumns.isEmpty) {
                      return Center(
                        child: Text(context.text.noColumnsFound, style: context.theme.textTheme.titleMedium, textAlign: TextAlign.center),
                      );
                    }
                    return ListView(
                      children: [
                        ...parsedColumns.entries.map((entry) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 24.0),
                            child: SpreadsheetSection(title: entry.key, columns: entry.value),
                          );
                        }),
                      ],
                    );
                  }
                  // Initial state or unhandled state
                  return Center(
                    child: Text(
                      context.text.selectFileToParse, // Example initial text
                      style: context.theme.textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SpreadsheetSection extends StatelessWidget {
  final String title;
  final List<String> columns;

  const SpreadsheetSection({super.key, required this.title, required this.columns});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
        ),
        const Divider(height: 16, thickness: 1),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Wrap(
            spacing: 8.0, // Espaçamento horizontal entre os chips
            runSpacing: 8.0, // Espaçamento vertical entre as linhas de chips
            children: columns.map((columnName) {
              return Chip(
                label: Text(columnName),
                backgroundColor: context.theme.colorScheme.primary.withOpacity(0.1),
                labelStyle: TextStyle(color: context.theme.colorScheme.primary, fontWeight: FontWeight.w500),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

// Widget para os botões no rodapé do card.
class FooterButtons extends StatelessWidget {
  const FooterButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            // Lógica para cancelar
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey[800],
            backgroundColor: Colors.grey[200],
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Cancelar', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: () {
            // Lógica para confirmar a importação
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2563EB),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 2,
          ),
          child: const Text('Confirmar Importação', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}

class LoadingDialog {
  static Future<void> showLoadingDialog(BuildContext context, GlobalKey key) async {
    if (key.currentContext?.findRenderObject() == null) {
      return await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return PopScope(
            canPop: false,
            child: SimpleDialog(
              key: key,
              backgroundColor: Colors.white,
              children: <Widget>[
                Center(
                  child: Column(
                    children: [
                      Text(context.text.loadingFile, style: TextStyle(color: Colors.blueAccent)),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  static void hideLoadingDialog(GlobalKey key) {
    if (key.currentContext != null && Navigator.of(key.currentContext!, rootNavigator: true).canPop()) {
      Navigator.of(key.currentContext!, rootNavigator: true).pop();
    }
  }
}
