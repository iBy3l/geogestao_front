class SellerParam {
  final String code;
  final String name;
  final String orgId;
  SellerParam({required this.code, required this.name, required this.orgId});

  Map<String, dynamic> toMap() {
    return {"p_code": code, "p_name": name, "p_org_id": orgId};
  }
}
