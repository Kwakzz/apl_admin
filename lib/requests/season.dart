import 'dart:convert';
import 'package:apl_admin/requests/patch.dart';

import 'get.dart';
import 'post.dart';

String _path = '/season/';

/// This function sends a POST request to the server to create a season.
Future<Map<String, dynamic>> createSeason(
  String name,
  String startDate,
  String endDate,
) async {

  return postData(
    '${_path}create/',
    jsonEncode(<String, String> {
      'name': name,
      'start_date': startDate,
      'end_date': endDate,
    })
  );

}

// This function sends a GET request to the server to get a list of all APL seasons.
Future<List<Map<String,dynamic>>> getSeasons () async {
  
    return fetchListWithoutQueryParams(
      '${_path}get/',
    );
    
}


/// This function sends a GET request to the server to get the list of fixtures. Fixtures are the matches that are yet to be played.
Future<List<Map<String,dynamic>>> getSeasonFixtures () async {
  
    return fetchListWithoutQueryParams(
      '${_path}fixtures/get/',
    );
    
}


/// This function sends a GET request to the server to the list of results in a season. Results are the matches that have been played.
Future<List<Map<String,dynamic>>> getSeasonResults (int seasonId) async {
  
    return fetchListWithQueryParams(
      '${_path}results/get',
      {
        'season_id': seasonId.toString(),
      }
    );
    
}

/// This function sends a GET request to the server to the list of latest results in a season. Results are the matches that have been played.
Future<List<Map<String,dynamic>>> getLatestResults () async {
  
    return fetchListWithoutQueryParams(
      '${_path}results/latest/get/',
    );
    
}

/// This function sends a GET request to the server to get the matchdays in a season.
/// A matchday is a group of matches that are played on the same day.
Future<List<Map<String,dynamic>>> getSeasonMatchdays (int seasonId) async {
  
    return fetchListWithQueryParams(
      '${_path}match_days/get',
      {
        'season_id': seasonId.toString(),
      }
    );
    
}

/// This function sends a POST request to the server to create a matchday in a season.
Future<Map<String, dynamic>> createMatchday(
  int seasonId,
  String date,
  int number,
) async {

  return postData(
    'match_day/create/',
    jsonEncode(<String, String> {
      'season_id': seasonId.toString(),
      'date': date,
      'number': number.toString(),
    })
  );

}


/// This function sends a GET request to the server to get the list of matches in a matchday.
Future<List<Map<String,dynamic>>> getMatchdayMatches (int matchdayId) async {
  
    return fetchListWithQueryParams(
      'match_day/matches/get',
      {
        'match_day_id': matchdayId.toString(),
      }
    );
    
}

/// This function sends a POST request to the server to create a match in a matchday. This function is used if a match has a stage.
Future<Map<String, dynamic>> createMatchWithStage(
  int matchdayId,
  int refereeId,
  String time,
  int homeTeamId,
  int awayTeamId,
  int competitionId,
  int stageId
) async {

  return postData(
    'match/create/',
    jsonEncode(<String, String> {
      'match_day': matchdayId.toString(),
      'referee': refereeId.toString(),
      'match_time': time,
      'home_team': homeTeamId.toString(),
      'away_team': awayTeamId.toString(),
      'competition': competitionId.toString(),
      'stage': stageId.toString()
    })
  );

}


/// This function sends a POST request to the server to create a match in a matchday. This function is used if a match does not have a stage.
Future<Map<String, dynamic>> createMatchWithoutStage(
  int matchdayId,
  int refereeId,
  String time,
  int homeTeamId,
  int awayTeamId,
  int competitionId,
) async {

  return postData(
    'match/create/',
    jsonEncode(<String, String> {
      'match_day': matchdayId.toString(),
      'referee': refereeId.toString(),
      'match_time': time,
      'home_team': homeTeamId.toString(),
      'away_team': awayTeamId.toString(),
      'competition': competitionId.toString(),
    })
  );

}


/// This function sends a PATCH request to the server to set a match's has_started field to true.
Future<Map<String, dynamic>> startMatch(int matchId) async {

  return update(
    'match/update/${matchId.toString()}/',
    jsonEncode(<String, bool> {
      'has_started': true,
    })
  );
}


/// This function sends a PATCH request to the server to set a match's has_ended field to true.
Future<Map<String, dynamic>> endMatch(int matchId) async {

  return update(
    'match/update/${matchId.toString()}/',
    jsonEncode(<String, bool> {
      'has_ended': true,
    })
  );
}

/// This function sends a PATCH request to the server to set a match's has_ended field to false.
Future<Map<String, dynamic>> restartMatch(int matchId) async {

  return update(
    'match/update/${matchId.toString()}/',
    jsonEncode(<String, bool> {
      'has_ended': false,
    })
  );
}


/// This function sends a GET request to the server to get all competitions
/// This function sends a GET request to the server to get the list of matches in a matchday.
Future<List<Map<String,dynamic>>> getCompetitions () async {
  
    return fetchListWithoutQueryParams(
      'competition/get/',
    );
    
}

/// This function sends a GET request to the server to get all stages
Future <List<Map<String,dynamic>>> getStages () async {
  return fetchListWithoutQueryParams(
    'stage/get/',
  );
}