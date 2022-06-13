import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learnify_client/app/User/auth.dart';
import 'package:learnify_client/app/routes/app_pages.dart';
import 'package:learnify_client/core/components/net_image.dart';
import '../../app/modules/home/providers/vote_provider.dart';
import '../../app/modules/home/vote_model.dart';
import '../../app/modules/questions/question_model.dart';
import '../components/avatar_image.dart';

class QuestionCard extends StatelessWidget {
  final Question data;
  final _question = Rx<Question>(Question());

  final List<Widget>? footer;
  Question get question => _question.value;
  set question(Question value) => _question.value = value;

  // final int voteCount, answersCount;

  QuestionCard(this.data, {this.footer});
  final _isVoted = false.obs;

  get isVoted => _isVoted.value;

  set isVoted(value) => _isVoted.value = value;

  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    question = data;
    isVoted = question.votes
        .any((Vote element) => element.userId == Auth.user.id.toString());
    return AnimatedContainer(
      duration: const Duration(milliseconds: 5000),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xe2ffffff),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: RawMaterialButton(
        onPressed: () => Get.toNamed(Routes.COMMENTS, arguments: question),
        child: StaggeredGrid.count(
          // crossAxisAlignment: CrossAxisAlignment.start,
          crossAxisCount: 20,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: [
            /// header ///
            StaggeredGridTile.count(
              crossAxisCellCount: 3,
              mainAxisCellCount: 3,
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.PROFILE, arguments: question.user);
                },
                child: CustomAvatarImage(
                  NetImage(id: question.user?.imageId, alt: question.user!.alt),
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 12,
              mainAxisCellCount: 3,
              child: Center(
                child: Text(question.title!.capitalize!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black)),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 5,
              mainAxisCellCount: 2,
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  // color: Colors.red,
                  child: Obx(() {
                    // print(comment.voteCount);
                    return GestureDetector(
                      onTap: () async {
                        if (!this.isVoted) {
                          var provider = Get.find<VoteProvider>();
                          var res = await provider.vote(question.id!,
                              (Question).toString(), question.room!.id!);
                          if (res == null) return;
                          if (res.id == null) return;
                          this.isVoted = true;
                          question.voteCount = (question.voteCount ?? 0) + 1;
                          Auth.refreshPoints();
                          _question.refresh();
                        } else if (this.isVoted) {
                          var provider = Get.find<VoteProvider>();

                          var res = await provider.unVote(question.id!,
                              (Question).toString(), question.room!.id!);

                          if (res == null) return;
                          if (res == 0) return;

                          this.isVoted = false;
                          question.voteCount = (question.voteCount ?? 0) - 1;
                          Auth.refreshPoints();
                          _question.refresh();
                        }
                      },
                      child: Visibility(
                        visible: question.user!.id != Auth.user.id,
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("${question.voteCount ?? 0} votes "),
                            // if (!this.isVoted)
                            Visibility(
                              visible: !this.isVoted,
                              child: Icon(
                                Iconsax.like5,
                                color: Colors.greenAccent.shade400,
                              ),
                            ),
                            // if (this.isVoted)
                            Visibility(
                              visible: this.isVoted,
                              child: Icon(
                                Iconsax.dislike5,
                                color: Colors.red.shade400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),

            /// body ///
            StaggeredGridTile.fit(
              crossAxisCellCount: 20,
              // mainAxisCellCount: 6,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Text(question.description!,
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
            ),

            /// footer ///
            StaggeredGridTile.fit(
              crossAxisCellCount: 20,
              // mainAxisCellCount: 4,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: StaggeredGrid.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  children: [
                    Text(question.answersCount.toString() + " Answers",
                        style: TextStyle(color: Colors.blue),
                        textAlign: TextAlign.center),
                    Text(question.createdAt.toString().substring(0, 10),
                        style: TextStyle(color: Colors.blue),
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
