import 'package:shared_preferences/shared_preferences.dart';

class ManageToken {
  //storing authentication token in storage
  static setAuthToken(String token) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('token', token);
  }

  //storing authentication token in storage
  static Future<String?> getAuthToken() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('token');
  }
}
