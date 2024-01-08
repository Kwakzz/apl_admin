import 'get.dart';

String _path = '/team/';


/// This function sends a GET request to the server to get a list of all APL teams.
Future<List<Map<String,dynamic>>> getTeams () async {
  
    return fetchListWithoutQueryParams(
      '${_path}get/',
    );
    
}


/// This function sends a GET request to the server to get a team by id.
Future<Map<String,dynamic>> getTeam (int id) async {
  
    return fetchMap(
      '${_path}get',
      {
        'id': id.toString(),
      }
    );
    
}


/// This function sends a GET request to the server to get a list of all the men's player in a team.
Future<List<Map<String,dynamic>>> getMensPlayersInTeam (int id) async {
  
    return fetchListWithQueryParams(
      '${_path}mens_players/get',
      {
        'id': id.toString()
      }
    );
    
}

/// This function sends a GET request to the server to get a list of all the women's player in a team.
Future<List<Map<String,dynamic>>> getWomensPlayersInTeam (int id) async {
  
    return fetchListWithQueryParams(
      '${_path}womens_players/get',
      {
        'id': id.toString()
      }
    );
    
}

/// This functions retrieves a team's stats. It's combines both mens and womens team stats. 
Future<Map<String,dynamic>> getTeamStats (int id) async {
  
    return fetchMap(
      '${_path}stats/get',
      {
        'id': id.toString()
      }
    );
    
}