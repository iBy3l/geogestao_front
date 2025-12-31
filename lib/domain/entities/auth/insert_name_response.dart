class InsertNameResponse {
  final int code;
  final String status;
  final String message;

  InsertNameResponse({
    required this.code,
    required this.message,
    required this.status,
  });

  factory InsertNameResponse.fromJson(Map<String, dynamic>? json) {
    return InsertNameResponse(
      code: json?['code'] as int? ?? 200,
      message: json?['msg'] ?? '',
      status: json?['error_code'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'msg': message,
      'error_code': status,
    };
  }
}
