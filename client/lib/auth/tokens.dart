import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<String?>? getToken(FlutterSecureStorage storage){
  Future<String?> newToken = storage.read(key: "token");
  if (newToken.toString().isNotEmpty){
    return newToken;
  }
  return null;
}
void setToken(FlutterSecureStorage storage, String token){
  storage.write(key: "token",value: token);
}
