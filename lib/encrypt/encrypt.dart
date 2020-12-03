import 'package:encrypt/encrypt.dart' as encrypt;

encryptData(String text) {
  final key = encrypt.Key.fromLength(32);
  final iv = encrypt.IV.fromLength(16);
  final encrypter = encrypt.Encrypter(encrypt.AES(key));

  final encrypted = encrypter.encrypt(text, iv: iv);

  return encrypted;
}

decryptData(text) {
  final key = encrypt.Key.fromLength(32);
  final iv = encrypt.IV.fromLength(16);
  final encrypter = encrypt.Encrypter(encrypt.AES(key));
  final decrypted = encrypter.decrypt64(text, iv: iv);

  return decrypted;
}
