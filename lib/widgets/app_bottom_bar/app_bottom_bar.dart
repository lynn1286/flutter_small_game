import 'package:flutter/material.dart';
import 'package:small_game/models/menu_data.dart';

class AppBottomBar extends StatelessWidget {
  final int currentIndex;
  final List<MenuData> menus;
  final ValueChanged<int>? onItemTap;

  const AppBottomBar({
    super.key,
    this.onItemTap,
    this.currentIndex = 0,
    required this.menus,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      onTap: onItemTap,
      currentIndex: currentIndex,
      elevation: 3,
      type: BottomNavigationBarType.fixed,
      iconSize: 22,
      selectedItemColor: Theme.of(context).primaryColor,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      showUnselectedLabels: true,
      showSelectedLabels: true,
      items: menus.map(_buildItemByMenuMeta).toList(),
    );
  }

  BottomNavigationBarItem _buildItemByMenuMeta(MenuData menu) {
    return BottomNavigationBarItem(
      label: menu.label,
      icon: Icon(menu.icon),
    );
  }
}
