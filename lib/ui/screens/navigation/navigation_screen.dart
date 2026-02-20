import 'package:flutter/material.dart';
import 'package:news_app/apis/api_manager.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/model/source.dart';
import 'package:news_app/ui/screens/article_details/article_details_screen.dart';
import 'package:news_app/ui/screens/navigation/tabs/news/news_tab.dart';
import 'package:news_app/ui/screens/navigation/tabs/news/news_widget.dart';
import 'package:news_app/ui/widgets/app_drawer.dart';

class NavigationScreen extends StatefulWidget {
  final AppCategory? category;
  const NavigationScreen({super.key, this.category});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    final categoryName = widget.category?.name.toLowerCase() ?? "general";
    final appBarTitle = widget.category?.name ?? "General";

    return FutureBuilder<List<Source>>(
      future: ApiManager.loadSources(categoryName),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final sources = snapshot.data!;
        return DefaultTabController(
          length: sources.length,
          child: Scaffold(
            appBar: AppBar(
              title: Text(appBarTitle),
              actions: [
                IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: NewsSearchDelegate());
                  },
                  icon: const Icon(Icons.search),
                )
              ],
              bottom: TabBar(
                isScrollable: true,
                tabs: sources.map((source) => Tab(text: source.name)).toList(),
              ),
            ),
            drawer: AppDrawer(),
            body: TabBarView(
              children: sources.map((source) => NewsTab(source.id ?? "")).toList(),
            ),
          ),
        );
      },
    );
  }
}

class NewsSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: theme.appBarTheme.copyWith(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return const Center(child: Text("Search for news"));
    }

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
        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: ListView.builder(
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
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: const Center(
        child: Text("Search for any article"),
      ),
    );
  }
}
