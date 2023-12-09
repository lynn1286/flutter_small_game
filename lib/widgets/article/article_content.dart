import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:small_game/models/article_data.dart';
import 'package:small_game/pages/article/article_detail.dart';
import 'package:small_game/services/article_api.dart';
import 'package:small_game/widgets/article/article_item.dart';

class ArticleContent extends StatefulWidget {
  const ArticleContent({super.key});

  @override
  State<ArticleContent> createState() => _ArticleContentState();
}

class _ArticleContentState extends State<ArticleContent> {
  List<ArticleData> _articles = [];
  ArticleApi api = ArticleApi();

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    _loading = true;
    setState(() {});
    _articles = await api.loadArticles(0);
    _loading = false;
    setState(() {});
  }

  void _onRefresh() async {
    _articles = await api.loadArticles(0);
    setState(() {});
  }

  void _onLoad() async {
    int nextPage = _articles.length ~/ 20;
    List<ArticleData> newArticles = await api.loadArticles(nextPage);
    _articles = _articles + newArticles;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(
        child: Wrap(
          spacing: 10,
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            CupertinoActivityIndicator(),
            Text(
              "数据加载中，请稍后...",
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      );
    }

    return EasyRefresh(
      header: const ClassicHeader(
        dragText: "下拉加载",
        armedText: "释放刷新",
        readyText: "开始加载",
        processingText: "正在加载",
        processedText: "刷新成功",
      ),
      footer: const ClassicFooter(processingText: "正在加载"),
      onRefresh: _onRefresh,
      onLoad: _onLoad,
      child: ListView.builder(
        itemExtent: 80,
        itemCount: _articles.length,
        itemBuilder: _buildItemByIndex,
      ),
    );
  }

  void _jumpToPage(ArticleData article) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ArticleDetailPage(article: article),
      ),
    );
  }

  Widget _buildItemByIndex(BuildContext context, int index) {
    return ArticleItem(
      article: _articles[index],
      onTap: _jumpToPage,
    );
  }
}
