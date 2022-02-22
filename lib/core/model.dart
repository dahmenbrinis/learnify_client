// ignore_for_file: avoid_print

import 'package:get/get_connect.dart';

abstract class Model {
  // Model.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
  Model();
}
