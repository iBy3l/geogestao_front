// =============== ENTIDADES BÁSICAS ===============
class ContentItem {
  final String id;
  final String label; // ex: "Opção 1"
  final String? key; // ex: "a", "b" para Select
  const ContentItem({required this.id, required this.label, this.key});

  ContentItem copyWith({String? id, String? label, String? key}) => ContentItem(id: id ?? this.id, label: label ?? this.label, key: key ?? this.key);

  Map<String, dynamic> toJson() => {'id': id, 'label': label, 'key': key};
  factory ContentItem.fromJson(Map<String, dynamic> j) => ContentItem(id: j['id'], label: j['label'] ?? '', key: j['key']);
}
