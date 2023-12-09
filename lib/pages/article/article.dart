import 'package:flutter/material.dart';
import 'package:small_game/widgets/article/article_content.dart';

class Article extends StatefulWidget {
  final String title;
  const Article({super.key, required this.title});

  @override
  State<Article> createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const ArticleContent(),
    );
  }
}
