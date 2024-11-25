import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:practice_2/app.dart';
import 'package:practice_2/data/models/network_response.dart';
import 'package:http/http.dart';
import 'package:practice_2/ui/controllers/auth_controller.dart';
import 'package:practice_2/ui/screen/sign_in_screen.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'token': AuthController.accessToken.toString(),
      };
      printRequest(url, null, headers);
      final Response response = await get(uri, headers: headers);
      printResponse(url, response);
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responeseData: decodeData,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'token': AuthController.accessToken.toString(),
      };
      debugPrint(url);
      final Response response = await post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      printRequest(url, body, headers);
      printResponse(url, response);
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);

        if (decodeData['status'] == 'fail') {
          return NetworkResponse(
              isSuccess: false,
              statusCode: response.statusCode,
              errorMessage: decodeData['data']);
        }
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responeseData: decodeData,
        );
      } else if (response.statusCode == 401) {
        _moveToLogin();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: 'unauthorized',
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static void printRequest(
      String url,
      Map<String, dynamic>? body,
      Map<String, dynamic>? headers,
      ) {
    debugPrint(
      'REQUEST:\nURL:$url\nBODY:$body,\nHeader:$headers',
    );
  }

  static void printResponse(String url, Response response) {
    debugPrint(
      'URL:$url\nRESPONSE CODE: ${response.statusCode}\nBODY:${response.body}',
    );
  }

  static void _moveToLogin() {
    AuthController.clearUserData();
    Navigator.pushAndRemoveUntil(
        TaskManagerApp.navigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
            (p) => false);
  }
}
