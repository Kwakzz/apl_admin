import 'dart:convert';

import 'delete.dart';
import 'get.dart';
import 'post.dart';

String _path = '/match_event/';

/// This function sends a GET request to the server to get a list of the events in a match.
Future<List<Map<String,dynamic>>> getMatchEvents (int matchId) async {
  
    return fetchListWithQueryParams(
      '${_path}get',
      {
        'match_id': matchId.toString(),
      }
    );
    
}


/// This function sends a GET request to the server to get a list of the events in a match by team.
Future<List<Map<String,dynamic>>> getMatchEventsByTeam (int matchId, int teamId) async {
  
    return fetchListWithQueryParams(
      '${_path}team/get',
      {
        'match_id': matchId.toString(),
        'team_id': teamId.toString(),
      }
    );
    
}


/// This function sends a POST request to the server to create a booking
Future<Map<String,dynamic>> createBooking (int matchId, int playerId, int teamId, int minute, String cardType) async {

  String eventUrlComponent = "";

  if (cardType == "Yellow Card") {
    eventUrlComponent = 'yellow_card';
  }
  if (cardType == "Red Card") {
    eventUrlComponent = 'red_card';
  }
  
  return postData(
    '$_path$eventUrlComponent/create/',
    jsonEncode(
      {
        'match': matchId.toString(),
        'player': playerId.toString(),
        'team': teamId.toString(),
        'minute': minute,
        'event_type': cardType,
      }
    )
      
  );
    
}

/// This function deletes a match event.
Future<Map<String,dynamic>> deleteMatchEvent (int matchEventId) async {
  
    return delete(
      '${_path}delete/$matchEventId/',
    );
    
}


