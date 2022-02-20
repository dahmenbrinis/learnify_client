import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnify_client/app/modules/room/views/create_view.dart';
import 'package:learnify_client/components/footer.dart';
import 'package:learnify_client/components/room_card.dart';
import 'package:learnify_client/layouts/appBar.dart';

import '../controllers/rooms_controller.dart';

class RoomsView extends GetView<RoomController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(title: 'Rooms'),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () {
                controller.refreshList();
                return Future.delayed(Duration.zero);
              },
              child: Obx(() {
                if (controller.list.isEmpty && controller.isLoading.isTrue) {
                  return const Center(child: RefreshProgressIndicator());
                }
                return ListView.builder(
                  controller: controller.scrollController,
                  itemCount: controller.list.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        RoomCard(
                          controller.list[index],
                          image: Image.asset('assets/math.png'),
                        ),
                        if (index + 1 == controller.list.length &&
                            controller.isLoading.isTrue)
                          const Center(child: RefreshProgressIndicator()),
                        if (index + 1 == controller.list.length)
                          const SizedBox(height: 50)
                      ],
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const Footer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        tooltip: 'create new Room',
        onPressed: () async {
          await Get.to(() => CreateView())?.then((value) {
            if (value != null) controller.list.insert(0, value);
            print(controller.list.length);
          });
        },
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}
