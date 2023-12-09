import 'package:dio/dio.dart';
import 'package:small_game/models/article_data.dart';

class ArticleApi {
  static const String kBaseUrl = 'https://www.wanandroid.com';

  final Dio _client = Dio(BaseOptions(baseUrl: kBaseUrl));

  Future<List<ArticleData>> loadArticles(int page) async {
    String path = '/article/list/$page/json';

    var rep = await _client.get(path);
    if (rep.statusCode == 200) {
      if (rep.data != null) {
        var data = rep.data['data']['datas'] as List;
        return data.map(ArticleData.formMap).toList();
      }
    }
    return [];
  }
}
