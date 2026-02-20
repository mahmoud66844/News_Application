import 'package:flutter/material.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/ui/screens/article_details/article_details_screen.dart';
import 'package:news_app/ui/utils/extension/context_extension.dart';
import 'package:news_app/ui/utils/extension/int_extensions.dart';


class NewsWidget extends StatelessWidget {
  final Article article;

  const NewsWidget({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetailsScreen(article: article),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: context.secondaryColor),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                article.urlToImage ?? "",
                height: MediaQuery.of(context).size.height * .2,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            12.verticalSpace(),
            Text(
              article.title ?? "",
              style: context.textTheme.bodyMedium,
            ),
            12.verticalSpace(),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "By : ${article.author}",
                    style: context.textTheme.labelMedium,
                  ),
                ),
                10.horizontalSpace(),
                Text(
                  "${article.publishedAt}",
                  style: context.textTheme.labelMedium,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
