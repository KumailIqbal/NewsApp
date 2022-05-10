class Article {
  late String author;
  late String title;
  late String description;
  late String url;
  late String urlToImage;
  late String content;
  Article(
      {required this.author,
      required this.content,
      required this.description,
      required this.title,
      required this.url,
      required this.urlToImage});
}
