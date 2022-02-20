import 'package:get/get_connect/http/src/http.dart';

class Utils {
  static const String baseUrl = 'http://192.168.1.20:8000';
  // static const String baseUrl = 'http://192.168.149.254:8000';
  static debug(Map json) {
    json['XDEBUG_SESSION'] = '1';
    return json;
  }
}
