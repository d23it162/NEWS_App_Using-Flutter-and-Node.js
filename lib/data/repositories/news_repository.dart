import 'package:get/get.dart';
import '../providers/api_provider.dart';
import '../../domain/entities/article.dart';

class NewsRepository extends GetxService {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  Future<List<Article>> getTopHeadlines({String? category, String? query}) async {
    try {
      final response = await _apiProvider.getTopHeadlines(
        category: category,
        query: query,
      );
      
      final List<dynamic> articles = response.data['articles'];
      return articles.map((json) => Article.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Article>> searchNews(String query) async {
    try {
      final response = await _apiProvider.searchNews(query);
      final List<dynamic> articles = response.data['articles'];
      return articles.map((json) => Article.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
} 