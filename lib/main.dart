import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/theme/app_theme.dart';
import 'data/providers/api_provider.dart';
import 'data/repositories/news_repository.dart';
import 'presentation/controllers/home_controller.dart';
import 'presentation/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  void _initializeServices() {
    Get.put(ApiProvider());
    Get.put(NewsRepository());
    Get.put(HomeController());
  }

  @override
  Widget build(BuildContext context) {
    _initializeServices();

    return GetMaterialApp(
      title: 'News App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: HomeScreen(),
      defaultTransition: Transition.cupertino,
    );
  }
}
