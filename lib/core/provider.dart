// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:get/get.dart';
import 'package:learnify_client/core/model.dart';
import 'package:learnify_client/core/pagination.dart';
import '../app/User/auth.dart';
import 'utils.dart';

abstract class Provider<ModelType extends Model> extends GetConnect
    with Pagination<ModelType> {
  String? get token => Auth.user.token;
  get headers => token == null
      ? {'Accept': 'application/json'}
      : {'Authorization': "Bearer $token", 'Accept': 'application/json'};

  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is List) return map.map((item) => fromJsonModel(item)).toList();
      if (map is Map<String, dynamic>) if ((map)
          .containsKeys(['current_page', 'data']))
        return paginationFromJson(map);
      // return map['data'].map((item) => fromJsonModel(item)).toList();
      if (map is Map) return fromJsonModel(map);
    };
    httpClient.baseUrl = Utils.baseUrl;
    httpClient.defaultContentType = "application/json";
    httpClient.timeout = const Duration(seconds: 20);
  }

  Future<Paginated<ModelType>?> index(String url,
      {Map<String, String>? filters, int page = 1}) async {
    filters = filters ?? {};
    filters.assign('page', page.toString());
    var res = await sendRequest(url, "GET", query: filters);
    return res.body;
  }

  Future<ModelType?> view(String url) {
    return sendRequest(url, 'GET', headers: headers)
        .then((value) => value.body);
  }

  Future<ModelType?> create(String url, ModelType model) {
    return sendRequest(url, 'POST', headers: headers, body: model.toJson())
        .then((value) => value.body);
  }

  Future<ModelType?> update(String url, ModelType model) {
    return sendRequest(url, 'PUT', headers: headers, body: model.toJson())
        .then((value) => value.body);
  }

  Future<bool> destroy(String url) {
    return sendRequest(url, 'DELETE', headers: headers)
        .then((value) => value.bodyString == "1");
  }

  Future<Response> sendRequest(String url, String method,
      {dynamic body,
      String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      Progress? uploadProgress}) async {
    var res = await super.request("/api/" + url, method,
        body: body,
        contentType: contentType,
        headers: headers ?? this.headers,
        query: query,
        uploadProgress: uploadProgress);
    return res;
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
