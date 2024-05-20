import 'get.dart';

String _path = '/season/stats/';

/// This function sends a GET request to the server to get a list of the top scorers in a season.
Future<List<Map<String,dynamic>>> getSeasonTopScorers (int seasonId) async {
  
    return fetchListWithQueryParams(
      '${_path}top_scorers/get',
      {
        'season_id': seasonId.toString(),
      }
    );
    
}


/// This function sends a GET request to the server to get a list of the men's top scorers in a season.
Future<List<Map<String,dynamic>>> getSeasonMensTopScorers (int seasonId) async {
  
    return fetchListWithQueryParams(
      '${_path}mens_top_scorers/get',
      {
        'season_id': seasonId.toString(),
      }
    );
    
}

/// This function sends a GET request to the server to get a list of the women's top scorers in a season.
Future<List<Map<String,dynamic>>> getSeasonWomensTopScorers (int seasonId) async {
  
    return fetchListWithQueryParams(
      '${_path}womens_top_scorers/get',
      {
        'season_id': seasonId.toString(),
      }
    );
    
}

/// This function sends a GET request to the server to get a list of the top assisters in a season.
Future<List<Map<String,dynamic>>> getSeasonTopAssisters (int seasonId) async {
  
    return fetchListWithQueryParams(
      '${_path}top_assisters/get',
      {
        'season_id': seasonId.toString(),
      }
    );
    
}

/// This function sends a GET request to the server to get a list of the men's top assisters in a season.
Future<List<Map<String,dynamic>>> getSeasonMensTopAssisters (int seasonId) async {
  
    return fetchListWithQueryParams(
      '${_path}mens_top_assisters/get',
      {
        'season_id': seasonId.toString(),
      }
    );
    
}

/// This function sends a GET request to the server to get a list of the women's top assisters in a season.
Future<List<Map<String,dynamic>>> getSeasonWomensTopAssisters (int seasonId) async {
  
    return fetchListWithQueryParams(
      '${_path}womens_top_assisters/get',
      {
        'season_id': seasonId.toString(),
      }
    );
    
}

/// This function sends a GET request to the server to get the men's red card rankings in a season as a list.
Future<List<Map<String,dynamic>>> getSeasonMensRedCardRankings (int seasonId) async {
  
    return fetchListWithQueryParams(
      '${_path}mens_red_card_rankings/get',
      {
        'season_id': seasonId.toString(),
      }
    );
    
}

/// This function sends a GET request to the server to get the women's red card rankings in a season as a list.
Future<List<Map<String,dynamic>>> getSeasonWomensRedCardRankings (int seasonId) async {
  
    return fetchListWithQueryParams(
      '${_path}womens_red_card_rankings/get',
      {
        'season_id': seasonId.toString(),
      }
    );
    
}

/// This function sends a GET request to the server to get the men's yellow card rankings in a season as a list.
Future<List<Map<String,dynamic>>> getSeasonMensYellowCardRankings (int seasonId) async {
  
    return fetchListWithQueryParams(
      '${_path}mens_yellow_card_rankings/get',
      {
        'season_id': seasonId.toString(),
      }
    );
    
}


/// This function sends a GET request to the server to get the women's yellow card rankings in a season as a list.
Future<List<Map<String,dynamic>>> getSeasonWomensYellowCardRankings (int seasonId) async {
  
    return fetchListWithQueryParams(
      '${_path}womens_yellow_card_rankings/get',
      {
        'season_id': seasonId.toString(),
      }
    );
    
}


/// This function sends a GET request to the server to get the men's clean sheet rankings in a season as a list.
Future<List<Map<String,dynamic>>> getSeasonMensCleanSheetRankings (int seasonId) async {
  
    return fetchListWithQueryParams(
      '${_path}mens_clean_sheet_rankings/get',
      {
        'season_id': seasonId.toString(),
      }
    );
    
}

/// This function sends a GET request to the server to get the women's clean sheet rankings in a season as a list.
Future<List<Map<String,dynamic>>> getSeasonWomensCleanSheetRankings (int seasonId) async {
  
    return fetchListWithQueryParams(
      '${_path}womens_clean_sheet_rankings/get',
      {
        'season_id': seasonId.toString(),
      }
    );
    
}