class GetListFormsParam {
  final String? search;
  final int? limit;
  final int? offset;

  GetListFormsParam({this.search, this.limit, this.offset});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    if (search != null) {
      map['p_search'] = search;
    }
    if (limit != null) {
      map['p_limit'] = limit;
    }
    if (offset != null) {
      map['p_offset'] = offset;
    }
    return map;
  }
}
