import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import '../configs/app_config.dart';
import '../models/httpresponse.dart';
import '../models/productGroup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductGroupHelper {
  static Future<HTTPResponse<List<ProductGroup>>> getByMarketId(int marketId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(AppConfig.FCM_token) ?? null;
      String _apiHost = await AppConfig.choseApiHost();
      String url = _apiHost + AppConfig.productGroupGetByMarketId + marketId.toString() +"?token=" + token;

      var response = await get(url);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<ProductGroup> productGroup = [];
        body.forEach((e) {
          ProductGroup co = ProductGroup.fromJson(e);
          productGroup.add(co);
        });
        return HTTPResponse<List<ProductGroup>>(
          true,
          productGroup,
          message: 'Request Successful',
          statusCode: response.statusCode,
        );
      } else {
        return HTTPResponse<List<ProductGroup>>(
          false,
          null,
          message:
          'Invalid data received from the server! Please try again in a moment.',
          statusCode: response.statusCode,
        );
      }
    } on SocketException {
      print('SOCKET EXCEPTION OCCURRED');
      return HTTPResponse<List<ProductGroup>>(
        false,
        null,
        message: 'Unable to reach the internet! Please try again in a moment.',
      );
    } on FormatException {
      print('JSON FORMAT EXCEPTION OCCURRED');
      return HTTPResponse<List<ProductGroup>>(
        false,
        null,
        message:
        'Invalid data received from the server! Please try again in a moment.',
      );
    } catch (e) {
      print('UNEXPECTED ERROR');
      print(e.toString());
      return HTTPResponse<List<ProductGroup>>(
        false,
        null,
        message: 'Something went wrong! Please try again in a moment!',
      );
    }
  }



}
