import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/views/article_view.dart';
import 'package:news_app/views/category_news.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = <CategoryModel>[];
  List<Article> articles = <Article>[];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Flutter"),
              Text(
                "News",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
        body: _loading
            ? Center(
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Container(
                          height: 70,
                          child: ListView.builder(
                              itemCount: categories.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return CategoryTile(
                                    imageUrl: categories[index].imageUrl,
                                    categoryName:
                                        categories[index].categoryName);
                              })),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: ListView.builder(
                          itemCount: articles.length,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return BlogTile(
                              imageUrl: articles[index].urlToImage,
                              title: articles[index].title,
                              desc: articles[index].description,
                              url: articles[index].url,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ));
  }
}

class CategoryTile extends StatelessWidget {
  const CategoryTile({Key? key, this.imageUrl, this.categoryName})
      : super(key: key);

  final imageUrl, categoryName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(
                    category: categoryName.toString().toLowerCase())));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                height: 60,
                width: 120,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black26),
              child: Text(
                categoryName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  const BlogTile({Key? key, this.imageUrl, this.title, this.desc, this.url})
      : super(key: key);

  final imageUrl, title, desc, url;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url)));
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            ClipRRect(
              child: Image.network(imageUrl),
              borderRadius: BorderRadius.circular(6),
            ),
            SizedBox(height: 6),
            Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87),
            ),
            SizedBox(height: 6),
            Text(
              desc,
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
