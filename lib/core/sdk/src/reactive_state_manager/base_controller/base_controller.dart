import 'package:flutter/material.dart';

import '/core/core.dart';

abstract class BaseController<S> extends ValueNotifier<S> {
  late Storage storageLate;
  late final UserStorage storage;
  BaseController(super.value) {
    _setLocalStorage();
    init();
  }

  bool enableGlobal = true;

  void init();

  void update() {
    notifyListeners();
  }

  Future<void> _setLocalStorage() async {
    storage = Modular.get<UserStorage>();
    storageLate = Modular.get<Storage>();
    await storageLate.initialize();
  }

  // UserEntity? get user => storageLate.user;
  // SelectUnitEntity? get selectedUnit => storageLate.selectedUnit;
  // List<ProgramEntity> get programs => storageLate.programs;

  void emit(S state) {
    if (value == null) return;
    value = state;
  }

  void successMensage(BuildContext context, String message) {
    SnackBar snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
      ),
      margin: const EdgeInsets.only(bottom: 20, left: 30),
      content: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void errorMessage(BuildContext context, String message) {
    SnackBar snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.startToEnd,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
      ),
      margin: const EdgeInsets.only(bottom: 20, left: 30),
      content: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    (value is DisposableBuildContext) ? (value as DisposableBuildContext).dispose() : null;
    super.dispose();
  }
}
