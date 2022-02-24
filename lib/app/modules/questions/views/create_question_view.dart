import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:learnify_client/core/components/input_filed.dart';

import '../controllers/create_question_controller.dart';

class CreateQuestionView extends GetView<CreateQuestionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('ask Question on : ${controller.room.name!}'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: StaggeredGrid.count(
                crossAxisCount: 1,
                mainAxisSpacing: 20,
                children: [
                  InputField(
                    inputText: const Text(
                      'Question Title:',
                      style: TextStyle(fontSize: 20),
                    ),
                    inputController: controller.titleController,
                  ),
                  InputField(
                    inputText: const Text(
                      'Question Description:',
                      style: TextStyle(fontSize: 20),
                    ),
                    inputController: controller.descriptionController,
                    lines: 4,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('More Details :',
                          style: TextStyle(fontSize: 20)),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          print('');
                        },
                        child: Row(
                          children: const [
                            Icon(Icons.image),
                            SizedBox(width: 10),
                            Text(
                              "attach images",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextButton(
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
                child: Text('Submit Question', style: TextStyle(fontSize: 25)),
              ),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.blue,
                textStyle: const TextStyle(fontSize: 20),
                minimumSize: Size(MediaQuery.of(context).size.width / 3, 0),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              onPressed: () {
                controller.addQuestion();
              },
            ),
          ),
        ],
      ),
    );
  }
}
