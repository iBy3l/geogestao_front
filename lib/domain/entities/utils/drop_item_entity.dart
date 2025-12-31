abstract class DropItemEntity {
  String get id;
  String get name;
  String get description;
  String get imageUrl;
  double get price;
  int get quantity;
  bool get isSelected;

  Map<String, dynamic> toJson();
}
