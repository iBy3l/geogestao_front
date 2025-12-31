import '/core/core.dart';

abstract class IAddRegisterAdapter {
  void registerAdapter(HiveInterface hive);
}

class AddRegisterAdapter extends IAddRegisterAdapter {
  @override
  void registerAdapter(HiveInterface hive) {}
}
