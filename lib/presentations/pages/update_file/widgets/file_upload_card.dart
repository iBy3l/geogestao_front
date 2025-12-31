import 'dart:html' as html;

import 'package:flutter/material.dart';

import '/core/core.dart';
import '/shared/shared.dart';

class FileUploadCard extends StatefulWidget {
  const FileUploadCard({super.key, this.selectedFile, required this.onFileSelected, required this.eneble});
  final html.File? selectedFile;
  final void Function(html.File file) onFileSelected;
  final bool eneble;

  @override
  State<FileUploadCard> createState() => _FileUploadCardState();
}

class _FileUploadCardState extends State<FileUploadCard> {
  bool isDragging = false;
  late html.File _selectedFile;
  String _feedbackMessage = "Arraste sua planilha aqui ou clique para selecionar";
  List<String> supportedFormats = ['xlsx', 'xls', 'csv'];
  double _sizeFile = 0;

  @override
  void initState() {
    _selectedFile = widget.selectedFile ?? html.File([], '');

    super.initState();
  }

  void _selectFile() {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = '.xlsx,.xls,.csv';
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      if (uploadInput.files!.isNotEmpty) {
        final file = uploadInput.files![0];
        _handleFile(file);
      }
    });
  }

  void _handleFile(html.File file) {
    final fileName = file.name;
    final fileExtension = fileName.split('.').last.toLowerCase();
    if (supportedFormats.contains(fileExtension)) {
      setState(() {
        _selectedFile = file;
        _feedbackMessage = "${context.text.selectedFile}: ${file.name}";
        isDragging = false;
        _sizeFile = file.size.toDouble();
      });
      widget.onFileSelected(file); // 👈 Notifica o controller
    } else {
      setState(() {
        _selectedFile = html.File([], '');
        _feedbackMessage = "${context.text.unsupportedFileFormat}: .$fileExtension. Use ${supportedFormats.join(', ')}.";
        isDragging = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<List<html.File>>(
      onWillAcceptWithDetails: (details) {
        setState(() {
          isDragging = true;
          _feedbackMessage = "Solte o arquivo aqui";
        });

        return true;
      },
      onAcceptWithDetails: (details) {
        final files = details.data;
        if (files.isNotEmpty) {
          _handleFile(files.first);
        }
      },
      onLeave: (data) {
        setState(() {
          isDragging = false;
          _feedbackMessage = "${context.text.selectedFile}: ${_selectedFile.name}";
        });
      },
      builder: (context, candidateData, rejectedData) {
        return CardWidget(
          width: context.sizewidth,
          height: context.sizeheight,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(context.icon.attachFile, size: 40, color: context.theme.colorScheme.primary),
                  SpaceWidget.medium(),
                  Text(_feedbackMessage, textAlign: TextAlign.center, style: context.theme.textTheme.titleLarge?.copyWith(color: context.theme.colorScheme.scrim, fontWeight: FontWeight.w600)),
                  SpaceWidget.extraSmall(),
                  Text("${context.text.supportedFormats}: ${supportedFormats.join(', ')}", style: context.theme.textTheme.bodyMedium?.copyWith(color: context.theme.colorScheme.outline)),
                  SpaceWidget.medium(),
                  ElevatedButtonWidget(
                    enable: widget.eneble,
                    fixedSize: const Size(200, 48),
                    text: context.text.selectFile,
                    iconPrefix: context.icon.attachFile,
                    onPressed: () async {
                      _selectFile();
                    },
                  ),
                  SpaceWidget.medium(),
                  Text(
                    "${context.text.selectedFile}: ${_selectedFile.name} (${(_sizeFile / 1024).toStringAsFixed(2)} KB)",
                    style: context.theme.textTheme.bodyMedium?.copyWith(color: context.theme.colorScheme.scrim, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
