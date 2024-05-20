// ignore_for_file: must_be_immutable
import 'package:apl_admin/util/date_time.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class NewsItem extends StatelessWidget {

  const NewsItem(
    {
      super.key,
      required this.news
    }
  );

  final Map<String,dynamic> news;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Image.network(
          news['featured_image'],
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            news['title'],
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 10),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "${news['tag']['name']} | ${formatDateIntoWords(news['pub_date'])}",
            style: GoogleFonts.roboto(
              fontSize: 12,
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "By ${news['author']['first_name']} ${news['author']['last_name']}",
            style: GoogleFonts.roboto(
              fontSize: 12,
            ),
          ),
        ),



        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            news['text'],
            style: GoogleFonts.roboto(
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

}
