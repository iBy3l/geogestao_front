import 'package:flutter/material.dart';

class MapTooltipController extends ChangeNotifier {
  Offset? position;
  ClientMapData? client;

  void show(Offset pos, ClientMapData data) {
    position = pos;
    client = data;
    notifyListeners();
  }

  void hide() {
    position = null;
    client = null;
    notifyListeners();
  }
}

class ClientMapData {
  final String id;
  final String name;
  final String status;
  final String address;

  ClientMapData({required this.id, required this.name, required this.status, required this.address});
}
