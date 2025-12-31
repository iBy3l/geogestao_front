import 'package:flutter/material.dart';

import '/core/core.dart';

class MenuModel {
  final IconData icon;
  final String label;
  final String route;
  final List<SubMenuModel>? subMenu;

  MenuModel({required this.icon, required this.label, required this.route, this.subMenu});

  Map<String, dynamic> toJson() {
    return {'icon': icon, 'label': label, 'route': route, 'subMenu': subMenu?.map((item) => item.toJson()).toList()};
  }

  static List<MenuModel> getMenuItems(BuildContext context) {
    return [
      MenuModel(icon: context.icon.dashboard, label: context.text.dashboard, route: '/dashboard'),
      MenuModel(icon: context.icon.uploadFile, label: context.text.uploadFile, route: '/upload_file'),
      MenuModel(icon: context.icon.reports, label: context.text.reports, route: '/reports'),
      MenuModel(icon: context.icon.templates, label: context.text.templates, route: '/templates'),
      MenuModel(icon: context.icon.settingsIcon, label: context.text.settings, route: '/settings'),
    ];
  }
}

class SubMenuModel {
  final IconData icon;
  final String label;
  final String route;

  SubMenuModel({required this.icon, required this.label, required this.route});

  Map<String, dynamic> toJson() {
    return {'icon': icon, 'label': label, 'route': route};
  }
}
