abstract class BaseException implements Exception {}

class ServerException implements BaseException {
  final int statusCode;
  final String statusMessage;
  final String dataMessage;

  ServerException({required this.statusCode, required this.statusMessage, required this.dataMessage});

  String get codeMessage {
    switch (statusCode) {
      case 100:
        return 'Continue';
      case 101:
        return 'Switching Protocols';
      case 102:
        return 'Processing';
      case 103:
        return 'Early Hints';
      // 2xx
      case 200:
        return 'OK';
      case 201:
        return 'Created';
      case 202:
        return 'Accepted';
      case 203:
        return 'Non-Authoritative Information';
      case 204:
        return 'No Content';
      case 205:
        return 'Reset Content';
      case 206:
        return 'Partial Content';
      case 207:
        return 'Multi-Status';
      case 208:
        return 'Already Reported';
      case 218:
        return 'This is fine';
      case 226:
        return 'IM Used';
      // 3xx
      case 300:
        return 'Multiple Choices';
      case 301:
        return 'Moved Permanently';
      case 302:
        return 'Found';
      case 303:
        return 'See Other';
      case 304:
        return 'Not Modified';
      case 305:
        return 'Use Proxy';
      case 306:
        return 'Switch Proxy';
      case 307:
        return 'Temporary Redirect';
      case 308:
        return 'Permanent Redirect';
      // 4xx
      case 400:
        return 'Bad Request';
      case 401:
        return 'Unauthorized';
      case 402:
        return 'Payment Required';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not Found';
      case 405:
        return 'Method Not Allowed';
      case 406:
        return 'Not Acceptable';
      case 407:
        return 'Proxy Authentication Required';
      case 408:
        return 'Request Timeout';
      case 409:
        return 'Conflict';
      case 410:
        return 'Gone';
      case 411:
        return 'Length Required';
      case 412:
        return 'Precondition Failed';
      case 413:
        return 'Payload Too Large';
      case 414:
        return 'URI Too Long';
      case 415:
        return 'Unsupported Media Type';
      case 416:
        return 'Range Not Satisfiable';
      case 417:
        return 'Expectation Failed';
      case 419:
        return 'Page Expired';
      case 420:
        return 'Method Failure';
      case 421:
        return 'Misdirected Request';
      case 422:
        return 'Unprocessable Entity';
      case 423:
        return 'Locked';
      case 424:
        return 'Failed Dependency';
      case 425:
        return 'Too Early';
      case 426:
        return 'Upgrade Required';
      case 428:
        return 'Precondition Required';
      case 429:
        return 'Too Many Requests';
      case 430:
        return 'Request Header Fields Too Large';
      case 431:
        return 'Request Header Fields Too Large';
      case 450:
        return 'Blocked by Windows Parental Controls';
      case 451:
        return 'Unavailable For Legal Reasons';
      case 498:
        return 'Invalid Token';
      case 499:
        return 'Token Required';
      // 5xx
      case 500:
        return 'Internal Server Error';
      case 501:
        return 'Not Implemented';
      case 502:
        return 'Bad Gateway';
      case 503:
        return 'Service Unavailable';
      case 504:
        return 'Gateway Timeout';
      case 505:
        return 'HTTP Version Not Supported';
      case 506:
        return 'Variant Also Negotiates';
      case 507:
        return 'Insufficient Storage';
      case 508:
        return 'Loop Detected';
      case 509:
        return 'Bandwidth Limit Exceeded';
      case 510:
        return 'Not Extended';
      case 511:
        return 'Network Authentication Required';
      case 520:
        return 'Web Server Returned an Unknown Error';
      case 521:
        return 'Web Server Is Down';
      case 522:
        return 'Connection Timed Out';
      case 523:
        return 'Origin Is Unreachable';
      case 524:
        return 'A Timeout Occurred';
      case 525:
        return 'SSL Handshake Failed';
      case 526:
        return 'Invalid SSL Certificate';
      case 527:
        return 'Railgun Error';
      case 530:
        return 'Site is frozen';
      case 598:
        return 'Network read timeout error';
      case 599:
        return 'Network connect timeout error';
      default:
        return 'Unknown error';
    }
  }
}

class DataPersistenceException implements BaseException {}

class NoConnectionException implements BaseException {}

class CacheException implements BaseException {}

class UnknownException implements BaseException {}

class UnauthorizedException implements BaseException {
  final StackTrace stackTrace;

  UnauthorizedException({required this.stackTrace});
}

class SupabaseException implements BaseException {
  final String? message;
  final StackTrace? stackTrace;

  SupabaseException({required this.stackTrace, this.message});
  @override
  String toString() => 'SupabaseBusinessException: $message';
}

void handleSupabaseError(dynamic data) {
  final code = data?['code']?.toString();
  final message = data?['message']?.toString();

  if (code == 'P0001') {
    throw SupabaseException(stackTrace: StackTrace.current, message: message);
  }

  throw SupabaseException(stackTrace: StackTrace.current, message: message);
}
