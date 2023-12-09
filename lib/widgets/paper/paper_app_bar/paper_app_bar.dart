import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:small_game/widgets/paper/back_up_buttons/back_up_buttons.dart';

class PaperAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onClear;
  final String title;
  final VoidCallback? onBack;
  final VoidCallback? onRevocation;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const PaperAppBar({
    Key? key,
    required this.title,
    required this.onClear,
    required this.onBack,
    required this.onRevocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: BackUpButtons(onBack: onBack, onRevocation: onRevocation),
      leadingWidth: 100,
      title: Text(
        title,
        style: const TextStyle(color: Colors.black, fontSize: 16),
      ),
      actions: [
        IconButton(
            splashRadius: 20,
            onPressed: onClear,
            icon: const Icon(
              CupertinoIcons.delete,
              color: Colors.black,
              size: 20,
            ))
      ],
    );
  }
}
