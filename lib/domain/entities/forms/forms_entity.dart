import '/domain/entities/forms/access_mode.dart';

class FormsListResponses {
  final PaginationForms paginationForms;
  final List<FormsEntity> forms;

  FormsListResponses({required this.paginationForms, required this.forms});

  factory FormsListResponses.fromJson(Map<String, dynamic>? json) {
    return FormsListResponses(
      paginationForms: PaginationForms.fromJson(json?['pagination']),
      forms: (json?['data'] as List<dynamic>? ?? []).map((e) => FormsEntity.fromJson(e as Map<String, dynamic>?)).toList(),
    );
  }
}

class PaginationForms {
  final int page;
  final int limit;
  final int offset;
  final int totalItems;
  final int totalPages;

  PaginationForms({required this.totalItems, required this.limit, required this.offset, required this.totalPages, required this.page});

  factory PaginationForms.fromJson(Map<String, dynamic>? json) {
    return PaginationForms(page: json?['page'] ?? 0, totalItems: json?['total_items'] ?? 0, limit: json?['limit'] ?? 0, offset: json?['offset'] ?? 0, totalPages: json?['total_pages'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {"page": page, "limit": limit, "offset": offset, "total_items": totalItems, "total_pages": totalPages};
  }
}

class FormsEntity {
  final String id;
  final String name;
  final String slug;
  final int responsesCount;
  final String ownerName;
  final String teamName;
  final bool isPublished;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String ownerEmail;
  final AccessMode accessMode;

  FormsEntity({
    required this.id,
    required this.name,
    required this.slug,
    required this.responsesCount,
    required this.ownerName,
    required this.teamName,
    this.isPublished = false,
    required this.createdAt,
    required this.updatedAt,
    required this.ownerEmail,
    required this.accessMode,
  });

  factory FormsEntity.fromJson(Map<String, dynamic>? json) {
    return FormsEntity(
      id: json?['id'] ?? '',
      name: json?['name'] ?? '',
      slug: json?['slug'] ?? '',
      responsesCount: json?['responses_count'] ?? 0,
      ownerName: json?['owner_name'] ?? '',
      teamName: json?['team_name'] ?? '',
      isPublished: json?['is_published'] ?? false,
      createdAt: DateTime.parse(json?['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json?['updated_at'] ?? DateTime.now().toIso8601String()),
      ownerEmail: json?['owner_email'] ?? '',
      accessMode: AccessMode.fromString(json?['access_mode']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "slug": slug,
      "responses_count": responsesCount,
      "owner_name": ownerName,
      "team_name": teamName,
      "access_mode": accessMode.name,
      "is_published": isPublished,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
      "owner_email": ownerEmail,
    };
  }
}
