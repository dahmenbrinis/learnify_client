class Utils {
  static const String baseUrl = 'http://192.168.1.20:8000';
  // static const String baseUrl = 'https://learnify.ddns.net';
  // static const String baseUrl = 'http://165.232.122.101:80';

  static debug(Map json) {
    json['XDEBUG_SESSION'] = '1';
    return json;
  }
}
