import 'dart:convert';

import 'package:animeto/constants/strings.dart';
import 'package:http/http.dart' as http;

class HttpApi {
  Future<dynamic> get({required String link}) async {
    Uri url = Uri.parse(baseurl + link);
    http.Response response = await http.get(url);
    try {
      switch (response.statusCode) {
        case 200:
          return jsonDecode(response.body);
        case 304:
          throw Exception(
              "error : Not Modified , status code : ${response.statusCode}");
        case 400:
          return Exception(
              "error : Bad Request , status code : ${response.statusCode}");
        case 404:
          return Exception(
              "error : Not Found , status code : ${response.statusCode}");
        case 405:
          return Exception(
              "error : Method Not Allowed , status code : ${response.statusCode}");
        case 429:
          throw Exception(
              "error : Too Many Request , status code : ${response.statusCode}");
        case 500:
          return Exception(
              "error : Internal Server Error , status code : ${response.statusCode}");
        case 503:
          return Exception(
              "error : Service Unavailable , status code : ${response.statusCode}");
        default:
          Exception(
              "there is an error with status code : ${response.statusCode}");
      }
    } catch (e) {
      print("#######");
      print(e);
      print("#######");
    }
  }
}
