import 'package:get/get.dart';
import 'package:learnify_client/core/provider.dart';
import '../room_model.dart';

class RoomProvider extends Provider<Room> {
  final _search = ''.obs;
  get search => _search.value;
  set search(value) => _search.value = value;

  RoomProvider() : super();
  @override
  fromJsonModel(json) => Room.fromJson(json);

  Future<Room?> join(int id, String? code) async {
    final response =
        await post('/api/join_room/$id', {'code': '$code'}, headers: headers);
    return response.body;
  }

  Future<Room?> leave(int id, String? code) async {
    final response =
        await post('/api/leave_room/$id', {'code': '$code'}, headers: headers);
    return response.body;
  }
}
