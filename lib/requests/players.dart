import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:apl_admin/requests/post.dart';

import 'api_uri.dart';
import 'get.dart';

String _path = '/player/';


/// This function sends a POST request to the server to create a player. This request does not include the player's image.
Future<Map<String, dynamic>> createPlayerWithoutImage(
  String firstName,
  String lastName,
  String birthDate,
  String yearGroup,
  String major,
  String gender,
  int teamId,
  int positionId,
) async {

  return postData(
    '${_path}create/',
    jsonEncode(<String, String> {
      'first_name': firstName,
      'last_name': lastName,
      'birth_date': birthDate,
      'year_group': yearGroup,
      'major': major,
      'gender': gender,
      'team': teamId.toString(),
      'position': positionId.toString(),
    })
  );

}

/// This function sends a POST request to the server to create a news item. This request includes the player's image.
Future<Map<String, dynamic>> createPlayerWithImage(
  String firstName,
  String lastName,
  String birthDate,
  String yearGroup,
  String major,
  String gender,
  int teamId,
  int positionId,
  Uint8List? imageBytes,
) async {


  Map<String, dynamic> result = {};

  try {
    var request = http.MultipartRequest(
      'POST',
      Uri.http(domain, '${_path}create/'),
    );

    request.fields['first_name'] = firstName;
    request.fields['last_name'] = lastName;
    request.fields['birth_date'] = birthDate;
    request.fields['year_group'] = yearGroup;
    request.fields['major'] = major;
    request.fields['gender'] = gender;
    request.fields['team'] = teamId.toString();
    request.fields['position'] = positionId.toString();

    if (imageBytes != null) {
      request.files.add(http.MultipartFile(
        'image',
        http.ByteStream.fromBytes(imageBytes),
        imageBytes.length,
        filename: 'image.${imageBytes.hashCode}.${imageBytes.lengthInBytes}',
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


/// This function sends a GET request to the server to get a list of all APL players.
Future<List<Map<String,dynamic>>> getPlayers () async {
  
    return fetchListWithoutQueryParams(
      '${_path}get/',
    );
    
}


/// This function sends a GET request to the server to get a player by id.
Future<Map<String,dynamic>> getPlayer (String id) async {
  
    return fetchMap(
      '${_path}get',
      {
        'id': id,
      }
    );
    
}

/// This function sends a GET request to the server to get a list of all positions.
Future<List<Map<String,dynamic>>> getPositions () async {
  
    return fetchListWithoutQueryParams(
      '/position/get/',
    );
    
}

Future<Map<String, dynamic>> transferPlayer (toTeamId, playerId) async {

  return postData(
    '${_path}transfer/create/',
    jsonEncode(<String, String> {
      'to_team': toTeamId.toString(),
      'player': playerId.toString(),
    })
  );

}