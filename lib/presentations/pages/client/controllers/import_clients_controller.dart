import 'dart:convert';

/// Web
import 'dart:html' as html;
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geogestao_front/domain/domain.dart';
import 'package:path_provider/path_provider.dart';

class ImportClientsController extends ChangeNotifier {
  final ImportClientsUsecase importClientsUsecase;
  ImportClientsController({required this.importClientsUsecase});

  /// Estado
  List<ClientParam> clients = [];
  bool isLoading = false;
  String? error;

  /// Scroll
  final ScrollController horizontalScroll = ScrollController();

  Future<void> pickFile() async {
    error = null;
    notifyListeners();

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'],
      );

      if (result == null) return;

      final file = result.files.single;

      if (file.bytes == null && file.path == null) {
        throw Exception('Arquivo inválido');
      }

      final extension = file.extension?.toLowerCase();

      if (extension == 'csv') {
        await _parseCsv(file.bytes!);
      } else {
        await _parseExcel(file.bytes ?? await File(file.path!).readAsBytes());
      }
    } catch (e) {
      error = 'Erro ao importar arquivo';
      debugPrint('Import error: $e');
    }

    notifyListeners();
  }

  void clear() {
    clients.clear();
    notifyListeners();
  }

  void disposeController() {
    horizontalScroll.dispose();
  }

  /// =============================
  /// Excel
  /// =============================

  Future<void> _parseExcel(Uint8List bytes) async {
    final excel = Excel.decodeBytes(bytes);
    final sheet = _firstValidSheet(excel);

    if (sheet == null || sheet.rows.length < 2) {
      throw Exception('Planilha vazia');
    }

    final headers = _parseHeaders(sheet.rows.first);

    final parsed = <ClientParam>[];

    for (int i = 1; i < sheet.rows.length; i++) {
      final row = sheet.rows[i];
      final client = _mapRow(headers, (key) {
        final index = headers.indexOf(key);
        if (index == -1 || index >= row.length) return null;
        return row[index]?.value?.toString();
      });

      if (client != null) parsed.add(client);
    }

    clients = parsed;
  }

  Sheet? _firstValidSheet(Excel excel) {
    for (final sheet in excel.sheets.values) {
      if (sheet.maxRows > 0) return sheet;
    }
    return null;
  }

  /// =============================
  /// CSV
  /// =============================

  Future<void> _parseCsv(Uint8List bytes) async {
    final content = _decode(bytes);
    final lines = const LineSplitter().convert(content);

    if (lines.length < 2) return;

    final delimiter = lines.first.contains(';') ? ';' : ',';
    final headers = lines.first
        .split(delimiter)
        .map((e) => e.trim().toLowerCase())
        .toList();

    final parsed = <ClientParam>[];

    for (int i = 1; i < lines.length; i++) {
      final row = lines[i].split(delimiter);

      final client = _mapRow(headers, (key) {
        final index = headers.indexOf(key);
        if (index == -1 || index >= row.length) return null;
        return row[index].replaceAll('"', '').trim();
      });

      if (client != null) parsed.add(client);
    }

    clients = parsed;
  }

  String _decode(Uint8List bytes) {
    try {
      return utf8.decode(bytes);
    } catch (_) {
      return latin1.decode(bytes);
    }
  }

  /// =============================
  /// Mapping + validação
  /// =============================

  ClientParam? _mapRow(
    List<String> headers,
    String? Function(String key) cell,
  ) {
    final name = cell('nome');
    final cnpj = cell('cnpj/cpf');

    if (name == null || name.isEmpty || cnpj == null || cnpj.isEmpty) {
      return null;
    }

    final statusRaw = (cell('status') ?? 'active').toLowerCase();

    return ClientParam(
      name: name,
      cnpj: cnpj,
      ownerName: cell('proprietário'),
      phone: cell('telefone'),
      email: cell('email'),
      address: cell('endereço') ?? '',
      latitude: '',
      longitude: '',
      status: ClientStatus.values.firstWhere(
        (e) => e.name == statusRaw,
        orElse: () => ClientStatus.active,
      ),
    );
  }

  List<String> _parseHeaders(List<Data?> row) {
    return row
        .map((e) => e?.value?.toString().trim().toLowerCase() ?? '')
        .toList();
  }

  Future<void> downloadAssetFile({
    required String assetPath,
    required String fileName,
  }) async {
    final ByteData data = await rootBundle.load(
      'file/modelo_importacao_clientes.xlsx',
    );

    final Uint8List bytes = data.buffer.asUint8List();

    if (kIsWeb) {
      final blob = html.Blob([
        bytes,
      ], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');

      final url = html.Url.createObjectUrlFromBlob(blob);

      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', fileName)
        ..click();

      html.Url.revokeObjectUrl(url);
    } else {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$fileName');
      await file.writeAsBytes(bytes);

      // opcional: abrir o arquivo depois de salvar
      // await OpenFile.open(file.path);
    }
  }

  int imported = 0;
  int total = 0;

  Future<void> importInBatches(
    List<ClientParam> clients, {
    int batchSize = 20,
  }) async {
    isLoading = true;
    imported = 0;
    total = clients.length;
    notifyListeners();

    for (var i = 0; i < clients.length; i += batchSize) {
      final batch = clients.skip(i).take(batchSize).toList();

      final result = await importClientsUsecase(param: batch);

      result.ways(
        (count) {
          imported += count;

          notifyListeners();
        },
        (error) {
          // Você pode logar ou mostrar erro parcial
        },
      );
    }

    isLoading = false;
    notifyListeners();
  }
}
