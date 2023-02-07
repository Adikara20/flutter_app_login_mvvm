import 'dart:convert';
import 'dart:io';

import '../app_exeptions.dart';
import 'baseapiservices.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NetworkService extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataExeption('No internet Connection');
    }

    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      Response response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataExeption('No internet Connection');
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestExeption(response.body.toString());
      case 404:
        throw UnautoriseExeption(response.body.toString());
      default:
        throw FetchDataExeption(
            'Error accured while comminocation with server' +
                'with status code' +
                response.statusCode.toString());
    }
  }
}
