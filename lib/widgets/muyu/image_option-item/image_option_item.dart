import 'package:flutter/material.dart';
import 'package:small_game/models/image_option.dart';

class ImageOptionItem extends StatelessWidget {
  final ImageOption option;
  final bool active;

  const ImageOptionItem({
    Key? key,
    required this.option,
    required this.active,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Border activeBorder =
        Border.fromBorderSide(BorderSide(color: Colors.blue));
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: !active ? null : activeBorder,
      ),
      child: Column(
        children: [
          Text(option.name,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Image.asset(option.src),
            ),
          ),
          Text('每次功德 +${option.min}~${option.max}',
              style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}
