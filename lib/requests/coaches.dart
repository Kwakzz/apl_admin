import 'get.dart';

String _path = '/coach/';


/// This function sends a GET request to the server to get a list of all APL coaches.
Future<List<Map<String,dynamic>>> getCoaches () async {
  
    return fetchListWithoutQueryParams(
      '${_path}get/',
    );
    
}


/// This function sends a GET request to the server to get a coach by id.
Future<Map<String,dynamic>> getCoach (String id) async {
  
    return fetchMap(
      '${_path}get',
      {
        'id': id,
      }
    );
    
}