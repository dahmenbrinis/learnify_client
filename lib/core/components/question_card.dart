import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnify_client/app/User/auth.dart';
import 'package:learnify_client/app/routes/app_pages.dart';
import 'package:learnify_client/core/components/net_image.dart';
import '../../app/modules/questions/question_model.dart';
import '../components/avatar_image.dart';

class QuestionCard extends StatelessWidget {
  final Question data;
  final _question = Rx<Question>(Question());

  final List<Widget>? footer;
  get question => _question.value;
  set question(value) => _question.value = value;

  // final int voteCount, answersCount;

  QuestionCard(this.data, {this.footer});

  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    question = data;
    return RawMaterialButton(
      onPressed: () => Get.toNamed(Routes.COMMENTS, arguments: question),
      child: Container(
        margin: const EdgeInsets.all(10),
        // color: Colors.blue,
        decoration: BoxDecoration(
          color: Color(0xe2ffffff),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: ConstrainedBox(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height / 5),
          child: Container(
            padding: const EdgeInsets.all(5),
            // child: Text('hello ', style: TextStyle(color: Colors.white)),
            // duration: Duration(seconds: 3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //------- head ---------
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 2,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: 60),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomAvatarImage(
                              NetImage(
                                id: question.user.imageId,
                                alt: question.user.name!,
                              ),
                              // padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              question.user.name,
                              style: const TextStyle(color: Colors.blue),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      flex: 9,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(question.title!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black)),
                            const SizedBox(height: 5),
                            Text(question.description!,
                                style: const TextStyle(color: Colors.black45))
                          ]),
                    ),
                    const SizedBox(width: 10),
                    const Flexible(
                      fit: FlexFit.tight,
                      child: Center(
                          child: Icon(Icons.more_vert, color: Colors.blue)),
                    ),
                  ],
                ),

                ///------- body ---------///
                // SizedBox(height: 10),

                // if (isOpen)

                ///------- footer ---------///
                const Divider(color: Colors.black),
                // SizedBox(height: 5),
                Container(
                  constraints: const BoxConstraints(maxHeight: 25),
                  // color: Colors.lightGreenAccent,
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  // margin: EdgeInsets.symmetric(vertical: -5),
                  child: Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: footer ??
                          [
                            Text(question.answersCount.toString() + " Answers",
                                style: const TextStyle(color: Colors.blue)),
                            Text(question.voteCount.toString() + " Votes",
                                style: const TextStyle(color: Colors.blue)),
                            FlatButton.icon(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              onPressed: () => question.voteCount,
                              icon: const Icon(
                                Icons.arrow_drop_up,
                                color: Colors.greenAccent,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              label: const Text(
                                'UpVote',
                                style: TextStyle(color: Colors.greenAccent),
                              ),
                            ),
                          ],
                    );
                  }),
                ),
                // SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
