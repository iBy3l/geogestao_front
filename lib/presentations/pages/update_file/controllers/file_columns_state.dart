// lib/core/controllers/file_columns_controller.dart
import 'dart:async';
import 'dart:html' as html; // For web-specific FileReader

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Import your base controller and states
import '/core/core.dart'; // Assuming BaseController and other core utilities are here
import '/presentations/pages/update_file/states/file_columns_state.dart'; // The correctly named states

// ===========================================================================
// TOP-LEVEL OR STATIC HELPER FUNCTIONS FOR ISOLATE (compute) - REMAIN UNCHANGED
// ===========================================================================

Future<Map<String, List<String>>> _parseExcelInBackground(Uint8List bytes) async {
  debugPrint('[_parseExcelInBackground] Started in isolate. Bytes length: ${bytes.length}');
  Map<String, List<String>> sheetColumns = {};

  // try {
  //   var excel = Excel.decodeBytes(bytes);
  //   debugPrint('[_parseExcelInBackground] Excel tables found: ${excel.tables.keys.length}');
  //   if (excel.tables.keys.isEmpty) {
  //     debugPrint('[_parseExcelInBackground] No tables/sheets found in Excel file decoded.');
  //     return sheetColumns;
  //   }
  //   for (var table in excel.tables.keys) {
  //     debugPrint('[_parseExcelInBackground] Processing sheet: $table');
  //     final sheet = excel.tables[table];
  //     if (sheet != null) {
  //       debugPrint('[_parseExcelInBackground] Sheet "$table" has ${sheet.rows.length} rows.');
  //       if (sheet.rows.isNotEmpty) {
  //         final firstRow = sheet.rows.first;
  //         List<String> columns = [];
  //         for (var cell in firstRow) {
  //           columns.add(cell?.value?.toString() ?? 'Unnamed Column');
  //         }
  //         debugPrint('[_parseExcelInBackground] Columns extracted from first row of "$table": $columns');
  //         if (columns.isNotEmpty) {
  //           sheetColumns[table] = columns;
  //         } else {
  //           debugPrint('[_parseExcelInBackground] First row of sheet "$table" was empty or contained no valid column names. Skipping this sheet.');
  //         }
  //       } else {
  //         debugPrint('[_parseExcelInBackground] Sheet "$table" is empty (no rows). Skipping this sheet.');
  //       }
  //     } else {
  //       debugPrint('[_parseExcelInBackground] Sheet object for "$table" was null. Skipping this sheet.');
  //     }
  //   }
  // } catch (e) {
  //   debugPrint('[_parseExcelInBackground] Error during Excel parsing: $e');
  //   rethrow;
  // }
  debugPrint('[_parseExcelInBackground] Finished in isolate. Parsed columns map: $sheetColumns');
  return sheetColumns;
}

Future<Map<String, List<String>>> _parseCsvInBackground(Uint8List bytes) async {
  debugPrint('[_parseCsvInBackground] Started in isolate. Bytes length: ${bytes.length}');
  Map<String, List<String>> parsedData = {};

  // try {
  //   if (bytes.isEmpty) {
  //     debugPrint('[_parseCsvInBackground] Input bytes are empty for CSV.');
  //     return parsedData;
  //   }
  //   final String csvString = String.fromCharCodes(bytes);
  //   final List<List<dynamic>> csvData = const CsvToListConverter().convert(csvString);

  //   if (csvData.isNotEmpty) {
  //     List<String> columns = [];
  //     for (var cell in csvData.first) {
  //       columns.add(cell?.toString() ?? 'Unnamed Column');
  //     }
  //     debugPrint('[_parseCsvInBackground] Columns extracted from CSV first row: $columns');
  //     if (columns.isNotEmpty) {
  //       parsedData['CSV Data'] = columns;
  //     } else {
  //       debugPrint('[_parseCsvInBackground] CSV first row was empty or contained no valid column names.');
  //     }
  //   } else {
  //     debugPrint('[_parseCsvInBackground] CSV data is empty (no rows).');
  //   }
  // } catch (e) {
  //   debugPrint('[_parseCsvInBackground] Error during CSV parsing: $e');
  //   rethrow;
  // }
  debugPrint('[_parseCsvInBackground] Finished in isolate. Parsed data map: $parsedData');
  return parsedData;
}

