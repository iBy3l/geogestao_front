import 'package:flutter/material.dart';
import '/core/core.dart';
import '/shared/widgets/spaces/space_widget.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget child;
  final Meta? metas;
  const ResponsiveLayout({super.key, required this.child, this.metas});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  late final List<MenuModel> menuModel = MenuModel.getMenuItems(context);

  final MenuGlobalController _menuController = MenuGlobalController();

  @override
  void initState() {
    super.initState();
    final menuModel = MenuModel.getMenuItems(context);
    _menuController.checkCurrentRoute(Modular.to.path, menuModel);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Modular.to.addListener(() {
      final currentPath = Modular.to.path.split('?').first;
      final index = menuModel.indexWhere((item) => item.route == currentPath);
      _menuController.setSelectedIndex(index != -1 ? index : 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SelectionArea(
      child: ListenableBuilder(
        listenable: _menuController,
        builder: (context, child) {
          return CustomScaffold(
            metas: widget.metas,
            appBar: size.width < 600
                ? AppBar(
                    backgroundColor: Colors.white,
                    title: Image.asset(
                      // color: context.theme.colorScheme.primary, // This line causes an error as color property is not directly available for Image.asset
                      context.image.logoPrimary,
                      height: 30,
                    ),
                  )
                : null,
            drawer: size.width < 600
                ? Drawer(
                    child: Column(
                      children: [
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                          ),
                          child: Center(
                            child: Image.asset(
                              // color: context.theme.colorScheme.primary,
                              context.image.logoPrimary,
                              height: 40,
                            ),
                          ),
                        ),
                        Expanded(
                          child: MenuGlobal(menuController: _menuController, menuModel: menuModel, isMobile: true),
                        ),
                      ],
                    ),
                  )
                : null,
            body: size.width > 600
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ValueListenableBuilder<bool>(
                              valueListenable: _menuController.isExpanded,
                              builder: (context, value, c) {
                                return Row(
                                  children: [
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      width: value ? 224 : 48,
                                      child: Center(
                                        child: Tooltip(
                                          message: context.text.appName,
                                          child: value
                                              ? Padding(
                                                  padding: const EdgeInsets.all(16.0),
                                                  child: Image.asset(
                                                    // color: context.theme.colorScheme.primary,
                                                    context.image.logoPrimary,
                                                    height: 40,
                                                  ),
                                                )
                                              : Text(
                                                  'S',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(color: context.theme.colorScheme.primary, fontSize: 24, fontWeight: FontWeight.bold),
                                                ),
                                        ),
                                      ),
                                    ),
                                    VerticalDivider(color: Colors.grey.shade200, width: 24),
                                  ],
                                );
                              },
                            ),
                            Row(
                              spacing: 16,
                              children: [
                                // plano
                                Container(
                                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(45)),
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Pro Plan',
                                        style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.primary),
                                      ),
                                      Icon(Icons.workspace_premium, color: Theme.of(context).colorScheme.primary),
                                    ],
                                  ),
                                ),
                                Icon(Icons.notifications_none, color: Theme.of(context).colorScheme.primary),
                                CircleAvatar(radius: 16, backgroundColor: Theme.of(context).colorScheme.primary),
                                SizedBox(width: 16),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // MenuGlobal(menuController: _menuController, menuModel: menuModel),
                            Expanded(child: widget.child),
                          ],
                        ),
                      ),
                    ],
                  )
                : widget.child,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _menuController.dispose();
    super.dispose();
  }
}

class MenuGlobal extends StatelessWidget {
  final bool isMobile;
  final MenuGlobalController menuController;
  final List<MenuModel> menuModel;

  const MenuGlobal({super.key, required this.menuController, required this.menuModel, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: menuController,
      builder: (context, c) {
        return MouseRegion(
          onEnter: isMobile ? (_) => menuController.onEnter() : null,
          onExit: isMobile ? (_) => menuController.onExit() : null,
          child: ValueListenableBuilder<bool>(
            valueListenable: menuController.isExpanded,
            builder: (context, isExpanded, child) {
              return AnimatedContainer(
                duration: isMobile == false ? const Duration(milliseconds: 300) : Duration.zero,
                width: isMobile == false ? (isExpanded ? 235 : 60) : 235,
                decoration: isMobile == false
                    ? const BoxDecoration(
                        color: Colors.white,
                        border: Border(right: BorderSide(color: Colors.grey, width: 0.1)),
                      )
                    : null,
                child: Column(
                  children: [
                    SpaceWidget.medium(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: menuModel.length,
                        itemBuilder: (_, index) {
                          final item = menuModel[index];
                          final isSelected = menuController.selectedIndex == index;
                          final isHovered = menuController.hoveredIndex == index;

                          if (item.subMenu != null && item.subMenu!.isNotEmpty) {
                            return ExpansionTile(
                              key: PageStorageKey(item.label), // Keep the expanded state
                              leading: Icon(item.icon, size: 16),
                              title: isMobile || isExpanded ? Text(item.label) : const SizedBox.shrink(),
                              initiallyExpanded: isSelected, // Expand if the parent is selected
                              onExpansionChanged: (expanded) {
                                if (expanded) {
                                  menuController.selectedIndex = index;
                                  if (isMobile == false) {
                                    menuController.expand();
                                    menuController.startCollapseTimer();
                                  }
                                } else {
                                  // Optionally handle collapse if needed, e.g., reset selectedIndex if no sub-item is active
                                }
                              },
                              children: item.subMenu!.map((subItem) {
                                final isSubSelected = Modular.to.path.split('?').first == subItem.route;
                                return Padding(
                                  padding: const EdgeInsets.only(left: 20.0), // Indent sub-menu items
                                  child: ListTile(
                                    hoverColor: Colors.blue.shade50,
                                    leading: Icon(subItem.icon, size: 16),
                                    title: isMobile || isExpanded
                                        ? Text(
                                            subItem.label,
                                            style: TextStyle(fontWeight: isSubSelected ? FontWeight.w700 : FontWeight.w400, color: isSubSelected ? Theme.of(context).primaryColor : null),
                                          )
                                        : null,
                                    selected: isSubSelected,
                                    selectedTileColor: Colors.blue.shade50,
                                    onTap: () {
                                      Modular.to.pushReplacementNamed(subItem.route);
                                      // No need to set parent selected index here, as ExpansionTile handles its expansion
                                    },
                                  ),
                                );
                              }).toList(),
                            );
                          } else {
                            // Existing ListTile for menu items without sub-menus
                            return MouseRegion(
                              onEnter: (_) => menuController.isHoveredOnEnter(index),
                              onExit: (_) => menuController.isHoveredOnExit(),
                              child: ListTile(
                                hoverColor: Colors.blue.shade50,
                                leading: Icon(item.icon, size: 16),
                                title: isMobile || isExpanded ? Text(item.label, style: TextStyle(fontWeight: isHovered ? FontWeight.w700 : FontWeight.w400)) : null,
                                selected: isSelected,
                                selectedTileColor: Colors.blue.shade50,
                                onTap: () {
                                  menuController.selectedIndex = index;
                                  if (isMobile == false) {
                                    menuController.expand();
                                    menuController.startCollapseTimer();
                                  }
                                  Modular.to.pushReplacementNamed(item.route);
                                },
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    if (isMobile || isExpanded)
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            children: [
                              const Text('Need help?', style: TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              const Text('Check documentation or support.', style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                                child: const Text('View Docs'),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
