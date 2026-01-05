import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class MapboxGeocodingDatasource {
  Future<Map<String, dynamic>> search(String query, String token);
  Future<Map<String, dynamic>> autocomplete(String query, String token);
}

class MapboxGeocodingDatasourceImpl implements MapboxGeocodingDatasource {
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
}
