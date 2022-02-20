import 'package:get/get.dart';
import 'package:learnify_client/app/User/AuthController.dart';
import 'package:learnify_client/utils.dart';

import '../room_model.dart';

class RoomProvider extends GetConnect {
  String get token => Get.find<AuthController>().user.token as String;
  get headers => token.isEmpty
      ? {'Accept': 'application/json'}
      : {'Authorization': "Bearer $token", 'Accept': 'application/json'};
  final _search = ''.obs;
  get search => _search.value;
  set search(value) => _search.value = value;
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Room.fromJson(map);
      if (map is List) return map.map((item) => Room.fromJson(item)).toList();
    };
    httpClient.baseUrl = Utils.baseUrl;
    httpClient.defaultContentType = "application/json";
  }

  Future<Room?> getRoom(int id) async {
    final response = await get('/api/room/$id', headers: headers);
    return response.body;
  }

  Future<List<Room>> getRooms({int page = 1}) async {
    final response =
        await get('/api/room?page=$page&search=$search', headers: headers);
    return response.body;
  }

  Future<Response> createRoom(Room room) async =>
      await post('/api/room', room.toJson(), headers: headers);
  Future<Response> updateRoom(Room room) async =>
      await patch('/api/room/${room.id}', room.toJson(), headers: headers);
  Future<Response> deleteRoom(int id) async =>
      await delete('/api/room/$id', headers: headers);
}
