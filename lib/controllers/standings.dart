import 'dart:convert';

import 'package:apl_admin/controllers/delete.dart';
import 'package:apl_admin/controllers/post.dart';

import 'get.dart';

String _path = '/standings/';

/// This function sends a POST request to create a men's league standings for a season.
Future<Map<String,dynamic>> createMensLeagueStandings(int seasonId) async {
  return postData(
    '${_path}league/mens/create/',
    jsonEncode(
      {
        'season': seasonId.toString()
      }
    )
  );
}

/// This function sends a POST request to create a women's league standings for a season.
Future<Map<String,dynamic>> createWomensLeagueStandings(int seasonId) async {
  return postData(
    '${_path}league/womens/create/',
    jsonEncode(
      {
        'season': seasonId.toString()
      }
    )
  );
}


/// This function sends a POST request to create a men's FA Cup group standings for a season.
Future<Map<String,dynamic>> createMensFACupStandings(int seasonId) async {
  return postData(
    '${_path}fa_cup/group/mens/create/',
    jsonEncode(
      {
        'season': seasonId.toString()
      }
    )
  );
}




/// This function retrieves all the standings for a particular season.
Future<List<Map<String,dynamic>>> getSeasonStandings (int seasonId) async{

  return fetchListWithQueryParams(
      '${_path}season/get',
      {
        'season_id': seasonId.toString(),
      }
    );
}

/// This function retrieves the men's league standings for a particular season.
Future<Map<String,dynamic>> getSeasonMensLeagueStandings (int seasonId) async{

  return fetchMap(
      '${_path}league/mens/get',
      {
        'season_id': seasonId.toString(),
      }
    );
}

/// This function retrieves the women's league standings for a particular season.
Future<Map<String,dynamic>> getSeasonWomensLeagueStandings (int seasonId) async{

  return fetchMap(
      '${_path}league/womens/get',
      {
        'season_id': seasonId.toString(),
      }
    );
}



/// This function retrieves the group standings in a men's FA Cup competition. This is a list because there are multiple groups.
Future<List<Map<String,dynamic>>> getSeasonMensFACupCompStandings (int seasonId) async{

  return fetchListWithQueryParams(
      '${_path}fa_cup/group/mens/get',
      {
        'season_id': seasonId.toString(),
      }
    );
}


Future<dynamic> getMensLatestStandings () async{

  return fetchListWithoutQueryParams(
      '${_path}mens/latest/get/',
    );
}


Future<Map<String,dynamic>> deleteStandings (int standingsId) async{

  return delete(
    '${_path}delete/$standingsId/',
  );
}
