import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiBaseHelper {
  Future<dynamic> get(
      {required String url, required Map<String, String> header}) async {
    try {
      final response = await http
          .get(
            (Uri.parse(url)),
            headers: header,
          )
          .timeout(const Duration(seconds: 24));

      final items = await compute(jsonDecode, response.body);
      return items;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<dynamic> post(
      {required String url,
      required dynamic body,
      required Map<String, String> header}) async {
    try {
      final response = await http
          .post(
            (Uri.parse(url)),
            body: json.encode(body),
            headers: header,
          )
          .timeout(const Duration(seconds: 24));

      final items = await compute(jsonDecode, response.body);
      return items;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
