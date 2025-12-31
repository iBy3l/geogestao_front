import 'package:flutter/material.dart';

import '/core/menu_global/menu_model.dart';

class MenuGlobalController extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  int _hoveredIndex = -1;
  int get hoveredIndex => _hoveredIndex;

  final ValueNotifier<bool> _isExpanded = ValueNotifier<bool>(true);
  ValueNotifier<bool> get isExpanded => _isExpanded;

  void checkCurrentRoute(String path, List<MenuModel> menuItems) {
    final currentPath = path.split('?').first;
    int foundIndex = -1;
    for (int i = 0; i < menuItems.length; i++) {
      if (menuItems[i].route == currentPath) {
        foundIndex = i;
        break;
      }
      if (menuItems[i].subMenu != null) {
        for (var subItem in menuItems[i].subMenu!) {
          if (subItem.route == currentPath) {
            foundIndex = i; // Select the parent menu item
            break;
          }
        }
      }
      if (foundIndex != -1) break;
    }
    if (foundIndex != -1) {
      _selectedIndex = foundIndex;
    } else {
      _selectedIndex = 0;
    }
    notifyListeners();
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void isHoveredOnEnter(int index) {
    _hoveredIndex = index;
    notifyListeners();
  }

  void isHoveredOnExit() {
    _hoveredIndex = -1;
    notifyListeners();
  }

  void expand() {
    isExpanded.value = true;
  }

  void collapse() {
    isExpanded.value = false;
  }

  void onEnter() {
    // Implement if needed for mobile hover
  }

  void onExit() {
    // Implement if needed for mobile hover
  }

  void startCollapseTimer() {
    // Implement if needed for timed collapse
  }
}
