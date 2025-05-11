// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/home_controller.dart';
// import '../widgets/article_card.dart';
// import '../widgets/category_selector.dart';
// import '../widgets/search_bar_widget.dart';
// import '../widgets/shimmer_article_card.dart';
// import 'article_detail_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   final HomeController controller = Get.find<HomeController>();
//   final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

//   @override
//   void initState() {
//     super.initState();
//     // Ensure initial data load
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller.fetchTopHeadlines();
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final padding = size.width * 0.04;

//     return Scaffold(
//       appBar: AppBar(
//         title: GestureDetector(
//           behavior: HitTestBehavior.opaque,
//           onTap: () {
//             _refreshIndicatorKey.currentState?.show();
//             controller.fetchTopHeadlines(
//               category: controller.selectedCategory.value.isEmpty
//                   ? null
//                   : controller.selectedCategory.value,
//             );
//           },
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text('News App'),
//                 const SizedBox(width: 4),
//               ],
//             ),
//           ),
//         ),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 color: Theme.of(context).colorScheme.surface,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Theme.of(context).shadowColor.withOpacity(0.1),
//                     blurRadius: 4,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SearchBarWidget(
//                     key: const ValueKey('search_bar'),
//                     controller: _searchController,
//                     showClear: _searchController.text.isNotEmpty,
//                     onClear: () {
//                       _searchController.clear();
//                       controller.searchNews('');
//                     },
//                     onSubmitted: controller.searchNews,
//                   ),
//                   Obx(() => CategorySelector(
//                         key: const ValueKey('category_selector'),
//                         categories: HomeController.categories,
//                         selectedCategory: controller.selectedCategory.value,
//                         onCategorySelected: controller.changeCategory,
//                       )),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Obx(() {
//                 if (controller.isLoading.value) {
//                   return ListView.separated(
//                     key: const ValueKey('shimmer_list'),
//                     padding: EdgeInsets.all(padding),
//                     itemCount: 5,
//                     separatorBuilder: (context, index) => SizedBox(height: padding),
//                     itemBuilder: (context, index) => ShimmerArticleCard(
//                       key: ValueKey('shimmer_$index'),
//                     ),
//                   );
//                 }

//                 if (controller.errorMessage.isNotEmpty) {
//                   return SingleChildScrollView(
//                     child: Padding(
//                       padding: EdgeInsets.all(padding * 2),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SizedBox(height: size.height * 0.1),
//                           Icon(
//                             Icons.error_outline,
//                             size: size.width * 0.15,
//                             color: Theme.of(context).colorScheme.error,
//                           ),
//                           const SizedBox(height: 16),
//                           Text(
//                             controller.errorMessage.value,
//                             textAlign: TextAlign.center,
//                             style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                                   color: Theme.of(context).colorScheme.error,
//                                 ),
//                           ),
//                           const SizedBox(height: 16),
//                           FilledButton.icon(
//                             onPressed: () => controller.fetchTopHeadlines(
//                               category: controller.selectedCategory.value.isEmpty
//                                   ? null
//                                   : controller.selectedCategory.value,
//                             ),
//                             icon: const Icon(Icons.refresh),
//                             label: const Text('Try Again'),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }

//                 if (controller.articles.isEmpty) {
//                   return SingleChildScrollView(
//                     child: Padding(
//                       padding: EdgeInsets.all(padding * 2),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SizedBox(height: size.height * 0.1),
//                           Icon(
//                             Icons.search_off,
//                             size: size.width * 0.15,
//                             color: Theme.of(context).colorScheme.onSurfaceVariant,
//                           ),
//                           const SizedBox(height: 16),
//                           Text(
//                             'No articles found',
//                             textAlign: TextAlign.center,
//                             style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                                   color: Theme.of(context).colorScheme.onSurfaceVariant,
//                                 ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }

