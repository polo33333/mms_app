import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../configs/app_config.dart';

class AuthRepos {
  Client client = Client();

  Future<bool> signIn(String name, String pass) async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String _apiHost = await AppConfig.choseApiHost();

      final response = await post(
        _apiHost + AppConfig.URL_SIGNIN,
        body: {'name': name, 'pass': pass},
      );

      Map<String, dynamic> mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        if (mapResponse["isSuccess"] == true) {
          prefs.setString('LOGIN', 'YES');
          prefs.setString('USERNAME', name);
          prefs.setString('PASS', pass);
          prefs.setString(AppConfig.FCM_token, mapResponse["token"]);
          print('SignIn:  Success to sign in');
          return true;
        }
        print('SignIn:  Faile to sign in');
        prefs.setString('LOGIN', 'NO');
        return false;
      }

      print('Connect-SignIn:  Failed to get data');
      return false;
    }on SocketException {
      return throw('Unable to reach the internet! Please try again in a moment.');

    } on FormatException {
      return throw('JSON FORMAT EXCEPTION OCCURRED');
    } catch (e) {
      return throw(e);
    }
  }

  Future<bool> checkIsAuthenticated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //String _auth = prefs.getString('LOGIN') ?? 'NO';
    String token = prefs.getString(AppConfig.FCM_token) ?? null;
    String _apiHost = await AppConfig.choseApiHost();

    if (token != null) {
      final response = await get(_apiHost + AppConfig.URL_VERIFY +"?token=" + token);
      Map<String, dynamic> mapResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        if (mapResponse["isSuccess"] == true) {
          return true;
        }
        signOut();
        return false;
      }
      return false;
    }
    return false;
  }

  Future<bool> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //String token = prefs.getString(FCM_token)??'null';

    prefs.remove('LOGIN');
    prefs.remove(AppConfig.FCM_token);
    prefs.remove('USERNAME');
    prefs.remove('PASS');
    return true;
  }

  Future<bool> changePassword(String rePass, String pass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(AppConfig.FCM_token) ?? 'null';
    String _apiHost = await AppConfig.choseApiHost();

    final response = await post(
      _apiHost + AppConfig.URL_CHANGEPASSWORD,
      body: {'rePassWord': rePass, 'pass': pass, 'token': token},
    );

    Map<String, dynamic> mapResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      if (mapResponse["isSuccess"] == true) {
        print('changePassword:  Success');
        return true;
      }
      print('changePassword:  Faile');
      return false;
    }

    //throw('Connect:  Failed');
    return false;
  }



  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var _token = prefs.getString(AppConfig.FCM_token).toString();
    return _token;
  }
}
