import 'package:flutter/material.dart';

class RecordHistoryAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const RecordHistoryAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      centerTitle: true,
      title: const Text(
        '功德记录',
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
    );
  }
}