class FileColumnsController extends BaseController<FileColumnsStates> {
  // Initial state is FileColumnsInitialState
  FileColumnsController() : super(FileColumnsInitialState());

  Future<void> parseFile(html.File file, BuildContext context) async {
    debugPrint('[FileColumnsController] Starting parseFile. File: ${file.name}');
    // Emit loading state with a message
    emit(FileColumnsLoadingState(message: context.text.preparingToParseFile)); // Assuming context.text.preparingToParseFile exists

    try {
      final reader = html.FileReader();
      final completer = Completer<Uint8List>();

      reader.onLoadEnd.listen((e) {
        if (reader.readyState == html.FileReader.DONE) {
          debugPrint('[FileColumnsController] FileReader onloadend DONE');
          completer.complete(reader.result as Uint8List);
        }
      });
      reader.onError.listen((e) {
        debugPrint('[FileColumnsController] FileReader onError: ${reader.error}');
        completer.completeError("Failed to read file: ${reader.error}");
      });

      debugPrint('[FileColumnsController] Calling readAsArrayBuffer...');
      reader.readAsArrayBuffer(file);
      final bytes = await completer.future;
      debugPrint('[FileColumnsController] readAsArrayBuffer completed. Bytes length: ${bytes.length}');

      final fileName = file.name;
      final fileExtension = fileName.split('.').last.toLowerCase();

      Map<String, List<String>> parsedColumns = {};

      if (fileExtension == 'xlsx' || fileExtension == 'xls') {
        debugPrint('[FileColumnsController] File type: Excel. Calling _parseExcelInBackground via compute...');
        emit(FileColumnsLoadingState(message: context.text.parsingExcelFile)); // emit loading message
        parsedColumns = await compute(_parseExcelInBackground, bytes);
        debugPrint('[FileColumnsController] Excel parsing complete.');

        if (parsedColumns.isEmpty) {
          emit(FileColumnsEmptyState(message: context.text.noSheetsOrDataFound));
          return;
        }
      } else if (fileExtension == 'csv') {
        debugPrint('[FileColumnsController] File type: CSV. Calling _parseCsvInBackground via compute...');
        emit(FileColumnsLoadingState(message: context.text.parsingCsvFile)); // emit loading message
        parsedColumns = await compute(_parseCsvInBackground, bytes);
        debugPrint('[FileColumnsController] CSV parsing complete.');

        if (parsedColumns.isEmpty || (parsedColumns.containsKey('CSV Data') && parsedColumns['CSV Data']!.isEmpty)) {
          emit(FileColumnsEmptyState(message: context.text.noColumnsFoundInCsv));
          return;
        }
        if (bytes.isEmpty && parsedColumns.isEmpty) {
          emit(FileColumnsEmptyState(message: context.text.emptyCsvFile));
          return;
        }
      } else {
        emit(FileColumnsErrorState("${context.text.unsupportedFileFormat}: .$fileExtension."));
        debugPrint('[FileColumnsController] Unsupported file format: .$fileExtension.');
        return;
      }

      // If parsing is successful and columns are found
      emit(FileColumnsSuccessState(parsedColumns));
      debugPrint('[FileColumnsController] File parsing succeeded. State emitd to success.');
    } catch (e) {
      emit(FileColumnsErrorState("${context.text.errorParsingFile}: $e"));
      debugPrint("[FileColumnsController] Caught error during file processing: $e");
    }
  }

  @override
  void init() {
    // TODO: implement init
  }
}
