import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learnify_client/app/routes/app_pages.dart';
import 'package:learnify_client/core/layouts/Background2.dart';
import 'package:learnify_client/core/layouts/appBar.dart';
import '../../../../core/layouts/footer.dart';
import '../../../../core/components/question_card.dart';
import '../controllers/questions_controller.dart';

class QuestionsView extends GetView<QuestionsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: controller.room.name!,
      ),
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
                    itemCount: controller.paginatedList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          QuestionCard(
                            controller.paginatedList.data[index],
                          ),
                          if (index + 1 ==
                                  controller.paginatedList.data.length &&
                              controller.isLoading.isTrue &&
                              controller.paginatedList.has_next)
                            const Center(child: RefreshProgressIndicator()),
                          if (index + 1 == controller.paginatedList.length)
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
      floatingActionButton: controller.room.permissions?.canAsk ?? false
          ? FloatingActionButton(
              backgroundColor: Colors.blue,
              tooltip: 'ask a Question',
              onPressed: () async {
                controller.user;
                Get.toNamed(Routes.CREATE_QUESTION, arguments: controller.room);
                // var question = await Get.to(() => CreateQuestionView(),
                //     arguments: controller.room);
              },
              child: const Icon(Iconsax.message_add, size: 30),
            )
          : null,
    );
  }
}
