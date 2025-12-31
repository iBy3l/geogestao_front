import 'package:flutter_dotenv/flutter_dotenv.dart';

class StringsConst {
  String get baseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  String get apikey => dotenv.env['API_KEY'] ?? '';
  String get mapbox => dotenv.env['MAPBOX_ACCESS_TOKEN'] ?? '';
}
