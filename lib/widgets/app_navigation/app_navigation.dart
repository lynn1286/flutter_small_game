import 'package:flutter/material.dart';
import 'package:small_game/models/menu_data.dart';
import 'package:small_game/pages/article/article.dart';
import 'package:small_game/pages/guess/guess_number.dart';
import 'package:small_game/pages/muyu/muyu.dart';
import 'package:small_game/pages/paper/paper.dart';
import 'package:small_game/widgets/app_bottom_bar/app_bottom_bar.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int _index = 0;
  final PageController _ctrl = PageController();

  final List<MenuData> menus = const [
    MenuData(label: '猜数字', icon: Icons.question_mark),
    MenuData(label: '电子木鱼', icon: Icons.my_library_music_outlined),
    MenuData(label: '画板绘制', icon: Icons.palette_outlined),
    MenuData(label: '网络文章', icon: Icons.article_outlined),
  ];

  void _onChangePage(int index) {
    _ctrl.jumpToPage(index);
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(),
      bottomNavigationBar: AppBottomBar(
        currentIndex: _index,
        onItemTap: _onChangePage,
        menus: menus,
      ),
    );
  }

  Widget _buildContent() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _ctrl,
      children: const [
        GuessNumber(title: "猜数字"),
        Muyu(title: "电子木鱼"),
        Paper(title: "画板绘制"),
        Article(
          title: "网络文章",
        ),
      ],
    );
  }
}
