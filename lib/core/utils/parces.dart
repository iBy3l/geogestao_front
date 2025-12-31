DateTime? parseNullableDate(dynamic date) {
  if (date == null) {
    return null;
  }
  if (date is DateTime) {
    return date;
  }
  if (date is String && date.isNotEmpty) {
    try {
      return DateTime.parse(date);
    } catch (e) {
      return null;
    }
  }
  return null;
}
