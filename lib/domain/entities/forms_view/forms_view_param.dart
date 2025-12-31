class FormsViewParam {
  final String instanceId;
  final String? password;

  FormsViewParam({
    required this.instanceId,
    this.password,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['p_identifier'] = instanceId;
    if (password != null) {
      map['p_password'] = password;
    }
    return map;
  }
}
