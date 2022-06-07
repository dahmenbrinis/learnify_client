import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/components/question_card.dart';
import '../../../../core/layouts/Background2.dart';
import '../../../../core/layouts/appBar.dart';
import '../../../../core/layouts/footer.dart';
import '../controllers/my_questions_controller.dart';

class MyQuestionsView extends GetView<MyQuestionsController> {
  @override
  Widget build(BuildContext context) {
    Footer.index = 1;
    return Scaffold(
      appBar: const CustomAppBar(
        title: "My Questions",
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
    );
  }
}
