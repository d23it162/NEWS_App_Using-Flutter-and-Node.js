// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:timeago/timeago.dart' as timeago;
// import '../../domain/entities/article.dart';

// class ArticleCard extends StatelessWidget {
//   final Article article;
//   final VoidCallback onTap;

//   const ArticleCard({
//     super.key,
//     required this.article,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       clipBehavior: Clip.antiAlias,
//       child: InkWell(
//         onTap: onTap,
//         child: ConstrainedBox(
//           constraints: const BoxConstraints(maxHeight: 600), // Adjusted to approximate ListView item height
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               if (article.urlToImage != null)
//                 AspectRatio(
//                   aspectRatio: 16 / 9,
//                   child: ConstrainedBox(
//                     constraints: const BoxConstraints(maxHeight: 300), // Limit image height
//                     child: CachedNetworkImage(
//                       imageUrl: article.urlToImage!,
//                       fit: BoxFit.cover,
//                       placeholder: (context, url) => Container(
//                         color: Theme.of(context).colorScheme.surfaceVariant,
//                         child: const Center(
//                           child: CircularProgressIndicator(),
//                         ),
//                       ),
//                       errorWidget: (context, url, error) => Container(
//                         color: Theme.of(context).colorScheme.errorContainer,
//                         child: Center(
//                           child: Icon(
//                             Icons.error_outline,
//                             size: 48,
//                             color: Theme.of(context).colorScheme.error,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               Flexible(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           article.title,
//                           style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                                 fontWeight: FontWeight.bold,
//                               ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         if (article.description != null) ...[
//                           const SizedBox(height: 8),
//                           Text(
//                             article.description!,
//                             style: Theme.of(context).textTheme.bodyMedium,
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ],
//                         const SizedBox(height: 8),
//                         Row(
//                           children: [
//                             if (article.source != null) ...[
//                               Flexible(
//                                 child: Text(
//                                   article.source!,
//                                   style: Theme.of(context).textTheme.bodySmall,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                               const SizedBox(width: 8),
//                               const Text('•'),
//                               const SizedBox(width: 8),
//                             ],
//                             Text(
//                               timeago.format(article.publishedAt),
//                               style: Theme.of(context).textTheme.bodySmall,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:hive/hive.dart';
import '../../domain/entities/article.dart';

class ArticleCard extends StatelessWidget {
  final Article article;
  final VoidCallback onTap;

  const ArticleCard({
    super.key,
    required this.article,
    required this.onTap,
  });

  void _saveArticle(context) async {
    final box = await Hive.openBox<Article>('saved_articles');
    if (!box.containsKey(article.url)) {
      await box.put(article.url, article);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Article  saved!'),
        ),
      );
    } else {
      // Optionally, show a message that the article is already saved
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Article already saved!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 600),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (article.urlToImage != null)
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 300),
                    child: CachedNetworkImage(
                      imageUrl: article.urlToImage!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Theme.of(context).colorScheme.errorContainer,
                        child: Center(
                          child: Icon(
                            Icons.error_outline,
                            size: 48,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          article.title,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (article.description != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            article.description!,
                            style: Theme.of(context).textTheme.bodyMedium,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Row(
                                children: [
                                  if (article.source != null) ...[
                                    Flexible(
                                      child: Text(
                                        article.source!,
                                        style:
                                            Theme.of(context).textTheme.bodySmall,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text('•'),
                                    const SizedBox(width: 8),
                                  ],
                                  Text(
                                    timeago.format(article.publishedAt),
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.save_alt_outlined),
                              onPressed: () {
                                _saveArticle(context);
                              },
                              tooltip: 'Save Article',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