//                 return RefreshIndicator(
//                   key: _refreshIndicatorKey,
//                   onRefresh: () => controller.fetchTopHeadlines(
//                     category: controller.selectedCategory.value.isEmpty
//                         ? null
//                         : controller.selectedCategory.value,
//                   ),
//                   child: ListView.builder(
//                     key: const ValueKey('articles_list'),
//                     padding: EdgeInsets.all(padding),
//                     itemCount: controller.articles.length,
//                     itemBuilder: (context, index) {
//                       final article = controller.articles[index];
//                       return Padding(
//                         key: ValueKey('article_${article.url}'),
//                         padding: EdgeInsets.only(bottom: padding),
//                         child: Hero(
//                           tag: article.url,
//                           child: ArticleCard(
//                             article: article,
//                             onTap: () => Get.to(
//                               () => ArticleDetailScreen(article: article),
//                               transition: Transition.rightToLeft,
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// } 

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../widgets/article_card.dart';
import '../widgets/category_selector.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/shimmer_article_card.dart';
import 'article_detail_screen.dart';
import '../../domain/entities/article.dart';
import 'package:hive/hive.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final HomeController controller = Get.find<HomeController>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchTopHeadlines();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = size.width * 0.04;

    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Saved Articles',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Expanded(
                child: FutureBuilder<Box<Article>>(
                  future: Hive.openBox<Article>('saved_articles'),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final box = snapshot.data!;
                    if (box.isEmpty) {
                      return const Center(child: Text('No saved articles'));
                    }
                    return ListView.builder(
                      itemCount: box.length,
                      itemBuilder: (context, index) {
                        final article = box.getAt(index)!;
                        return ListTile(
                          title: Text(
                            article.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              await box.delete(article.url);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Article deleted'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                              setState(() {}); // Refresh the drawer
                            },
                            tooltip: 'Delete Article',
                          ),
                          onTap: () {
                            Get.back(); // Close the drawer
                            Get.to(
                              () => ArticleDetailScreen(article: article),
                              transition: Transition.rightToLeft,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              title: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  _refreshIndicatorKey.currentState?.show();
                  controller.fetchTopHeadlines(
                    category: controller.selectedCategory.value.isEmpty
                        ? null
                        : controller.selectedCategory.value,
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('News App'),
                    const SizedBox(width: 4),
                  ],
                ),
              ),
              centerTitle: true,
              elevation: 0,
            ),
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SearchBarWidget(
                      key: const ValueKey('search_bar'),
                      controller: _searchController,
                      showClear: _searchController.text.isNotEmpty,
                      onClear: () {
                        _searchController.clear();
                        controller.searchNews('');
                      },
                      onSubmitted: controller.searchNews,
                    ),
                    Obx(() => CategorySelector(
                          key: const ValueKey('category_selector'),
                          categories: HomeController.categories,
                          selectedCategory: controller.selectedCategory.value,
                          onCategorySelected: controller.changeCategory,
                        )),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(padding),
              sliver: Obx(() {
                if (controller.isLoading.value) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                        padding: EdgeInsets.only(bottom: padding),
                        child: ShimmerArticleCard(
                          key: ValueKey('shimmer_$index'),
                        ),
                      ),
                      childCount: 5,
                    ),
                  );
                }

                if (controller.errorMessage.isNotEmpty) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(padding * 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: size.height * 0.1),
                          Icon(
                            Icons.error_outline,
                            size: size.width * 0.15,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            controller.errorMessage.value,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                          ),
                          const SizedBox(height: 16),
                          FilledButton.icon(
                            onPressed: () => controller.fetchTopHeadlines(
                              category: controller.selectedCategory.value.isEmpty
                                  ? null
                                  : controller.selectedCategory.value,
                            ),
                            icon: const Icon(Icons.refresh),
                            label: const Text('Try Again'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (controller.articles.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(padding * 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: size.height * 0.1),
                          Icon(
                            Icons.search_off,
                            size: size.width * 0.15,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No articles found',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final article = controller.articles[index];
                      return Padding(
                        key: ValueKey('article_${article.url}'),
                        padding: EdgeInsets.only(bottom: padding),
                        child: Hero(
                          tag: article.url,
                          child: ArticleCard(
                            article: article,
                            onTap: () => Get.to(
                              () => ArticleDetailScreen(article: article),
                              transition: Transition.rightToLeft,
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: controller.articles.length,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hive/hive.dart';
// import '../controllers/home_controller.dart';
// import '../widgets/article_card.dart';
// import '../widgets/category_selector.dart';
// import '../widgets/search_bar_widget.dart';
// import '../widgets/shimmer_article_card.dart';
// import 'article_detail_screen.dart';
// import '../../domain/entities/article.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   final HomeController controller = Get.find<HomeController>();
//   final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller.fetchTopHeadlines();
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final padding = size.width * 0.04;

//     return Scaffold(
//       drawer: Drawer(
//         child: SafeArea(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(
//                   'Saved Articles',
//                   style: Theme.of(context).textTheme.titleLarge,
//                 ),
//               ),
//               Expanded(
//                 child: FutureBuilder<Box<Article>>(
//                   future: Hive.openBox<Article>('saved_articles'),
//                   builder: (context, snapshot) {
//                     if (!snapshot.hasData) {
//                       return const Center(child: CircularProgressIndicator());
//                     }
//                     final box = snapshot.data!;
//                     if (box.isEmpty) {
//                       return const Center(child: Text('No saved articles'));
//                     }
//                     return ListView.builder(
//                       itemCount: box.length,
//                       itemBuilder: (context, index) {
//                         final article = box.getAt(index)!;
//                         return ListTile(
//                           title: Text(
//                             article.title,
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           onTap: () {
//                             Get.back(); // Close the drawer
//                             Get.to(
//                               () => ArticleDetailScreen(article: article),
//                               transition: Transition.rightToLeft,
//                             );
//                           },
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: CustomScrollView(
//           slivers: [
//             SliverAppBar(
//               floating: true,
//               snap: true,
//               leading: Builder(
//                 builder: (context) => IconButton(
//                   icon: const Icon(Icons.menu),
//                   onPressed: () => Scaffold.of(context).openDrawer(),
//                 ),
//               ),
//               title: GestureDetector(
//                 behavior: HitTestBehavior.opaque,
//                 onTap: () {
//                   _refreshIndicatorKey.currentState?.show();
//                   controller.fetchTopHeadlines(
//                     category: controller.selectedCategory.value.isEmpty
//                         ? null
//                         : controller.selectedCategory.value,
//                   );
//                 },
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Text('News App'),
//                     const SizedBox(width: 4),
//                   ],
//                 ),
//               ),
//               centerTitle: true,
//               elevation: 0,
//             ),
//             SliverToBoxAdapter(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).colorScheme.surface,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Theme.of(context).shadowColor.withOpacity(0.1),
//                       blurRadius: 4,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     SearchBarWidget(
//                       key: const ValueKey('search_bar'),
//                       controller: _searchController,
//                       showClear: _searchController.text.isNotEmpty,
//                       onClear: () {
//                         _searchController.clear();
//                         controller.searchNews('');
//                       },
//                       onSubmitted: controller.searchNews,
//                     ),
//                     Obx(() => CategorySelector(
//                           key: const ValueKey('category_selector'),
//                           categories: HomeController.categories,
//                           selectedCategory: controller.selectedCategory.value,
//                           onCategorySelected: controller.changeCategory,
//                         )),
//                   ],
//                 ),
//               ),
//             ),
//             SliverPadding(
//               padding: EdgeInsets.all(padding),
//               sliver: Obx(() {
//                 if (controller.isLoading.value) {
//                   return SliverList(
//                     delegate: SliverChildBuilderDelegate(
//                       (context, index) => Padding(
//                         padding: EdgeInsets.only(bottom: padding),
//                         child: ShimmerArticleCard(
//                           key: ValueKey('shimmer_$index'),
//                         ),
//                       ),
//                       childCount: 5,
//                     ),
//                   );
//                 }

//                 if (controller.errorMessage.isNotEmpty) {
//                   return SliverToBoxAdapter(
//                     child: Padding(
//                       padding: EdgeInsets.all(padding * 2),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SizedBox(height: size.height * 0.1),
//                           Icon(
//                             Icons.error_outline,
//                             size: size.width * 0.15,
//                             color: Theme.of(context).colorScheme.error,
//                           ),
//                           const SizedBox(height: 16),
//                           Text(
//                             controller.errorMessage.value,
//                             textAlign: TextAlign.center,
//                             style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                                   color: Theme.of(context).colorScheme.error,
//                                 ),
//                           ),
//                           const SizedBox(height: 16),
//                           FilledButton.icon(
//                             onPressed: () => controller.fetchTopHeadlines(
//                               category: controller.selectedCategory.value.isEmpty
//                                   ? null
//                                   : controller.selectedCategory.value,
//                             ),
//                             icon: const Icon(Icons.refresh),
//                             label: const Text('Try Again'),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }

//                 if (controller.articles.isEmpty) {
//                   return SliverToBoxAdapter(
//                     child: Padding(
//                       padding: EdgeInsets.all(padding * 2),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SizedBox(height: size.height * 0.1),
//                           Icon(
//                             Icons.search_off,
//                             size: size.width * 0.15,
//                             color: Theme.of(context).colorScheme.onSurfaceVariant,
//                           ),
//                           const SizedBox(height: 16),
//                           Text(
//                             'No articles found',
//                             textAlign: TextAlign.center,
//                             style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                                   color: Theme.of(context).colorScheme.onSurfaceVariant,
//                                 ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }

//                 return SliverList(
//                   delegate: SliverChildBuilderDelegate(
//                     (context, index) {
//                       final article = controller.articles[index];
//                       return Padding(
//                         key: ValueKey('article_${article.url}'),
//                         padding: EdgeInsets.only(bottom: padding),
//                         child: Hero(
//                           tag: article.url,
//                           child: ArticleCard(
//                             article: article,
//                             onTap: () => Get.to(
//                               () => ArticleDetailScreen(article: article),
//                               transition: Transition.rightToLeft,
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                     childCount: controller.articles.length,
//                   ),
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }