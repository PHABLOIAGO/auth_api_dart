import 'package:crypt/crypt.dart';

class CryptHelper {
  CryptHelper._();
  static String cryptPass(String password) {
    final c1 = Crypt.sha256(password);
    return c1.toString();
  }

  static bool checkPass(String hash, String password) {
    var crypt = Crypt(hash);
    return crypt.match(password);
  }
}
