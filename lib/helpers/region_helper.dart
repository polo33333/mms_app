import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import '../configs/app_config.dart';
import '../models/httpresponse.dart';
import '../models/region.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegionHelper {
  static Future<HTTPResponse<List<Region>>> getByMarketId(int marketId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(AppConfig.FCM_token) ?? null;
      String url = AppConfig.regionGetByMarketId + marketId.toString() +"?token=" + token;
      var response = await get(url);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<Region> region = [];
        body.forEach((e) {
          Region co = Region.fromJson(e);
          region.add(co);
        });
        return HTTPResponse<List<Region>>(
          true,
          region,
          message: 'Request Successful',
          statusCode: response.statusCode,
        );
      } else {
        return HTTPResponse<List<Region>>(
          false,
          null,
          message:
              'Invalid data received from the server! Please try again in a moment.',
          statusCode: response.statusCode,
        );
      }
    } on SocketException {
      print('SOCKET EXCEPTION OCCURRED');
      return HTTPResponse<List<Region>>(
        false,
        null,
        message: 'Unable to reach the internet! Please try again in a moment.',
      );
    } on FormatException {
      print('JSON FORMAT EXCEPTION OCCURRED');
      return HTTPResponse<List<Region>>(
        false,
        null,
        message:
            'Invalid data received from the server! Please try again in a moment.',
      );
    } catch (e) {
      print('UNEXPECTED ERROR');
      print(e.toString());
      return HTTPResponse<List<Region>>(
        false,
        null,
        message: 'Something went wrong! Please try again in a moment!',
      );
    }
  }



}
