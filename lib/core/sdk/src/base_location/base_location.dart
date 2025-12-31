import '/core/core.dart';

abstract class IBaseLocation {
  Future<LocationData> getLocation();
}

class BaseLocation extends IBaseLocation {
  Location location;
  BaseLocation(this.location);

  @override
  Future<LocationData> getLocation() async {
    PermissionStatus permissionGranted;

    bool serviceEnabled;
    LocationData locationData;
    serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {}
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {}
    }
    locationData = await location.getLocation();
    return locationData;
  }
}
