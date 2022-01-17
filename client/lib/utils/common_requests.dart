import 'dart:convert';
import 'package:bor/auth/tokens.dart';
import 'package:bor/objects/team_obj.dart';
import 'package:bor/objects/user_obj.dart';
import 'package:http/http.dart' as http;
import '../main.dart';


//common_requests.dart is a collection of commonly used http requests. Having it in one place makes it easier to access and reuse.


/*
Request: GET
Description: Returns a Team object, containing all data for the team with matching code.
 */
Future<Team> fetchTeam(String code) async {
  token = await getToken();
  final response = await http.get(
      Uri.parse(serverPort + "/api/get-team?code=$code"),
      headers: { 'Content-Type': 'application/json', 'Authorization': 'Token ${token.toString()}' }
  );

  if (response.statusCode == 200) {
    return Team.fromJson(jsonDecode(response.body));
  }

  throw Exception('Failed to load team data');
}

/*
Request: POST
Description: Returns an HTTP response from the server, after requesting to join team with matching
code.
 */
Future<http.Response> joinTeam(String code) async {
  token = await getToken();
  final response = await http.post(
      Uri.parse(serverPort + "/api/join-team"),
      body: jsonEncode({
        "code": code
      }),
      headers: { 'Content-Type': 'application/json', 'Authorization': 'Token ${token.toString()}' }
  );

  return response;
}

/*
Request: GET
Description: Returns an HTTP response (temp) from the server, after requesting a list of users matching the username.
 */
Future<List<User>> searchUsers(String searchArg) async {
  if (searchArg.isEmpty) {
    return [];
  }

  token = await getToken();
  final response = await http.get(
    Uri.parse(serverPort + "/api/user?search=$searchArg"),
    headers: { 'Content-Type': 'application/json', 'Authorization': 'Token ${token.toString()}' }
  );

  final body = jsonDecode(response.body);
  List<User> users = [];

  for (var i in body) {
    users.add(User.fromJson(i));
  }

  return users;
}

/*
Request: POST
Description: Creates a new team with specified title.
 */
Future<http.Response> createTeam(String title) async {
  token = await getToken();
  final response = await http.post(
    Uri.parse(serverPort + "/api/create-team"),
    headers: { 'Content-Type': 'application/json', 'Authorization': 'Token ${token.toString()}' },
    body: jsonEncode({
      "title": title
    })
  );

  return response;
}

/*
Request: POST
Description: Sends an invite email to user passed
 */
Future<http.Response> inviteUser(String code, String recipient) async {
  token = await getToken();
  final response = await http.post(
      Uri.parse(serverPort + "/api/send-invite"),
      headers: { 'Content-Type': 'application/json', 'Authorization': 'Token ${token.toString()}' },
      body: jsonEncode({
        "recipient": recipient,
        "join_link": "http://3000/join/$code"
      })
  );

  return response;
}

/*
Request: GET
Description: Returns current username for user logged in.
 */
Future<String> fetchUsername() async {
  token = await getToken();
  final response = await http.get(
      Uri.parse(serverPort + "/api/get-username"),
      headers: { 'Content-Type': 'application/json', 'Authorization': 'Token ${token.toString()}' }
  );

  if (response.statusCode == 200) {
    String username = jsonDecode(response.body)['Username'];

    return username;
  }

  throw Exception('Failed to fetch username');
}