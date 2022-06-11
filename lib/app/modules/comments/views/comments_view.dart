import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learnify_client/app/User/auth.dart';
import 'package:learnify_client/app/modules/comments/bindings/create_comment_binding.dart';
import 'package:learnify_client/app/modules/comments/comment_model.dart';
import 'package:learnify_client/app/modules/comments/providers/comment_provider.dart';
import 'package:learnify_client/app/modules/home/providers/vote_provider.dart';
import 'package:learnify_client/app/modules/home/vote_model.dart';
import 'package:learnify_client/app/routes/app_pages.dart';

import '../../../../core/components/avatar_image.dart';
import '../../../../core/components/net_image.dart';
import '../../../../core/layouts/SecondAppBar.dart';
import '../../../../core/layouts/appBar.dart';
import '../../questions/question_model.dart';
import '../controllers/comments_controller.dart';
import 'create_comment_view.dart';

class CommentsView extends GetView<CommentsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: controller.question.title!,
        logo: GestureDetector(
            onTap: () => Get.back(),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Icon(Iconsax.direct_left5),
            )),
      ),
      body: Container(
        color: Colors.blue,
        child: Column(
          children: [
            Obx(() {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 5000),
                curve: Curves.fastOutSlowIn,
                child: Visibility(
                  visible: !controller.isHidden,
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(minHeight: 200, maxHeight: 300),
                    child: AnimatedContainer(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: double.infinity,
                      duration: const Duration(milliseconds: 300),
                      child: StaggeredGrid.count(
                        crossAxisCount: 12,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        children: [
                          StaggeredGridTile.count(
                            crossAxisCellCount: 3,
                            mainAxisCellCount: 2,
                            child: Wrap(
                              // crossAxisAlignment: WrapCrossAlignment.center,
                              alignment: WrapAlignment.center,
                              children: [
                                CustomAvatarImage(
                                  NetImage(
                                      id: controller.question.user!.imageId,
                                      alt: controller.question.user!.alt),
                                  // padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    controller.question.user!.name!,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 12),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          ),
                          StaggeredGridTile.count(
                            crossAxisCellCount: 9,
                            mainAxisCellCount: 1,
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                controller.question.title!.addQuestionMark(),
                                style: const TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                // textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          const StaggeredGridTile.fit(
                            crossAxisCellCount: 11,
                            child: Divider(color: Colors.white, height: 1),
                          ),
                          StaggeredGridTile.fit(
                            crossAxisCellCount: 12,
                            child: Text(
                              controller.question.description!,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white),
                              // textAlign: TextAlign.center,
                            ),
                          ),
                          // StaggeredGridTile.count(
                          //   crossAxisCellCount: 12,
                          //   mainAxisCellCount: 4,
                          //   child: StaggeredGrid.count(
                          //     crossAxisCount: 4,
                          //     mainAxisSpacing: 10,
                          //     crossAxisSpacing: 10,
                          //     children: const [
                          //       StaggeredGridTile.count(
                          //         crossAxisCellCount: 1,
                          //         mainAxisCellCount: 1,
                          //         child: NetImage(alt: 'I M'),
                          //       ),
                          //       StaggeredGridTile.count(
                          //         crossAxisCellCount: 1,
                          //         mainAxisCellCount: 1,
                          //         child: NetImage(alt: 'I M'),
                          //       ),
                          //       StaggeredGridTile.count(
                          //         crossAxisCellCount: 1,
                          //         mainAxisCellCount: 1,
                          //         child: NetImage(alt: 'I M'),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),

            /// comments section ///
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).bottomAppBarColor,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.elliptical(100, 100)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.elliptical(100, 100)),
                  child: Obx(() {
                    if (controller.isLoading &&
                        controller.list.current_page == 0) {
                      return const Center(child: RefreshProgressIndicator());
                    }
                    return ListView.builder(
                      controller: controller.scrollController,
                      itemCount: controller.list.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // if (index == 0) const SizedBox(height: 20),
                            if (index == 0)
                              const Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Comments',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            CommentCard(controller.list.data[index],
                                controller.question),
                            if (index + 1 == controller.list.data.length &&
                                controller.isLoading &&
                                controller.list.has_next)
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
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Container(
        width: 150,
        height: 50,
        child: FloatingActionButton(
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          backgroundColor: Colors.blue,
          tooltip: 'create new Room',
          onPressed: () async {
            Get.toNamed(Routes.CREATE_COMMENT, arguments: controller.question);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Add Answer'),
                Icon(Iconsax.message_add, size: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CommentCard extends StatelessWidget {
  final Comment data;
  final _comment = Rx<Comment>(Comment());

  final RxBool _isVoted = false.obs;

  bool get isVoted => _isVoted.value;

  set isVoted(bool value) => _isVoted.value = value;

  // final RxBool _isApproved = false.obs;
  // bool get isApproved => _isVoted.value;
  // set isApproved(bool value) => _isVoted.value = value;

  Question question;

  Comment get comment => _comment.value;

  set comment(Comment value) => _comment.value = value;

  CommentCard(Comment this.data, Question this.question);

  @override
  Widget build(BuildContext context) {
    comment = data;
    isVoted = comment.votes
        .any((Vote element) => element.userId == Auth.user.id.toString());
    // isApproved = comment.canApprove;
    bool isOwner = question.room!.creatorId == Auth.user.id;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: StaggeredGrid.count(
        // axisDirection: AxisDirection.down,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        crossAxisCount: 20,
        children: [
          StaggeredGridTile.count(
            crossAxisCellCount: 3,
            mainAxisCellCount: 3,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.PROFILE, arguments: comment.user!);
                  },
                  child: CustomAvatarImage(
                    NetImage(id: comment.user!.imageId, alt: comment.user!.alt),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  comment.user!.name!,
                  style: TextStyle(
                      color: Theme.of(context).primaryColorDark, fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 11,
            mainAxisCellCount: 2,
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  comment.title ?? ''.capitalize!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black),
                  // textAlign: TextAlign.center,
                ),
              ),
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
                  return Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("${comment.voteCount ?? 0} votes "),
                      // if (!this.isVoted)
                      Visibility(
                        visible: !this.isVoted,
                        child: GestureDetector(
                          onTap: () async {
                            var provider = Get.find<VoteProvider>();
                            var res = await provider.vote(comment.id!,
                                (Comment).toString(), question.room!.id!);
                            if (res == null) return;
                            if (res.id == null) return;
                            this.isVoted = true;
                            data.votes.add(res);
                            comment.voteCount = (comment.voteCount ?? 0) + 1;
                            Auth.refreshPoints();
                            _comment.refresh();
                          },
                          child: Icon(
                            Iconsax.like5,
                            color: Colors.greenAccent.shade400,
                          ),
                        ),
                      ),
                      // if (this.isVoted)
                      Visibility(
                        visible: this.isVoted,
                        child: GestureDetector(
                          onTap: () async {
                            var provider = Get.find<VoteProvider>();
                            var res = await provider.unVote(comment.id!,
                                (Comment).toString(), question.room!.id!);

                            if (res == null) return;
                            if (res == 0) return;

                            this.isVoted = false;
                            comment.voteCount = (comment.voteCount ?? 0) - 1;
                            Auth.refreshPoints();
                            _comment.refresh();
                          },
                          child: Icon(
                            Iconsax.dislike5,
                            color: Colors.red.shade400,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
          StaggeredGridTile.fit(
            crossAxisCellCount: 15,
            // mainAxisCellCount: 2,
            // mainAxisExtent: 20,
            child: Container(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                comment.body!,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
                // textAlign: TextAlign.center,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 3,
            mainAxisCellCount: 3,
            child: Obx(() {
              return Visibility(
                visible: comment.isValid,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 5),
                    Icon(Iconsax.tick_circle, color: Colors.green),
                    Text(
                      'approved',
                      style: TextStyle(color: Colors.green),
                    )
                  ],
                ),
              );
            }),
          ),
          Obx(() {
            return StaggeredGridTile.count(
              crossAxisCellCount: 20,
              mainAxisCellCount: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: comment.canApprove && isOwner,
                      child: MaterialButton(
                        color: Colors.greenAccent,
                        onPressed: () async {
                          var provider = Get.find<CommentProvider>();
                          var res = await provider.approve(question, comment);
                          if (res == null) return;
                          if (res == 0) return;

                          comment.canApprove = false;
                          comment.isValid = true;
                          // comment.voteCount = (comment.voteCount ?? 0) - 1;
                          Auth.refreshPoints();
                          _comment.refresh();
                        },
                        child: const Text(
                          'Approve',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !comment.canApprove && isOwner,
                      child: MaterialButton(
                        color: Colors.redAccent.shade200,
                        onPressed: () async {
                          var provider = Get.find<CommentProvider>();
                          var res =
                              await provider.disApprove(question, comment);
                          if (res == null) return;
                          if (res == false) return;

                          comment.canApprove = true;
                          comment.isValid = false;
                          // comment.voteCount = (comment.voteCount ?? 0) - 1;
                          Auth.refreshPoints();
                          _comment.refresh();
                        },
                        child: const Text(
                          'Remove Approval',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          const StaggeredGridTile.fit(
            crossAxisCellCount: 18,
            child: Divider(color: Colors.black),
          ),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  addQuestionMark() {
    return contains('?') ? this : this + "?";
  }
}

// Container(
// height: 150.0,
// decoration: BoxDecoration(
// color: Colors.blue,
// boxShadow: const [BoxShadow(blurRadius: 40.0, color: Colors.blue)],
// borderRadius: BorderRadius.vertical(
// bottom: Radius.elliptical(
// MediaQuery.of(context).size.width - 150, 150.0)),
// ),
// ),
