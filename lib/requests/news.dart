import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'get.dart';
import 'api_uri.dart';


String _path = '/news-item/';


/// This function sends a GET request to the server to get a list of news items.
Future<List<Map<String,dynamic>>> getNewsItems () async {
  
    return fetchListWithoutQueryParams(
      '${_path}get/',
    );
    
}


/// This function sends a GET request to the server to get a news item by id.
Future<Map<String,dynamic>> getNewsItem (String id) async {
  
    return fetchMap(
      '${_path}get',
      {
        'id': id,
      }
    );
    
}

/// This function sends a POST request to the server to create a news item.
Future<Map<String, dynamic>> createNewsItem(
  String title,
  String subtitle,
  String text,
  int selectedTagId,
  Uint8List? imageBytes,
) async {


  Map<String, dynamic> result = {};

  try {
    var request = http.MultipartRequest(
      'POST',
      Uri.http(domain, '/news-item/create/'),
    );

    request.fields['title'] = title;
    request.fields['subtitle'] = subtitle;
    request.fields['text'] = text;
    request.fields['tag'] = selectedTagId.toString();

    if (imageBytes != null) {
      request.files.add(http.MultipartFile(
        'featured_image',
        http.ByteStream.fromBytes(imageBytes),
        imageBytes.length,
        filename: 'featured_image.${imageBytes.hashCode}.${imageBytes.lengthInBytes}',
      ));
    }

    var response = await request.send();
    var responseData = await response.stream.bytesToString();

    if (response.statusCode == 201) {
      result = {
        'status': true,
        'message': jsonDecode(responseData)['message'] ?? 'Success',
      };
    } 
    else {
      result = {
        'status': false,
        'message': jsonDecode(responseData)['message'] ?? 'An error occurred. Please try again.',
      };
    }
  } 
  
  catch (e) {
    result = {
      'status': false,
      'message': 'An error occurred. Please try again.',
    };
  }

  return result;
}

/// This function retrieves all news tags.
Future<List<Map<String,dynamic>>> getTags () async {
  
    return fetchListWithoutQueryParams(
      '/news-item-tag/get/',
    );
    
}