import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glass_kit/glass_kit.dart';
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
            Badge(
              badgeContent: GestureDetector(
                onTap: () {
                  if (controller.isLoading.isFalse) {
                    controller.textController.text = '';
                    controller.init();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Icon(Iconsax.search_normal4),
                ),
              ),
              elevation: 0,
              position: BadgePosition.bottomEnd(bottom: 17, end: 18),
              alignment: Alignment.bottomRight,
              badgeColor: Colors.white,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                height: 50,
                child: TextFormField(
                  controller: controller.textController,
                  onChanged: (value) {
                    controller.search = value;
                  },
                  decoration: const InputDecoration(
                    hintText: 'search for rooms',
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                  ),
                ),
              ),
            ),
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
      floatingActionButton:
          controller.user.type == 0 && controller.user.emailVerifiedAt == null
              ? Container(
                  width: 150,
                  height: 50,
                  child: FloatingActionButton(
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor: Colors.blue,
                    tooltip: 'create new Room',
                    onPressed: () async {
                      Room? room = await Get.to(() => CreateView());
                      if (room == null) return;
                      if (room.id == null) return;
                      controller.paginatedList.data.insert(0, room);
                      controller.update();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Add a Room'),
                          Icon(Iconsax.element_plus, size: 25),
                        ],
                      ),
                    ),
                  ),
                )
              : null,
    );
  }
}
