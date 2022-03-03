import 'package:get/get.dart';

import '../User/authMiddleware.dart';

import '../modules/comments/bindings/comments_binding.dart';
import '../modules/comments/bindings/create_comment_binding.dart';
import '../modules/comments/views/comments_view.dart';
import '../modules/comments/views/create_comment_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/questions/bindings/create_question_binding.dart';
import '../modules/questions/bindings/questions_binding.dart';
import '../modules/questions/views/create_question_view.dart';
import '../modules/questions/views/questions_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/room/bindings/rooms_binding.dart';
import '../modules/room/views/rooms_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ROOM;
  // static const INITIAL = Routes.ROOM;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => new HomeView(),
      binding: HomeBinding(),
      // middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
        name: _Paths.ROOM,
        page: () => RoomsView(),
        binding: RoomsBinding(),
        middlewares: [AuthMiddleware()]),
    // GetPage(name: _Paths.CREATEROOM, page: () => CreateView(),
    //     // binding: CreateRoomBinding(),
    //     middlewares: [AuthMiddleware()]),
    GetPage(
      name: _Paths.QUESTIONS,
      page: () => QuestionsView(),
      binding: QuestionsBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.CREATE_QUESTION,
      page: () => CreateQuestionView(),
      binding: CreateQuestionBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.COMMENTS,
      page: () => CommentsView(),
      binding: CommentsBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_COMMENT,
      page: () => CreateCommentView(),
      binding: CreateCommentBinding(),
    ),
  ];
}
