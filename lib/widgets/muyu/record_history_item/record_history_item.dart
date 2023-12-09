import 'package:flutter/material.dart';
import 'package:small_game/models/merit_record.dart';
import 'package:small_game/pages/muyu/record_history.dart';

class RecordHistoryItem extends StatelessWidget {
  final MeritRecord merit;

  const RecordHistoryItem({super.key, required this.merit});

  @override
  Widget build(BuildContext context) {
    String date =
        format.format(DateTime.fromMillisecondsSinceEpoch(merit.timestamp));

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        backgroundImage: AssetImage(merit.image),
      ),
      title: Text('功德 +${merit.value}'),
      subtitle: Text(merit.audio),
      trailing: Text(
        date,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }
}
