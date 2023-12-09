import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:small_game/models/merit_record.dart';
import 'package:small_game/widgets/muyu/record_history_app_bar/record_history_app_bar.dart';
import 'package:small_game/widgets/muyu/record_history_item/record_history_item.dart';

DateFormat format = DateFormat('yyyy年MM月dd日 HH:mm:ss');

class RecordHistory extends StatelessWidget {
  final List<MeritRecord> records;

  const RecordHistory({Key? key, required this.records}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RecordHistoryAppBar(),
      body: ListView.builder(
        itemBuilder: (_, index) => RecordHistoryItem(
          merit: records[index],
        ),
        itemCount: records.length,
      ),
    );
  }
}
