import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  const ArticleView({Key? key, required this.blogUrl}) : super(key: key);
  final String blogUrl;

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  final Completer<WebViewController> completer = Completer<WebViewController>();
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
          actions: [
            Opacity(
              opacity: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.access_alarm),
              ),
            )
          ],
        ),
        body: Container(
          child: WebView(
            initialUrl: widget.blogUrl,
            onWebViewCreated: ((WebViewController webViewController) {
              completer.complete(webViewController);
            }),
          ),
        ));
  }
}
