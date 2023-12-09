import 'dart:math';

import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:small_game/models/audio_option.dart';
import 'package:small_game/models/image_option.dart';
import 'package:small_game/models/merit_record.dart';
import 'package:small_game/pages/muyu/record_history.dart';
import 'package:small_game/storage/db_storage/db_storage.dart';
import 'package:small_game/storage/sp_storage.dart';
import 'package:small_game/widgets/muyu/animate_text/animate_text.dart';
import 'package:small_game/widgets/muyu/audio_option_panel/audio_option_panel.dart';
import 'package:small_game/widgets/muyu/image_option_panel/image_option_panel.dart';
import 'package:small_game/widgets/muyu/muyu_image/muyu_image.dart';
import 'package:small_game/widgets/muyu/count_panel/count_panel.dart';
import 'package:uuid/uuid.dart';

class Muyu extends StatefulWidget {
  final String title;
  const Muyu({super.key, required this.title});

  @override
  State<Muyu> createState() => _MuyuState();
}

class _MuyuState extends State<Muyu> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int _counter = 0;
  int _activeImageIndex = 0;
  int _activeAudioIndex = 0;
  MeritRecord? _cruRecord;
  List<MeritRecord> _records = [];
  final Uuid uuid = const Uuid();

  AudioPool? pool;

  final Random _random = Random();

  final List<ImageOption> imageOptions = const [
    ImageOption('基础版', 'assets/images/muyu.png', 1, 3),
    ImageOption('尊享版', 'assets/images/muyu2.png', 3, 6),
  ];

  final List<AudioOption> audioOptions = const [
    AudioOption('音效1', 'muyu_1.mp3'),
    AudioOption('音效2', 'muyu_2.mp3'),
    AudioOption('音效3', 'muyu_3.mp3'),
  ];

  // 激活图像
  String get activeImage => imageOptions[_activeImageIndex].src;

  // 敲击是增加值
  int get knockValue {
    int min = imageOptions[_activeImageIndex].min;
    int max = imageOptions[_activeImageIndex].max;
    return min + _random.nextInt(max + 1 - min);
  }

  String get activeAudio => audioOptions[_activeAudioIndex].src;

  @override
  void initState() {
    super.initState();
    _initAudioPool();
    _initConfig();
  }

  void _initConfig() async {
    Map<String, dynamic> config = await SpStorage.instance.readMuYUConfig();
    _counter = config['counter'] ?? 0;
    _activeImageIndex = config['activeImageIndex'] ?? 0;
    _activeAudioIndex = config['activeAudioIndex'] ?? 0;
    _records = await DbStorage.instance.meritRecordDao.query();
    setState(() {});
  }

  void _initAudioPool() async {
    pool = await FlameAudio.createPool(
      'muyu_1.mp3',
      maxPlayers: 4,
    );
  }

  void _toHistory() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => RecordHistory(
          records: _records.reversed.toList(),
        ),
      ),
    );
  }

  void _onSelectAudio(int value) async {
    Navigator.of(context).pop();
    if (value == _activeAudioIndex) return;
    _activeAudioIndex = value;
    saveConfig();
    pool = await FlameAudio.createPool(
      activeAudio,
      maxPlayers: 1,
    );
  }

  void _onTapSwitchAudio() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return AudioOptionPanel(
          audioOptions: audioOptions,
          activeIndex: _activeAudioIndex,
          onSelect: _onSelectAudio,
        );
      },
    );
  }

  void _onSelectImage(int value) {
    Navigator.of(context).pop(); // 关闭底部弹层
    if (value == _activeImageIndex) return;
    setState(() {
      _activeImageIndex = value;
      saveConfig();
    });
  }

  void _onTapSwitchImage() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return ImageOptionPanel(
          imageOptions: imageOptions,
          activeIndex: _activeImageIndex,
          onSelect: _onSelectImage,
        );
      },
    );
  }

  void _onKnock() {
    pool?.start();
    setState(() {
      String id = uuid.v4();
      _cruRecord = MeritRecord(
        id,
        DateTime.now().millisecondsSinceEpoch,
        knockValue,
        activeImage,
        audioOptions[_activeAudioIndex].name,
      );
      _counter += _cruRecord!.value;
      saveConfig();
      DbStorage.instance.meritRecordDao.insert(_cruRecord!);
      _records.add(_cruRecord!);
    });
  }

  void saveConfig() {
    SpStorage.instance.saveMuYUConfig(
      counter: _counter,
      activeImageIndex: _activeImageIndex,
      activeAudioIndex: _activeAudioIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(onPressed: _toHistory, icon: const Icon(Icons.history))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: CountPanel(
            count: _counter,
            onTapSwitchAudio: _onTapSwitchAudio,
            onTapSwitchImage: _onTapSwitchImage,
          )),
          Expanded(
              child: Stack(
            alignment: Alignment.topCenter,
            children: [
              MuyuImage(
                image: activeImage, // 使用激活图像
                onTap: _onKnock,
              ),
              if (_cruRecord != null) AnimateText(record: _cruRecord!)
            ],
          ))
        ],
      ),
    );
  }
}
