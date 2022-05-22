import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import '../configs/app_config.dart';
import '../models/GenneralInfo.dart';
import '../models/httpresponse.dart';
import '../models/market.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/marketDetail.dart';

class APIHelper {
  static Future<HTTPResponse<List<Market>>> getAll() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(AppConfig.FCM_token) ?? null;

      String url = AppConfig.marketGetAll +"?token=" + token;
      var response = await get(url);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<Market> markets = [];
        body.forEach((e) {
          Market market = Market.fromJson(e);
          markets.add(market);
        });
        return HTTPResponse<List<Market>>(
          true,
          markets,
          message: 'Request Successful',
          statusCode: response.statusCode,
        );
      } else {
        return HTTPResponse<List<Market>>(
          false,
          null,
          message:
          'Invalid data received from the server! Please try again in a moment.',
          statusCode: response.statusCode,
        );
      }
    } on SocketException {
      print('SOCKET EXCEPTION OCCURRED');
      return HTTPResponse<List<Market>>(
        false,
        null,
        message: 'Unable to reach the internet! Please try again in a moment.',
      );
    } on FormatException {
      print('JSON FORMAT EXCEPTION OCCURRED');
      return HTTPResponse<List<Market>>(
        false,
        null,
        message:
        'Invalid data received from the server! Please try again in a moment.',
      );
    } catch (e) {
      print('UNEXPECTED ERROR');
      print(e.toString());
      return HTTPResponse<List<Market>>(
        false,
        null,
        message: 'Something went wrong! Please try again in a moment!',
      );
    }
  }


  static Future<HTTPResponse<MarketDetail>> getById(int marketId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(AppConfig.FCM_token) ?? null;
      String url = AppConfig.marketGetById + marketId.toString() +"?token=" + token;
      var response = await get(url);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        MarketDetail data = null;
        data =  MarketDetail.fromJson(body);
        return HTTPResponse<MarketDetail>(
          true,
          data,
          message: 'Request Successful',
          statusCode: response.statusCode,
        );
      } else {
        return HTTPResponse<MarketDetail>(
          false,
          null,
          message:
          'Invalid data received from the server! Please try again in a moment.',
          statusCode: response.statusCode,
        );
      }
    } on SocketException {
      print('SOCKET EXCEPTION OCCURRED');
      return HTTPResponse<MarketDetail>(
        false,
        null,
        message: 'Unable to reach the internet! Please try again in a moment.',
      );
    } on FormatException {
      print('JSON FORMAT EXCEPTION OCCURRED');
      return HTTPResponse<MarketDetail>(
        false,
        null,
        message:
        'Invalid data received from the server! Please try again in a moment.',
      );
    } catch (e) {
      print('UNEXPECTED ERROR');
      print(e.toString());
      return HTTPResponse<MarketDetail>(
        false,
        null,
        message: 'Something went wrong! Please try again in a moment!',
      );
    }
  }


  static Future<HTTPResponse<GenneralInfo>> getGenneralInfo() async {

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(AppConfig.FCM_token)??null;
      String url = AppConfig.URL_GETGENNERALINFO+  "?token=" + token;
      var response = await get(url);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        //return GenneralInfo.fromJson(body);
        return HTTPResponse<GenneralInfo>(
          true,
          GenneralInfo.fromJson(body),
          message: 'Request Successful',
          statusCode: response.statusCode,
        );
      } else {
        // If that response was not OK, throw an error.
        throw Exception('Failed to load TestAssignment');
        return null;
      }
    } on SocketException {
      print('SOCKET EXCEPTION OCCURRED');
      return HTTPResponse<GenneralInfo>(
        false,
        null,
        message: 'Unable to reach the internet! Please try again in a moment.',
      );
    } on FormatException {
      print('JSON FORMAT EXCEPTION OCCURRED');
      return HTTPResponse<GenneralInfo>(
        false,
        null,
        message:
        'Invalid data received from the server! Please try again in a moment.',
      );
    } catch (e) {
      print('UNEXPECTED ERROR');
      print(e.toString());
      return HTTPResponse<GenneralInfo>(
        false,
        null,
        message: 'Something went wrong! Please try again in a moment!',
      );
    }

  }
}