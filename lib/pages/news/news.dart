import 'package:apl_admin/helper/widgets/future_builder.dart';
import 'package:apl_admin/helper/widgets/menu_widgets.dart';
import 'package:apl_admin/pages/news/create_news.dart';
import 'package:apl_admin/requests/news.dart';
import 'package:flutter/material.dart';

class News extends StatefulWidget {
  const News({
     super.key,
  });

  @override
  NewsState createState() => NewsState();

}

class NewsState extends State<News> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Column(
        children: [

          const SizedBox(
            height: 15,
          ),

          ListViewHeading(
            heading: "News", 
            buttonText: "Add News Item", 
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateNewsItem()),
              );
            }
          ),

          const SizedBox(
            height: 15,
          ),

          Expanded(
            child: AppFutureBuilder(
              future: getNewsItems(), 
              builder: (data) {
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return NewsTile(
                      news: data[index],
                    );
                  },
                );
              }, 
              errorText: "news items"
            )
          ),
        ],
      ),
    );
  }
}
