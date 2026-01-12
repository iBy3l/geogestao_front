import 'package:geogestao_front/domain/entities/entities.dart';

class ClientEntity {
  final String id;
  final String organizationId;
  final String name;
  final String cnpj;
  final String address;
  final double latitude;
  final double longitude;
  final ClientStatus status;
  final DateTime createdAt;
  final String? ownerName;
  final String? phone;
  final String? email;
  ClientEntity({
    this.id = '',
    this.organizationId = '',
    this.name = '',
    this.cnpj = '',
    this.address = '',
    this.latitude = 0.0,
    this.longitude = 0.0,
    required this.status,
    this.ownerName,
    this.phone,
    this.email,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory ClientEntity.fromJson(Map<String, dynamic>? json) {
    return ClientEntity(
      id: json?['id'] ?? '',
      organizationId: json?['organization_id'] ?? '',
      name: json?['name'] ?? '',
      cnpj: json?['cnpj'] ?? '',
      address: json?['address'] ?? '',
      latitude: (json?['latitude'] != null)
          ? double.tryParse(json!['latitude'].toString()) ?? 0.0
          : 0.0,
      longitude: (json?['longitude'] != null)
          ? double.tryParse(json!['longitude'].toString()) ?? 0.0
          : 0.0,
      status: (json?['status'] != null)
          ? ClientStatus.values.firstWhere(
              (e) => e.name == json!['status'],
              orElse: () => ClientStatus.lead,
            )
          : ClientStatus.lead,
      createdAt: (json?['created_at'] != null)
          ? DateTime.tryParse(json!['created_at']) ?? DateTime.now()
          : DateTime.now(),
      ownerName: json?['owner_name'],
      phone: json?['phone'],
      email: json?['email'],
    );
  }
}

class ParsedAddress {
  final String street;
  final String number;
  final String neighborhood;
  final String city;
  final String state;
  final String cep;

  ParsedAddress({
    required this.street,
    required this.number,
    required this.neighborhood,
    required this.city,
    required this.state,
    required this.cep,
  });
}
