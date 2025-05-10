import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

class ApiProvider extends GetxService {
  static const String _baseUrl = 'https://newsapi.org/v2';
  static const String _apiKey = '0e467a83338341c09702e8737e1cf73d'; // NewsAPI.org API key

  late final dio.Dio _dio;

  @override
  void onInit() {
    super.onInit();
    _dio = dio.Dio(
      dio.BaseOptions(
        baseUrl: _baseUrl,
        queryParameters: {'apiKey': _apiKey},
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
  }

  Future<dio.Response> getTopHeadlines({String? category, String? query}) async {
    try {
      final response = await _dio.get(
        '/top-headlines',
        queryParameters: {
          'country': 'us',
          if (category != null) 'category': category,
          if (query != null) 'q': query,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dio.Response> searchNews(String query) async {
    try {
      final response = await _dio.get(
        '/everything',
        queryParameters: {
          'q': query,
          'sortBy': 'publishedAt',
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
} 