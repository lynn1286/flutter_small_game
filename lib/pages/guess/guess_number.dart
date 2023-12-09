import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:small_game/storage/sp_storage.dart';
import 'package:small_game/widgets/guess/build_result_notice/build_result_notice.dart';
import 'package:small_game/widgets/guess/guess_app_bar/guess_app_bar.dart';

class GuessNumber extends StatefulWidget {
  const GuessNumber({super.key, required this.title});

  final String title;

  @override
  State<GuessNumber> createState() => _GuessNumberState();
}

class _GuessNumberState extends State<GuessNumber>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int _value = 0;
  bool _guessing = false;
  bool? _isGuess;
  late AnimationController animationController;

  final TextEditingController _guessController = TextEditingController();
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _initConfig();
  }

  void _initConfig() async {
    Map<String, dynamic> config = await SpStorage.instance.readGuessConfig();
    _guessing = config['guessing'] ?? false;
    _value = config['value'] ?? 0;
    setState(() {});
  }

  void _generateRandomValue() {
    setState(() {
      _guessing = true;
      _value = _random.nextInt(100);
      SpStorage.instance.saveGuessConfig(guessing: _guessing, value: _value);
    });
  }

  void _onCheck() {
    int? guessValue = int.tryParse(_guessController.text);

    if (!_guessing || guessValue == null) {
      Fluttertoast.showToast(
        msg: "请点击右下方按钮开始游戏",
        gravity: ToastGravity.CENTER,
      );
      return;
    }

    if (guessValue > 100) {
      Fluttertoast.showToast(
        msg: "请输入 0~99 数字",
        gravity: ToastGravity.CENTER,
      );
      return;
    }

    animationController.forward(from: 0);
    //猜对了
    if (guessValue == _value) {
      Fluttertoast.showToast(
        msg: "恭喜您猜对了！🎉",
        gravity: ToastGravity.CENTER,
      );
      setState(() {
        _isGuess = null;
        _guessing = false;
      });
      SpStorage.instance.saveGuessConfig(guessing: _guessing, value: _value);

      return;
    }

    // 猜错了
    setState(() {
      _isGuess = guessValue > _value;
    });
  }

  @override
  void dispose() {
    _guessController.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: GuessAppBar(
        onCheck: _onCheck,
        controller: _guessController,
      ),
      body: Stack(children: [
        if (_isGuess != null)
          Column(
            children: [
              if (_isGuess!)
                BuildResultNotice(
                  message: '大了',
                  color: Colors.redAccent,
                  controller: animationController,
                ),
              const Spacer(),
              if (!_isGuess!)
                BuildResultNotice(
                  message: '小了',
                  color: Colors.blueAccent,
                  controller: animationController,
                ),
            ],
          ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (!_guessing)
                const Text(
                  '点击生成随机数值',
                  style: TextStyle(color: Colors.black),
                ),
              Text(
                _guessing ? "**" : '$_value',
                style: const TextStyle(color: Colors.black, fontSize: 60),
              ),
            ],
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _guessing ? null : _generateRandomValue,
        backgroundColor: _guessing ? Colors.grey : Colors.blue,
        tooltip: 'Increment',
        child: const Icon(Icons.generating_tokens_outlined),
      ),
    );
  }
}
