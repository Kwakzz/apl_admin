// ignore_for_file: must_be_immutable
import 'package:apl_admin/widgets/dialog_box.dart';
import 'package:apl_admin/widgets/text.dart';
import 'package:apl_admin/pages/home.dart';
import 'package:apl_admin/pages/matches/match.dart';
import 'package:apl_admin/controllers/season.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';




class FixtureCard extends StatefulWidget{

  const FixtureCard(
    {
      super.key,
      required this.fixture
    }
  );

  final Map<String,dynamic> fixture;
  
  @override
  FixtureCardState createState() => FixtureCardState();


}

class FixtureCardState extends State<FixtureCard> {


  @override
  Widget build(BuildContext context) {
    return Center(

        child: Column(
          children:[

            const SizedBox(height: 15),

            Text(
              "${widget.fixture['competition']['name']} (${widget.fixture['competition']['gender']})",
              style: GoogleFonts.roboto(
                color: Colors.black87,
                fontSize: 13,
                fontWeight: FontWeight.w500
              )
            ),

            SizedBox(
              height: 70,

              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => Match(
                        match: widget.fixture
                      )
                    )
                  );
                },
                child: Row (
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.network(
                      widget.fixture['home_team']['logo_url'],
                      width: MediaQuery.of(context).size.width*0.2,
                      height: 40,
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return const Icon(Icons.error, color: Colors.white,);
                      }
                    ),
                    

                    Text(
                      widget.fixture['home_team']['name_abbreviation'],
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.2,
                          style: BorderStyle.solid
                        )
                      ),
                      child: Text(
                        widget.fixture['match_time'].substring(0, 5),
                        style: GoogleFonts.roboto(
                          color: const Color.fromARGB(255, 197, 50, 50),
                          fontSize: 14,
                          fontWeight: FontWeight.w600
                        )
                      ),
                      
                    ),

                    Text(
                      widget.fixture['away_team']['name_abbreviation'],
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    

                    Image.network(
                      widget.fixture['away_team']['logo_url'],
                      width: MediaQuery.of(context).size.width*0.2,
                      height: 40,
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return const Icon(Icons.error, color: Colors.white,);
                      }
                    ),
                    
                  ],
                )
              ),
            ),

            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 0.2,
                    style: BorderStyle.solid
                  )
                )
              ),
              child: TextButton(    
                onPressed: () {
                  showDialog(
                    context: context, 
                    builder: (BuildContext context) {
                      return ConfirmDialogBox(
                        title: "Delete Match",
                        message: "Are you sure you want to delete this match?",
                        onOk: () async {
                          Map <String, dynamic> response = await deleteMatch(widget.fixture['id']);

                          if (!mounted) return;

                          if (response['status']) {
                            showDialog(
                              context: context, 
                              builder: (BuildContext context) {
                                return MessageDialogBox(
                                  message: response['message'],
                                  title: 'Success', 
                                  onOk: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => const Home())
                                    );
                                  }
                                );
                              }
                            );
                          }

                          else {
                            showDialog(
                              context: context, 
                              builder: (BuildContext context) {
                                return MessageDialogBox(
                                  message: response['message'],
                                  title: 'Error', 
                                  onOk: () {
                                  }
                                );
                              }
                            );
                          }
                        },
                      );
                    }
                  );
                },
                child: RegularText(
                  text: "Delete Match",
                  color: Colors.red,
                )
              )
            ),

            const SizedBox(height: 15),

            const Divider(
              color: Colors.grey,
              thickness: 0.2,)
          ]
        )
    );
  }

}



class MatchResultCard extends StatelessWidget{

  const MatchResultCard(
    {
      super.key,
      required this.result
    }
  );


  final Map<String,dynamic> result;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Center(
        child: Column(
          children:[

            const SizedBox(height: 15),

            Text(
              "${result['competition']['name']} (${result['competition']['gender']})",
              style: GoogleFonts.poppins(
                color: Colors.black87,
                fontSize: 13,
                fontWeight: FontWeight.w500
              )
            ),


            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 0.2,
                    style: BorderStyle.solid
                  )
                )
              ),
              height: 100,
              child: Row (
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRect(
                    child: Image.network(
                      result['home_team']['logo_url'],
                      width: MediaQuery.of(context).size.width*0.2,
                      height: 40,
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return const Icon(Icons.error, color: Colors.white,);
                      }
                    ),
                  ),

                  Text(
                    result['home_team']['name_abbreviation'],
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.2,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: result['home_team_score'].toString(),
                            style: GoogleFonts.poppins(
                              color: const Color.fromARGB(255, 197, 50, 50),
                              fontSize: 15, // Set the font size for '2'
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: '   FT   ',
                            style: GoogleFonts.poppins(
                              color: const Color.fromARGB(255, 197, 50, 50),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: result['away_team_score'].toString(),
                            style: GoogleFonts.poppins(
                              color: const Color.fromARGB(255, 197, 50, 50),
                              fontSize: 15, // Set the font size for '1'
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),


                  Text(
                    result['away_team']['name_abbreviation'],
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  

                  ClipRect(
                    child: Image.network(
                      result['away_team']['logo_url'],
                      width: MediaQuery.of(context).size.width*0.2,
                      height: 40,
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return const Icon(Icons.error, color: Colors.white,);
                      }
                    ),
                  )
                ],
              )
            )
          ]
        )

      ),
      onTap: () {
       
      },
    );
  }

}

class PlayerCard extends StatelessWidget {

  const PlayerCard(
    {
      super.key, 
      required this.player
    }
  );

  final Map<String,dynamic> player;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 130,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(right:30),
        decoration:  BoxDecoration(
          image: DecorationImage(
            image:const AssetImage("assets/menu_rectangle.jpg"),
            colorFilter: ColorFilter.mode(const Color.fromARGB(255, 197, 50, 50).withOpacity(1), BlendMode.hue),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    player['first_name'],
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  Text(
                    player['last_name'],
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w900
                    )
                  ),
                ],
              )
            ),

            ClipRect(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: Image.network(
                  player['image'] ?? "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png",
                  width: 100,
                  height: 100,
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return const Icon(Icons.error, color: Colors.white,);
                  }
                ),
              )
            )
          ],
        ),
      )
  
    );
  }

}



