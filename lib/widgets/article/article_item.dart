import 'package:flutter/material.dart';
import 'package:small_game/models/article_data.dart';

class ArticleItem extends StatelessWidget {
  final ArticleData article;
  final ValueChanged<ArticleData> onTap;

  const ArticleItem({super.key, required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(article),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Text(
                    article.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    article.time,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  article.url,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
