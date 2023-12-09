import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:small_game/storage/db_storage/db_storage.dart';
import 'package:small_game/widgets/app_navigation/app_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbStorage.instance.open(); // 打开数据库

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '小游戏',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent,
          ),
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      home: const AppNavigation(),
    );
  }
}
