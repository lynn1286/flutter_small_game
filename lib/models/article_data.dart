class ArticleData {
  final String title;
  final String url;
  final String time;

  const ArticleData({
    required this.title,
    required this.time,
    required this.url,
  });

  factory ArticleData.formMap(dynamic map) {
    return ArticleData(
      title: map['title'] ?? '未知',
      url: map['link'] ?? '',
      time: map['niceDate'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Article{title: $title, url: $url, time: $time}';
  }
}
