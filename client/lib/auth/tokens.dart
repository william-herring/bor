import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/*
tokens.dart is responsible for functions that handle reading/writing a token to FlutterSecureStorage.
The token is stored in the designated encrypted database for the platform in use. These are as follow:

  - Web: WebCrypto (experimental)
  - iOS: Keychain
  - Android: KeyStore
 */

const storage = FlutterSecureStorage();

Future<String?> getToken() async {
  String? newToken = await storage.read(key: "token");
  if (newToken != null) {
    return newToken;
  }
  return null;
}

void setToken(FlutterSecureStorage storage, String token){
  storage.write(key: "token",value: token);
}
