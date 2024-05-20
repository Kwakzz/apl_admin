// ignore_for_file: must_be_immutable
import 'package:apl_admin/widgets/text.dart';
import 'package:flutter/material.dart';

class StandingsTable extends StatelessWidget {

  const StandingsTable(
    {
      super.key,
      required this.standingsTeams,
    }
  );

  final List<dynamic> standingsTeams;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: MediaQuery.of(context).size.width*0.04,
        dividerThickness: 0.4,
        columns: const <DataColumn>[

          // pos
          DataColumn(
            label: HeaderText(
              text: 'Pos',
              color: Color.fromARGB(255, 53, 52, 52),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),

          // name
          DataColumn(
            label: HeaderText(
              text: 'Club',
              color: Color.fromARGB(255, 53, 52, 52),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),

          // played
          DataColumn(
            label: HeaderText(
              text: 'PL',
              color: Color.fromARGB(255, 53, 52, 52),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),

          // wins
          DataColumn(
            label: HeaderText(
              text: 'W',
              color: Color.fromARGB(255, 53, 52, 52),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),

          // draws      
          DataColumn(
            label: HeaderText(
              text: 'D',
              color: Color.fromARGB(255, 53, 52, 52),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),

          // losses      
          DataColumn(
            label: HeaderText(
              text: 'L',
              color: Color.fromARGB(255, 53, 52, 52),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),

          // goal scored      
          DataColumn(
            label: HeaderText(
              text: 'GS',
              color: Color.fromARGB(255, 53, 52, 52),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),

          // goal conceded      
          DataColumn(
            label: HeaderText(
              text: 'GC',
              color: Color.fromARGB(255, 53, 52, 52),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),

          // goal difference

          DataColumn(
            label: HeaderText(
              text: 'GD',
              color: Color.fromARGB(255, 53, 52, 52),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),


          // points      
          DataColumn(
            label: HeaderText(
              text: 'PTS',
              color: Color.fromARGB(255, 53, 52, 52),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],

        rows: standingsTeams.map((standingsTeam) => DataRow(
            cells: [

              // pos
              DataCell(
                HeaderText(
                  // index + 1 because index starts at 0
                  text: (standingsTeams.indexOf(standingsTeam) + 1).toString(),
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),

              // name
              DataCell(
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  
                  children: [
                    Image.network(
                      standingsTeam['team']['logo_url'],
                      width: 20,
                      height: 20,
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return const Icon(Icons.error, color: Colors.white,);
                      }
                    ),

                    const Text("  "),
                    HeaderText(
                      text: standingsTeam['team']['name_abbreviation'],
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ]

                )
              ),

              // no_played
              DataCell(
                HeaderText(
                  text:standingsTeam['matches_played'].toString(),
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),


              // goals
              DataCell(
                HeaderText(
                  text: standingsTeam['matches_won'].toString(),
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),

              DataCell(
                HeaderText(
                  text: standingsTeam['matches_drawn'].toString(),
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),

              DataCell(
                HeaderText(
                  text: standingsTeam['matches_lost'].toString(),
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),

              DataCell(
                HeaderText(
                  text: standingsTeam['goals_for'].toString(),
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),

              DataCell(
                HeaderText(
                  text: standingsTeam['goals_against'].toString(),
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),

              DataCell(
                HeaderText(
                  text: standingsTeam['goal_difference'].toString(),
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),

              DataCell(
                HeaderText(
                  text: standingsTeam['points'].toString(),
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )
        ).toList(),
      )
    );
  }
  
}