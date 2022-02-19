import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnify_client/app/modules/room/providers/room_provider.dart';
import 'package:learnify_client/app/modules/room/room_model.dart';
import 'package:learnify_client/components/footer.dart';
import 'package:learnify_client/components/room_card.dart';
import 'package:learnify_client/layouts/appBar.dart';

import '../controllers/rooms_controller.dart';

class RoomsView extends GetView<RoomController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(title: 'Rooms'),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () {
                controller.refreshList();
                return Future.delayed(Duration.zero);
              },
              child: Obx(() {
                if (controller.list.isEmpty && controller.isLoading.isTrue)
                  return Center(child: RefreshProgressIndicator());
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

          // TextButton(
          //     onPressed: () => controller.fetch(), child: Text('click me')),
          // const SizedBox(height: 10),
          // Expanded(
          //   child: FutureBuilder(
          //     future: controller.fetch(),
          //     builder: (context, snapshot) {
          //       if (snapshot.hasData) {
          //         var items = snapshot.data as List<Room>;
          //         return RefreshIndicator(
          //           onRefresh: () {
          //             return controller.fetch();
          //           },
          //           child: ListView.builder(
          //               itemCount: items.length,
          //               itemBuilder: (context, index) {
          //                 return Column(children: [
          //                   RoomCard(
          //                     items[index],
          //                     image: Image.asset('assets/math.png'),
          //                   ),
          //                 ]);
          //         return const Center(child: CircularProgressIndicator());
          //       }
          // ),  //               }),
          //         );
          //       } else {
          //     },
          //   ),
        ],
      ),
      bottomNavigationBar: const Footer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        tooltip: 'create new Room',
        onPressed: () {},
        child: const CircleAvatar(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
