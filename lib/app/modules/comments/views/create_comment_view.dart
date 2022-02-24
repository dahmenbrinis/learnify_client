import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';

import '../../../../core/components/input_filed.dart';
import '../controllers/create_comment_controller.dart';

class CreateCommentView extends GetView<CreateCommentController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CreateCommentView'),
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
                      'Comment Title:',
                      style: TextStyle(fontSize: 20),
                    ),
                    inputController: controller.titleController,
                  ),
                  InputField(
                    inputText: const Text(
                      'Comment Body:',
                      style: TextStyle(fontSize: 20),
                    ),
                    inputController: controller.bodyController,
                    lines: 4,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Upload Image:',
                          style: TextStyle(fontSize: 20)),
                      TextButton(
                        onPressed: () {
                          print('');
                        },
                        child: const Text("select an image"),
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
                child: Text('Submit Comment', style: TextStyle(fontSize: 25)),
              ),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.blue,
                textStyle: const TextStyle(fontSize: 20),
                minimumSize: Size(MediaQuery.of(context).size.width / 3, 0),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              onPressed: () {
                controller.addComment();
              },
            ),
          ),
        ],
      ),
    );
  }
}
