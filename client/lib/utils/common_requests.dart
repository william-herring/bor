import 'dart:convert';
import 'package:bor/auth/tokens.dart';
import 'package:bor/objects/team_obj.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

/*
common_requests.dart is a collection of commonly used http requests. Having it in
one place makes it easier to access and reuse.
 */

Future<Team> fetchTeam(code) async {
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

void joinTeam(String code) async {
  token = await getToken();
  final response = await http.post(
      Uri.parse(serverPort + "/api/join-team?code=$code"),
      headers: { 'Content-Type': 'application/json', 'Authorization': 'Token ${token.toString()}' }
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to join team');
  }

  print("Success!");
}

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