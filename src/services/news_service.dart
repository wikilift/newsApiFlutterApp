import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:news_app/src/models/category_model.dart';

import '../models/models.dart';

class NewsService extends ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';
  Map<String, List<Article>> categoryArticles = {};

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyball, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  bool _isLoading = true;

  final _baseUrl = 'https://newsapi.org/v2';
  final _apiKey = '?apiKey=abebf8208ee2419fae269a272bf4b4b6';
  List<Article> headLines = [];
  NewsService() {
    getTopHeadlines();
    categories.forEach((item) {
      categoryArticles[item.name] = [];
    });

    getArticlesByCategory(_selectedCategory);
  }

  String get selectedCategory => _selectedCategory;
  set selectedCategory(String value) {
    _selectedCategory = value;
    getArticlesByCategory(value);
    notifyListeners();
  }

  Future getArticlesByCategory(String category) async {
    if (categoryArticles[category] != null && categoryArticles[category]!.isNotEmpty) {
      return categoryArticles[category];
    }
    final url = '$_baseUrl/top-headlines$_apiKey&country=gb&laguange=es&category=$category';
    final resp = await http.get(Uri.parse(url));

    final newsResponse = newsResponseFromJson(resp.body);
    // print(resp.body);

    try {
      /*newsResponse.articles!.forEach(
        (element) => categoryArticles[category]!.add(element),
      );*/
      categoryArticles[category]!.addAll(newsResponse.articles!);

      // headlines = newsResponse.articles!;
      // newsResponse.articles!.forEach((element) => headLines.add(element));
    } on Exception catch (e) {
      print(e);
      return false;
    }

    notifyListeners();
    return true;
  }

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  get getArticlesSelectedCategory => categoryArticles[selectedCategory];

  Future<bool> getTopHeadlines() async {
    final url = '$_baseUrl/top-headlines$_apiKey&country=gb&laguange=es';
    final resp = await http.get(Uri.parse(url));

    final newsResponse = newsResponseFromJson(resp.body);
    // print(resp.body);

    try {
      // headlines = newsResponse.articles!;
      headLines.addAll(newsResponse.articles!);
      //newsResponse.articles!.forEach((element) => headLines.add(element));
    } on Exception catch (e) {
      print(e);
      return false;
    }

    print(headLines.length);
    notifyListeners();
    return true;
  }
}
