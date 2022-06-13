import 'package:get/get.dart';

import '../User/authMiddleware.dart';
import '../modules/comments/bindings/comments_binding.dart';
import '../modules/comments/bindings/create_comment_binding.dart';
import '../modules/comments/views/comments_view.dart';
import '../modules/comments/views/create_comment_view.dart';
import '../modules/global_leaderboard/bindings/global_leaderboard_binding.dart';
import '../modules/global_leaderboard/views/global_leaderboard_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/leaderboard/bindings/leaderboard_binding.dart';
import '../modules/leaderboard/views/leaderboard_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/manage_students/bindings/manage_students_binding.dart';
import '../modules/manage_students/views/manage_students_view.dart';
import '../modules/my_questions/bindings/my_questions_binding.dart';
import '../modules/my_questions/views/my_questions_view.dart';
import '../modules/not_connected/bindings/not_connected_binding.dart';
import '../modules/not_connected/views/not_connected_view.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/questions/bindings/create_question_binding.dart';
import '../modules/questions/bindings/questions_binding.dart';
import '../modules/questions/views/create_question_view.dart';
import '../modules/questions/views/questions_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/room/bindings/rooms_binding.dart';
import '../modules/room/views/rooms_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;
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
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.CREATE_COMMENT,
      page: () => CreateCommentView(),
      binding: CreateCommentBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.LEADERBOARD,
      page: () => LeaderboardView(),
      binding: LeaderboardBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.GLOBAL_LEADERBOARD,
      page: () => GlobalLeaderboardView(),
      binding: GlobalLeaderboardBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.MY_QUESTIONS,
      page: () => MyQuestionsView(),
      binding: MyQuestionsBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.MANAGE_STUDENTS,
      page: () => ManageStudentsView(),
      binding: ManageStudentsBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.NOT_CONNECTED,
      page: () => NotConnectedView(),
      binding: NotConnectedBinding(),
    ),
  ];
}
