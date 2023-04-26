import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class AppUser {
  static Future<dynamic> createProfile(Map<String, dynamic> user) async {
    const endPointUrl =
        'https://us-central1-massup-51634.cloudfunctions.net/massup/create_profile';
    final url = Uri.parse(endPointUrl);
    final head = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final body = jsonEncode(user);
    final response = await http.post(url, headers: head, body: body);
    if (response.statusCode == 200) {
      print('profile created');
      return json.decode(response.body);
    } else {
      throw Exception('An error ocurred while creating profile');
    }
  }

  static Future<bool> updateProfile(
      Map<String, dynamic> profileData, String profileId) async {
    final endpointUrl =
        'https://us-central1-massup-51634.cloudfunctions.net/massup/update_profile/$profileId';
    final url = Uri.parse(endpointUrl);
    final head = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final data = jsonEncode(profileData);
    final response = await http.patch(url, headers: head, body: data);
    print(response);
    if (response.statusCode == 200) {
      print('profile updated successfully');
      return true;
    } else {
      throw Exception('An error occurred while updating a profile');
    }
  }

  Future<Map> getProfile(String profileId) async {
    final apiUrl =
        'https://us-central1-massup-51634.cloudfunctions.net/massup/view_profile/$profileId';
    final url = Uri.parse(apiUrl);
    final head = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.get(url, headers: head);
    print(response);
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return json.decode(response.body);
    } else {
      throw Exception('an error occurred while reading user');
    }
  }
}
