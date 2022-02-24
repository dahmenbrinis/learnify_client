import 'package:learnify_client/core/model.dart';
import 'dart:math';

abstract class Pagination<M extends Model> {
  fromJsonModel(item);
  paginationFromJson(Map<String, dynamic> json) {
    final Paginated<M> page = Paginated();
    page.has_new_data = page.current_page != json['current_page'];
    page.current_page = json['current_page'];
    page.per_page = json['per_page'];
    page.last_page = json['last_page'];
    page.total = json['total'];
    var res = json['data'].map((item) => fromJsonModel(item)).toList();
    page.data = List<M>.from(res);
    return page;
  }
}

class Paginated<M> {
  bool has_new_data = false;
  int get length => data.length;
  int current_page = 0, per_page = 0, last_page = 1, total = -1;

  List<M> data = [];
  int get next_page => min(current_page + 1, last_page);
  int get previous_page => max(current_page - 1, 0);
  bool get has_next => current_page < last_page;
  bool get has_previous => current_page > 1;
  addAll(Paginated<M>? newList) {
    if (newList!.current_page > current_page) data.addAll(newList.data);
    current_page = newList.current_page;
    per_page = newList.per_page;
    last_page = newList.last_page;
    total = newList.total;
  }

  init() {
    data.clear();
    current_page = 0;
    per_page = 0;
    last_page = 1;
    total = -1;
  }
}
