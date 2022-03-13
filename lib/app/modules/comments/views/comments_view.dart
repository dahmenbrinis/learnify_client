import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learnify_client/app/modules/comments/bindings/create_comment_binding.dart';
import 'package:learnify_client/app/modules/comments/comment_model.dart';
import 'package:learnify_client/app/routes/app_pages.dart';

import '../../../../core/components/avatar_image.dart';
import '../../../../core/components/net_image.dart';
import '../../../../core/layouts/SecondAppBar.dart';
import '../controllers/comments_controller.dart';
import 'create_comment_view.dart';

class CommentsView extends GetView<CommentsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondAppBar(
        title: "",
        // title:  controller.question.title!,
        logo: RawMaterialButton(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            onPressed: () => Get.back(),
            child: const Align(
                alignment: Alignment.centerLeft,
                child: Icon(Iconsax.direct_left5))),
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
                                      alt: controller.question.user!.name!),
                                  // padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  controller.question.user!.name!,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                  textAlign: TextAlign.center,
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
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.elliptical(100, 100)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.elliptical(100, 100)),
                  child: Obx(() {
                    if (controller.isLoading &&
                        controller.list.current_page == 0)
                      return const Center(child: RefreshProgressIndicator());
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
                            CommentCard(
                              controller.list.data[index],
                            ),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        tooltip: 'create new Room',
        onPressed: () async {
          //TODO: make this route a named route .

          Get.toNamed(Routes.CREATE_COMMENT,arguments: controller.question);
          // controller.update();
        },
        child: const Icon(Iconsax.note_add, size: 30),
      ),
    );
  }
}

class CommentCard extends StatelessWidget {
  final Comment data;
  final _comment = Rx<Comment>(Comment());

  Comment get comment => _comment.value;

  set comment(Comment value) => _comment.value = value;

  CommentCard(Comment this.data);

  @override
  Widget build(BuildContext context) {
    comment = data;
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
                CustomAvatarImage(
                  NetImage(id: comment.user!.imageId, alt: comment.user!.name!),
                ),
                const SizedBox(height: 10),
                Text(
                  comment.user!.name!,
                  style: const TextStyle(color: Colors.black, fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 13,
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
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                  // padding: EdgeInsets.only(left: 10),
                  child: Icon(
                Iconsax.like_tag,
                color: Colors.red.shade300,
              )),
            ),
          ),
          StaggeredGridTile.fit(
            crossAxisCellCount: 15,
            // mainAxisCellCount: 2,
            // mainAxisExtent: 20,
            child: Wrap(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    comment.body!,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                    // textAlign: TextAlign.center,
                  ),
                ),
                // Divider(color: Colors.black, thickness: 1),
              ],
            ),
          ),
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
