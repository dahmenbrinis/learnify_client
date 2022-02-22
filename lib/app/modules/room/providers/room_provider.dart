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

  Future<Response> createRoom(Room room) async =>
      await post('/api/room', room.toJson(), headers: headers);
  Future<Response> updateRoom(Room room) async =>
      await patch('/api/room/${room.id}', room.toJson(), headers: headers);
  Future<Response> deleteRoom(int id) async =>
      await delete('/api/room/$id', headers: headers);

  Future<Room?> join(int id, String? code) async {
    final response =
        await post('/api/join_room/$id', {'code': '$code'}, headers: headers);
    return response.body;
  }
}
