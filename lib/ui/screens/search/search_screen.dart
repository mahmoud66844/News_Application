import 'package:flutter/material.dart';
import 'package:news_app/apis/api_manager.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/ui/screens/article_details/article_details_screen.dart';
import 'package:news_app/ui/screens/navigation/tabs/news/news_widget.dart';

class SearchScreen extends StatelessWidget {
  final String query;
  const SearchScreen({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    // Note: This widget is used inside a SearchDelegate, so it doesn't need its own Scaffold.
    return FutureBuilder<List<Article>>(
      future: ApiManager.searchArticles(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No results found."));
        }
        final articles = snapshot.data!;
        return ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ArticleDetailsScreen(article: articles[index]),
                  ),
                );
              },
              child: NewsWidget(article: articles[index]),
            );
          },
        );
      },
    );
  }
}
