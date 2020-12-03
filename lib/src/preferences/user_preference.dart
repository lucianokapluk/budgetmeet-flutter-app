import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  static final UserPreference _instancia = new UserPreference.internal();
  //constructor singleton
  factory UserPreference() {
    return _instancia;
  }

  UserPreference.internal();
  SharedPreferences prefs;

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  get uid {
    return prefs.getString('uid') ?? null;
  }

  set uid(String value) {
    prefs.setString('uid', value);
  }

  get displayName {
    return prefs.getString('displayName') ?? null;
  }

  set displayName(String value) {
    prefs.setString('displayName', value);
  }

  get email {
    return prefs.getString('email') ?? null;
  }

  set email(String value) {
    prefs.setString('email', value);
  }

  get photoURL {
    return prefs.getString('photoURL') ?? null;
  }

  set photoURL(String value) {
    prefs.setString('photoURL', value);
  }

  get darkMode {
    return prefs.getBool('darkMode') ?? null;
  }

  set darkMode(bool value) {
    prefs.setBool('darkMode', value);
  }
}
