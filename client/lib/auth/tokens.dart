import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

Future<String?> getToken() async {
  String? newToken = await storage.read(key: "token");
  if (newToken != null){
    return newToken;
  }
  return null;
}

void setToken(FlutterSecureStorage storage, String token){
  storage.write(key: "token",value: token);
}
