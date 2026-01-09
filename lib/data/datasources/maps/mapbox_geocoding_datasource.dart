import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class MapboxGeocodingDatasource {
  Future<Map<String, dynamic>> search(String query, String token);
  Future<Map<String, dynamic>> autocomplete(String query, String token);
  Future<Map<String, dynamic>> getAddressByCep(String cep);
}

class MapboxGeocodingDatasourceImpl implements MapboxGeocodingDatasource {
  static const _baseUrl = 'https://brasilapi.com.br/api/cep/v1';
  @override
  Future<Map<String, dynamic>> search(String query, String token) async {
    final url = Uri.parse(
      'https://api.mapbox.com/geocoding/v5/mapbox.places/'
      '${Uri.encodeComponent(query)}.json'
      '?access_token=$token'
      '&country=BR'
      '&language=pt'
      '&limit=1',
    );

    final response = await http.Client().get(url);
    if (response.statusCode != 200) return {};

    final decoded = jsonDecode(response.body);

    // 🔒 PROTEÇÃO WEB
    if (decoded is! Map<String, dynamic>) {
      return {};
    }

    return decoded;
  }

  @override
  Future<Map<String, dynamic>> autocomplete(String query, String token) async {
    final url = Uri.parse(
      'https://api.mapbox.com/geocoding/v5/mapbox.places/'
      '${Uri.encodeComponent(query)}.json'
      '?access_token=$token'
      '&country=BR'
      '&language=pt'
      '&limit=5'
      '&autocomplete=true',
    );

    final response = await http.Client().get(url);
    if (response.statusCode != 200) return {};

    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic>) return {};

    return decoded;
  }

  @override
  Future<Map<String, dynamic>> getAddressByCep(String cep) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$cep'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao buscar CEP');
    }

    return jsonDecode(response.body);
  }
}
