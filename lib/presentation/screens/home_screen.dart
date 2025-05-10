import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../widgets/article_card.dart';
import '../widgets/category_selector.dart';
import '../widgets/search_bar_widget.dart';
import 'article_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final HomeController controller = Get.find<HomeController>();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SearchBarWidget(
            controller: _searchController,
            showClear: _searchController.text.isNotEmpty,
            onClear: () {
              _searchController.clear();
              controller.searchNews('');
            },
            onSubmitted: controller.searchNews,
          ),
          Obx(() => CategorySelector(
                categories: HomeController.categories,
                selectedCategory: controller.selectedCategory.value,
                onCategorySelected: controller.changeCategory,
              )),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (controller.errorMessage.isNotEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.errorMessage.value,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => controller.fetchTopHeadlines(
                          category: controller.selectedCategory.value.isEmpty
                              ? null
                              : controller.selectedCategory.value,
                        ),
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                );
              }

              if (controller.articles.isEmpty) {
                return Center(
                  child: Text(
                    'No articles found',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () => controller.fetchTopHeadlines(
                  category: controller.selectedCategory.value.isEmpty
                      ? null
                      : controller.selectedCategory.value,
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.articles.length,
                  itemBuilder: (context, index) {
                    final article = controller.articles[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ArticleCard(
                        article: article,
                        onTap: () => Get.to(
                          () => ArticleDetailScreen(article: article),
                          transition: Transition.rightToLeft,
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
} 