// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:get/get.dart';
import 'package:learnify_client/core/model.dart';
import '../app/User/AuthController.dart';
import '../utils.dart';

abstract class Provider<ModelType extends Model> extends GetConnect {
  String get token => Get.find<AuthController>().user.token as String;
  get headers => token.isEmpty
      ? {'Accept': 'application/json'}
      : {'Authorization': "Bearer $token", 'Accept': 'application/json'};
  fromJsonModel(item);
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is List) return map.map((item) => fromJsonModel(item)).toList();
      if (map is Map) if ((map).containsKeys(['current_page', 'data']))
        return map['data'].map((item) => fromJsonModel(item)).toList();
      if (map is Map) return fromJsonModel(map);
    };
    httpClient.baseUrl = Utils.baseUrl;
    httpClient.defaultContentType = "application/json";
    httpClient.timeout = const Duration(seconds: 10);
  }

  Future<List<ModelType>?> index(String url,
      {Map<String, dynamic>? filters, int? page}) async {
    filters ?? {}.addIf(page != null, 'page', page);
    var res = await sendRequest(url, "GET", headers: headers, query: filters);
    var list = List<ModelType>.from(res?.body.where((i) => true));
    return list;
  }

  Future<ModelType?> view(String url) {
    return sendRequest(url, 'GET', headers: headers)
        .then((value) => value?.body);
  }

  Future<ModelType?> create(String url, ModelType model) {
    return sendRequest(url, 'POST', headers: headers, body: model.toJson())
        .then((value) => value?.body);
  }

  Future<ModelType?> update(String url, ModelType model) {
    return sendRequest(url, 'PUT', headers: headers, body: model.toJson())
        .then((value) => value?.body);
  }

  Future<bool?> destroy(String url) {
    return sendRequest(url, 'DELETE', headers: headers)
        .then((value) => value?.body);
  }

  Future<Response<ModelType>?> sendRequest<ModelType>(String url, String method,
      {dynamic body,
      String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      Progress? uploadProgress}) {
    return super.request<ModelType>("/api/" + url, method,
        body: body,
        contentType: contentType,
        headers: headers ?? this.headers,
        query: query,
        uploadProgress: uploadProgress);
    // return the response and handle the error .
    // TODO : handle errors.
  }
}

extension MapExtension on Map {
  bool containsKeys(List<String> keys) {
    for (var element in this.keys) {
      if (keys.contains(element)) return true;
    }
    return false;
  }
}
