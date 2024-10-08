import 'dart:convert';

import 'package:apl_admin/controllers/post.dart';

import 'delete.dart';
import 'get.dart';

String _path = '/goal/';

/// This function sends a GET request to the server to get a list of the goals a team has scored in a match.
Future<List<Map<String,dynamic>>> getMatchGoalsByTeam (int matchId, int teamId) async {
  
    return fetchListWithQueryParams(
      '${_path}get_by_team',
      {
        'match_id': matchId.toString(),
        'team_id': teamId.toString(),
      }
    );
    
}


/// This function sends a POST request to the server to create a goal with an assist.
Future<Map<String,dynamic>> createGoalWithAssist (int matchId, int teamId, int scorerId, int assisterId, int minute) async {
  
    return postData(
      'match_event${_path}create/',
      jsonEncode(
        {
          'match': matchId.toString(),
          'scoring_team': teamId.toString(),
          'player': scorerId.toString(),
          'assist_provider': assisterId.toString(),
          'minute': minute,
        }
      )
       
    );
    
}


/// This function sends a POST request to the server to create a goal without an assist.
Future<Map<String,dynamic>> createGoalWithoutAssist (int matchId, int teamId, int scorerId, int minute) async {
  
    return postData(
      'match_event${_path}create/',
      jsonEncode(
        {
          'match': matchId.toString(),
          'scoring_team': teamId.toString(),
          'player': scorerId.toString(),
          'minute': minute,
        }
      )
       
    );
    
}


/// This function sends a DELETE request to the server to delete a goal.
Future<Map<String,dynamic>> deleteGoal (int id) async {
  
    return delete(
      '${_path}delete/$id/',
    );
    
}