import 'package:flutter/material.dart';

class ClientParam {
  final String address;
  final String cnpj;
  final String latitude;
  final String longitude;
  final String name;
  final ClientStatus status;
  final String? ownerName;
  final String? phone;
  final String? email;
  ClientParam({
    required this.address,
    required this.cnpj,
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.status,
    this.ownerName,
    this.phone,
    this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      "p_address": address,
      "p_cnpj": cnpj,
      "p_latitude": latitude,
      "p_longitude": longitude,
      "p_name": name,
      "p_status": status.name,
      if (ownerName != null) "p_owner_name": ownerName,
      if (phone != null) "p_phone": phone,
      if (email != null) "p_email": email,
    };
  }

  ClientParam copyWith({
    String? address,
    String? cnpj,
    String? latitude,
    String? longitude,
    String? name,
    ClientStatus? status,
    String? ownerName,
    String? phone,
    String? email,
  }) {
    return ClientParam(
      address: address ?? this.address,
      cnpj: cnpj ?? this.cnpj,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      name: name ?? this.name,
      status: status ?? this.status,
      ownerName: ownerName ?? this.ownerName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> importToMap() {
    return {
      'name': name,
      'cnpj': cnpj,
      'owner_name': ownerName,
      'phone': phone,
      'email': email,
      'address': address,
      'latitude': latitude.isEmpty ? null : latitude,
      'longitude': longitude.isEmpty ? null : longitude,
      'status': status.name,
    };
  }
}

enum ClientStatus {
  active('Ativo', Colors.green),
  inactive('Inativo', Colors.red),
  lead('Lead', Colors.blue),
  cold('Frio', Colors.grey);

  final String decription;
  final Color color;

  const ClientStatus(this.decription, this.color);

  String get name => toString().split('.').last;
}
