import 'get.dart';

/// This function sends a GET request to the server to get all referees
Future <List<Map<String,dynamic>>> getReferees () async {
  return fetchListWithoutQueryParams(
    'referee/get/',
  );
}