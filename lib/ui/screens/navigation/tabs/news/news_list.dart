import 'package:flutter/material.dart';


import '../../../../../apis/api_manager.dart';
import '../../../../../model/article.dart';
import '../../../../../model/source.dart';
import '../../../../widgets/app_error_widget.dart';
import 'news_widget.dart';

class NewsList extends StatelessWidget {
  final Source source;

  const NewsList({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiManager.loadArticles(source.id!),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return AppErrorWidget(message: snapshot.error.toString());
          } else if (snapshot.hasData) {
            List<Article> articles = snapshot.data!;
            return ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return NewsWidget(
                    article: articles[index],
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
