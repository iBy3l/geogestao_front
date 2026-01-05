import 'package:mapbox_gl/mapbox_gl.dart';

class AddressSuggestion {
  final String label;
  final LatLng position;

  AddressSuggestion({required this.label, required this.position});
}
