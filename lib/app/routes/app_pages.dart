import 'package:get/get.dart';
import 'package:learnify_client/app/modules/room/bindings/rooms_binding.dart';
import 'package:learnify_client/app/modules/room/views/create_view.dart';
import 'package:learnify_client/app/modules/room/views/rooms_view.dart';
import '../User/authMiddleware.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ROOM;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
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
  ];
}
