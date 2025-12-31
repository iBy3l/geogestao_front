abstract class FileColumnsStates {}

class FileColumnsInitialState extends FileColumnsStates {}

class FileColumnsLoadingState extends FileColumnsStates {
  final String message;
  FileColumnsLoadingState({this.message = 'Loading file...'});
}

class FileColumnsSuccessState extends FileColumnsStates {
  final Map<String, List<String>> parsedColumns;
  FileColumnsSuccessState(this.parsedColumns);
}

class FileColumnsErrorState extends FileColumnsStates {
  final String message;
  FileColumnsErrorState(this.message);
}

class FileColumnsEmptyState extends FileColumnsStates {
  final String message;
  FileColumnsEmptyState({this.message = 'No columns found.'});
}
