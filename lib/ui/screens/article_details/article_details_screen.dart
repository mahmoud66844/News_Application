import 'package:flutter/material.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/ui/utils/app_colors.dart';
import 'package:news_app/ui/utils/extension/context_extension.dart';

class ArticleDetailsScreen extends StatelessWidget {
  final Article article;
  const ArticleDetailsScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.source?.name ?? ""),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                article.title ?? "",
                style: context.textTheme.titleLarge, 
              ),
              const SizedBox(height: 8),
              Text(
                article.description ?? "",
                style: context.textTheme.labelMedium?.copyWith(color: AppColors.grey),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    "By: ${article.author ?? "Unknown"}",
                    style: const TextStyle(
                      color: Colors.blue, 
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                article.publishedAt ?? "",
                style: context.textTheme.labelMedium?.copyWith(color: AppColors.grey),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(onPressed: (){}, icon: const Icon(Icons.facebook)),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.close)),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.email_outlined)),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.link)),
                ],
              ),
              const SizedBox(height: 16),
              if (article.urlToImage != null)
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(article.urlToImage!),
                    ),
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.black54,
                      child: Icon(Icons.play_arrow, color: Colors.white, size: 40),
                    ),
                  ],
                ),
              const SizedBox(height: 8),
              Text(
                  "National headlines from ABC News Catch up on the developing stories making headlines.", // Placeholder
                  style: context.textTheme.labelMedium?.copyWith(color: AppColors.grey)
              ),
              const SizedBox(height: 16),
              Text(
                article.content ?? "",
                style: context.textTheme.bodyMedium?.copyWith(
                    fontSize: 18, 
                    height: 1.5
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
