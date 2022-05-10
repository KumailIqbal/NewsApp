import 'dart:convert';

import 'package:news_app/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<Article> news = [];

  Future<void> getNews() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=e38b6026e4174f2784d731ff47463eb8";

    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null && element["content"]!=null && element["author"] != null) {
          Article article = Article(
              author: element["author"],
              content: element["content"],
              description: element["description"],
              title: element["title"],
              url: element["url"],
              urlToImage: element["urlToImage"]);
          news.add(article);
        }
      });
    }
  }
}

class CategoryNewsClass {
  List<Article> news = [];

  Future<void> getNews(String category) async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=e38b6026e4174f2784d731ff47463eb8";

    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null && element["content"]!=null && element["author"] != null) {
          Article article = Article(
              author: element["author"],
              content: element["content"],
              description: element["description"],
              title: element["title"],
              url: element["url"],
              urlToImage: element["urlToImage"]);
          news.add(article);
        }
      });
    }
  }
}
