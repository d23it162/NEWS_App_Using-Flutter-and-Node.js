
# 📱 Flutter NewsWave

Flutter NewsWave is a modern, responsive mobile application built with Flutter and GetX that delivers real-time news updates across categories. Fetching articles directly from NewsAPI.org, the app offers a sleek user experience with category filtering, keyword-based search, article bookmarking, and a polished UI.

## 🧩 Overview

Designed with clean architecture principles, Flutter NewsWave separates concerns across data, domain, and presentation layers. It leverages GetX for efficient state management and dependency injection. With a focus on smooth UI/UX, responsive layouts, and performance, the app is suitable for real-world deployment and future scalability.

## 🎯 Features

- 📰 **View Latest News**: Displays top headlines from NewsAPI.org with shimmer loading animations.
- 🗂️ **Filter by Categories**: Horizontally scrollable, toggleable categories (e.g., Business, Tech, Sports).
- 🔍 **Search News**: Real-time search functionality with handling for empty or invalid results.
- 📄 **Detailed Article View**: Full article page with image, title, content, and external source link.
- ⭐ **Save & Manage Favorites**: Favorite/unfavorite articles stored locally using Hive or SharedPreferences.
- ♻ **Pull-to-Refresh**: Tap the app title to refresh the news feed instantly.
- 🎨 **Clean, Responsive UI**: Adaptive design with modern color palette, rounded corners, and consistent spacing.
- 📷 **Responsive Images**: Uses BoxFit and LayoutBuilder to display images cleanly on all screen sizes.
- 🧠 **GetX Integration**: State management, API handling, and navigation are all powered by GetX.

## 📸 Screenshots

- 🏠 **Home Screen (Trending news + category filters)**
  </n>
  <img src="https://github.com/user-attachments/assets/16c10d43-ee12-471b-b050-7a5972f0a5c9" alt="Home Screen" width="300"/>

- 🔎 **Search Results Screen**  
  <img src="https://github.com/user-attachments/assets/dfe9d0cb-5a1f-42ff-95ad-faaf22ca2a10" alt="Search Results Screen" width="300"/>

- 📖 **Article Details Page**  
  <img src="https://github.com/user-attachments/assets/df050345-e824-45b6-a1a4-56fdf803ca0e" alt="Article Details Page" width="300"/>

- 📌 **Favorites Screen**  
  <img src="https://github.com/user-attachments/assets/d076c8e5-af7a-4a2a-9773-e08b02b13010" alt="Favorites Screen" width="300"/>

## 🎥 Demo Video

▶️ **Demo**: [Flutter NewsWave Demo](#)  
Click [here](https://github.com/user-attachments/assets/e98beb20-8d25-4736-b335-637befbcb3ab) to watch the demo video.  
*Note*: GitHub doesn't support direct video embedding. For a better experience, consider uploading the video to a platform like YouTube or Vimeo and embedding it here.

## 🛠️ Tech Stack

**Frontend**:
- Flutter (Latest stable)  
- Dart  
- GetX  
- Hive / SharedPreferences

**API**:
- NewsAPI.org (No backend server required)

## 🧰 Installation & Setup

### 1. Prerequisites
- Flutter SDK installed  
- Dart (comes with Flutter)  
- NewsAPI.org API key

### 2. Setup

Clone the repository:
```bash
git clone https://github.com/your-username/flutter-newswave.git
cd flutter-newswave
```

Install dependencies:
```bash
flutter pub get
```

Add your NewsAPI API key:  
**Option A (recommended)**: Create a `.env` file and add:
```env
NEWS_API_KEY=your_api_key_here
```

**Option B**: Hardcode into `lib/data/providers/api_provider.dart` *(not secure for production)*

Run the app:
```bash
flutter run
```

## 🧾 Folder Structure

```
lib/
├── core/
│   └── theme/ → app_theme.dart
├── data/
│   ├── providers/ → api_provider.dart
│   ├── repositories/ → news_repository.dart
├── domain/
│   └── entities/ → article.dart, article.g.dart
├── presentation/
│   ├── controllers/ → home_controller.dart
│   ├── screens/ → home_screen.dart, article_detail_screen.dart
│   └── widgets/ → article_card.dart, category_selector.dart, search_bar_widget.dart, shimmer_article_card.dart
└── main.dart
```

## ⚠️ Known Issues

- API rate limits from NewsAPI.org’s free tier  
- Image layout may shift slightly on low-end devices  
- Favorites screen may require manual refresh  
- Minor inconsistencies in pull-to-refresh on certain devices

## 🚀 Future Upgrades

- 🔐 User Authentication (JWT-based)  
- 🌐 Cloud Favorites with MongoDB  
- 👤 Profile Page  
- 🌙 Dark Mode Toggle  
- 🔔 Push Notifications  
- 📥 Offline Article Caching  
- ✨ Animated Transitions  
- ☁ Backend Hosting (e.g., Render, Vercel)  
- ⚙️ Settings Page  
- 🗞 News Source Filters  
- 🔄 Cross-device Favorite Syncing

## 🤝 Contributing

We welcome contributions!

1. Fork the repo  
2. Create a feature branch: `git checkout -b feature/your-feature`  
3. Commit your changes: `git commit -m "Add feature"`  
4. Push your branch: `git push origin feature/your-feature`  
5. Open a Pull Request

## 📬 Contact

Created & maintained by **Dhruv Vaghasiya**  
📧 Email: vaghasiyadhruv09@gmail.com  
🔗 GitHub: [https://github.com/d23it162](https://github.com/d23it162)
