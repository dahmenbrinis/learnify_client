import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learnify_client/app/modules/room/views/create_view.dart';
import 'package:learnify_client/core/layouts/Background2.dart';
import 'package:learnify_client/core/layouts/footer.dart';
import 'package:learnify_client/core/components/room_card.dart';
import 'package:learnify_client/core/layouts/appBar.dart';
import 'package:learnify_client/app/modules/room/controllers/rooms_controller.dart';

import '../room_model.dart';

class RoomsView extends GetView<RoomController> {
  @override
  Widget build(BuildContext context) {
    Footer.index = 0;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(title: 'Rooms'),
      body: BackgroundWidget2(
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  controller.paginatedList.init();
                  return controller.fetch();
                },
                child: Obx(() {
                  if (controller.paginatedList.data.isEmpty &&
                      controller.isLoading.isTrue) {
                    return const Center(child: RefreshProgressIndicator());
                  }
                  return ListView.builder(
                    controller: controller.scrollController,
                    itemCount: controller.paginatedList.data.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          RoomCard(
                            controller.paginatedList.data[index],
                          ),
                          if (controller.paginatedList.has_next &&
                              index + 1 == controller.paginatedList.length &&
                              controller.isLoading.isTrue)
                            const Center(child: RefreshProgressIndicator()),
                          if (!controller.paginatedList.has_next &&
                              index + 1 == controller.paginatedList.length)
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
      ),
      bottomNavigationBar: const Footer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: controller.user.type == 0
          ? FloatingActionButton(
              backgroundColor: Colors.blue,
              tooltip: 'create new Room',
              onPressed: () async {
                Room? room = await Get.to(() => CreateView());
                if (room == null) return;
                if (room.id == null) return;
                controller.paginatedList.data.insert(0, room);
                controller.update();
              },
              child: const Icon(Iconsax.additem4, size: 30),
            )
          : null,
    );
  }
}
