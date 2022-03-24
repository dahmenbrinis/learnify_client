import 'package:get/get.dart';
import 'package:learnify_client/app/User/user_provider.dart';
import 'package:learnify_client/app/modules/leaderboard/providers/reputation_provider.dart';
import 'package:learnify_client/app/modules/leaderboard/reputation_model.dart';
import 'package:learnify_client/app/modules/room/room_model.dart';
import 'package:learnify_client/core/pagination.dart';
import 'dart:math';
import '../../../User/user_model.dart';

class LeaderboardController extends GetxController {
  //TODO: Implement LeaderboardController
  final Room room = Get.arguments as Room;
  final _users = Paginated<Reputation>().obs;
  final provider = Get.find<ReputationProvider>();

  final _isLoading = true.obs;
  get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  Paginated<Reputation> get users => _users.value;
  set users(Paginated<Reputation> value) => _users.value = value;
  @override
  Future<void> onInit() async {
    fetch();
    _users.refresh();
    super.onInit();
  }

  fetch() async {
    isLoading = true;
    // var newData = await provider.index('questions/1/comments');
    var newData = await provider.index('room_leaderboard/${room.id}')
        as Paginated<Reputation>;

    users.addAll(newData);
    isLoading = false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
