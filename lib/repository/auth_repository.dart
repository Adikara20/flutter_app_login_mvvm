import 'package:flutter/foundation.dart';
import 'package:flutter_application_location/data/network/baseapiservices.dart';
import 'package:flutter_application_location/data/network/networkapiservices.dart';
import 'package:flutter_application_location/res/app_url.dart';

class AuthRepository {
  BaseApiServices _apiServices = NetworkService();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.loginEndPoint, data);
      if (kDebugMode) {
        print("object");
        print(response.toString());
      }
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> signUpApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.registerEndPoint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
