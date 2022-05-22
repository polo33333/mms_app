import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import '../configs/app_config.dart';
import '../models/contract.dart';
import '../models/contract_2.dart';
import '../models/httpresponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContractHelper {
  static Future<HTTPResponse<List<Contract>>> search() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(AppConfig.FCM_token) ?? null;
      String url = AppConfig.kiotForRentGetAll +"?token=" + token;
      var response = await get(url);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<Contract> contracts = [];
        body.forEach((e) {
          Contract contract = Contract.fromJson(e);
          contracts.add(contract);
        });
        return HTTPResponse<List<Contract>>(
          true,
          contracts,
          message: 'Request Successful',
          statusCode: response.statusCode,
        );
      } else {
        return HTTPResponse<List<Contract>>(
          false,
          null,
          message:
          'Invalid data received from the server! Please try again in a moment.',
          statusCode: response.statusCode,
        );
      }
    } on SocketException {
      print('SOCKET EXCEPTION OCCURRED');
      return HTTPResponse<List<Contract>>(
        false,
        null,
        message: 'Unable to reach the internet! Please try again in a moment.',
      );
    } on FormatException {
      print('JSON FORMAT EXCEPTION OCCURRED');
      return HTTPResponse<List<Contract>>(
        false,
        null,
        message:
        'Invalid data received from the server! Please try again in a moment.',
      );
    } catch (e) {
      print('UNEXPECTED ERROR');
      print(e.toString());
      return HTTPResponse<List<Contract>>(
        false,
        null,
        message: 'Something went wrong! Please try again in a moment!',
      );
    }
  }


  static Future<HTTPResponse<List<Contract>>> getByMarketId(int marketId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(AppConfig.FCM_token) ?? null;
      String url = AppConfig.kiotForRentGetByMarketId + marketId.toString() +"?token=" + token;
      var response = await get(url);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<Contract> contracts = [];
        body.forEach((e) {
          Contract contract = Contract.fromJson(e);
          contracts.add(contract);
        });
        return HTTPResponse<List<Contract>>(
          true,
          contracts,
          message: 'Request Successful',
          statusCode: response.statusCode,
        );
      } else {
        return HTTPResponse<List<Contract>>(
          false,
          null,
          message:
          'Invalid data received from the server! Please try again in a moment.',
          statusCode: response.statusCode,
        );
      }
    } on SocketException {
      print('SOCKET EXCEPTION OCCURRED');
      return HTTPResponse<List<Contract>>(
        false,
        null,
        message: 'Unable to reach the internet! Please try again in a moment.',
      );
    } on FormatException {
      print('JSON FORMAT EXCEPTION OCCURRED');
      return HTTPResponse<List<Contract>>(
        false,
        null,
        message:
        'Invalid data received from the server! Please try again in a moment.',
      );
    } catch (e) {
      print('UNEXPECTED ERROR');
      print(e.toString());
      return HTTPResponse<List<Contract>>(
        false,
        null,
        message: 'Something went wrong! Please try again in a moment!',
      );
    }
  }


  static Future<HTTPResponse<List<Contract>>> getByRegionId(int regionId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(AppConfig.FCM_token) ?? null;
      String url = AppConfig.kiotForRentGetByRegionId + regionId.toString() +"?token=" + token;
      var response = await get(url);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<Contract> contracts = [];
        body.forEach((e) {
          Contract contract = Contract.fromJson(e);
          contracts.add(contract);
        });
        return HTTPResponse<List<Contract>>(
          true,
          contracts,
          message: 'Request Successful',
          statusCode: response.statusCode,
        );
      } else {
        return HTTPResponse<List<Contract>>(
          false,
          null,
          message:
          'Invalid data received from the server! Please try again in a moment.',
          statusCode: response.statusCode,
        );
      }
    } on SocketException {
      print('SOCKET EXCEPTION OCCURRED');
      return HTTPResponse<List<Contract>>(
        false,
        null,
        message: 'Unable to reach the internet! Please try again in a moment.',
      );
    } on FormatException {
      print('JSON FORMAT EXCEPTION OCCURRED');
      return HTTPResponse<List<Contract>>(
        false,
        null,
        message:
        'Invalid data received from the server! Please try again in a moment.',
      );
    } catch (e) {
      print('UNEXPECTED ERROR');
      print(e.toString());
      return HTTPResponse<List<Contract>>(
        false,
        null,
        message: 'Something went wrong! Please try again in a moment!',
      );
    }
  }


  static Future<HTTPResponse<List<Contract_2>>> getContractByMarketId(int marketId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(AppConfig.FCM_token) ?? null;
      String url = AppConfig.contractGetByMarketId + marketId.toString() +"?token=" + token;
      var response = await get(url);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<Contract_2> contracts = [];
        body.forEach((e) {
          Contract_2 contract = Contract_2.fromJson(e);
          contracts.add(contract);
        });
        return HTTPResponse<List<Contract_2>>(
          true,
          contracts,
          message: 'Request Successful',
          statusCode: response.statusCode,
        );
      } else {
        return HTTPResponse<List<Contract_2>>(
          false,
          null,
          message:
          'Invalid data received from the server! Please try again in a moment.',
          statusCode: response.statusCode,
        );
      }
    } on SocketException {
      print('SOCKET EXCEPTION OCCURRED');
      return HTTPResponse<List<Contract_2>>(
        false,
        null,
        message: 'Unable to reach the internet! Please try again in a moment.',
      );
    } on FormatException {
      print('JSON FORMAT EXCEPTION OCCURRED');
      return HTTPResponse<List<Contract_2>>(
        false,
        null,
        message:
        'Invalid data received from the server! Please try again in a moment.',
      );
    } catch (e) {
      print('UNEXPECTED ERROR');
      print(e.toString());
      return HTTPResponse<List<Contract_2>>(
        false,
        null,
        message: 'Something went wrong! Please try again in a moment!',
      );
    }
  }
}