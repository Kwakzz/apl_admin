import 'dart:convert';
import 'package:http/http.dart' as https;
import 'api_uri.dart';



/// This is a generic function that sends a GET request to the server to get a map.
Future<Map<String, dynamic>> fetchMap (String path, Map<String, dynamic> queryParams) async {

  try {

    final uri = queryParams != {} ? Uri.https(domain, path, queryParams) : Uri.https(domain, path);


    final response = await https.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );



    if (response.statusCode == 200) {
      
      if (response.body.isEmpty) return {};

      final responseData = jsonDecode(response.body);
      return Map<String, dynamic>.from(responseData['data']);
    } 
    
    else {
      return {};
    }
  } 
  
  catch (e) {
    return {};
  }

}


/// This is a generic function that sends a GET request to the server to get a list.
/// This function has query parameters.
/// The list is a list of maps.
Future<List<Map<String, dynamic>>> fetchListWithQueryParams (String path, Map<String, dynamic> queryParams) async {

  try {
    final response = await https.get(
      Uri.https(domain, path, queryParams),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      
      if (response.body.isEmpty) return [];

      final responseData = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(responseData['data']);

    } 
    
    else {
      return [];
    }
  } 
  
  catch (e) {
    return [];
  }

}


/// This is a generic function that sends a GET request to the server to get a list. 
/// This function does not have query parameters.
/// The list is a list of maps.
Future<List<Map<String, dynamic>>> fetchListWithoutQueryParams (String path) async {

  try {
    final response = await https.get(
      Uri.https(domain, path),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      
      if (response.body.isEmpty) return [];

      final responseData = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(responseData['data']);

    } 
    
    else {
      return [];
    }
  } 
  
  catch (e) {
    return [];
  }

}