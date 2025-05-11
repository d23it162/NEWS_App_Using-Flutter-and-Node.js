import 'package:get/get.dart';
import '../../data/repositories/news_repository.dart';
import '../../domain/entities/article.dart';

class HomeController extends GetxController {
  final NewsRepository _newsRepository = Get.find<NewsRepository>();
  
  final RxList<Article> articles = <Article>[].obs;
  final RxBool isLoading = false.obs;
  final RxString selectedCategory = ''.obs;
  final RxString errorMessage = ''.obs;

  static const List<String> categories = [
    'business',
    'technology',
    'sports',
    'entertainment',
    'health',
    'science',
  ];

  @override
  void onInit() {
    super.onInit();
    fetchTopHeadlines();
  }

  Future<void> fetchTopHeadlines({String? category}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final results = await _newsRepository.getTopHeadlines(
        category: category,
      );
      
      articles.value = results;
    } catch (e) {
      errorMessage.value = 'Failed to fetch news articles. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  void changeCategory(String category) {
    if (selectedCategory.value != category) {
      selectedCategory.value = category;
      fetchTopHeadlines(category: category.isEmpty ? null : category);
    }
  }

  Future<void> searchNews(String query) async {
    if (query.isEmpty) {
      fetchTopHeadlines(category: selectedCategory.value.isEmpty ? null : selectedCategory.value);
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final results = await _newsRepository.searchNews(query);
      articles.value = results;
    } catch (e) {
      errorMessage.value = 'Failed to search news articles. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }
} 