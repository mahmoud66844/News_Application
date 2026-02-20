import 'package:flutter/material.dart';
import 'package:news_app/apis/api_manager.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/ui/screens/navigation/tabs/news/news_widget.dart';
import 'package:news_app/ui/widgets/app_error_widget.dart';

class NewsTab extends StatelessWidget {
  final String sourceId;
  const NewsTab(this.sourceId, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
        future: ApiManager.loadArticles(sourceId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return AppErrorWidget(message: snapshot.error.toString());
          } else if (snapshot.hasData) {
            return buildNewsList(snapshot.data!);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget buildNewsList(List<Article> articles) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return NewsWidget(article: articles[index]);
      },
    );
  }
}
