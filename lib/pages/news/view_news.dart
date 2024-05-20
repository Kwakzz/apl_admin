import 'package:apl_admin/widgets/news_item.dart';
import 'package:flutter/material.dart';

class ViewNews extends StatefulWidget {
  const ViewNews({
    super.key,
    required this.news,
  });

  final Map<String, dynamic> news;

  @override
  ViewNewsState createState() => ViewNewsState();
}

class ViewNewsState extends State<ViewNews> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      body: NewsItem(news: widget.news),
      backgroundColor: Colors.white),
    );
  }
}