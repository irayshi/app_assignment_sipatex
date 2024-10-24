import 'package:app_assignment_sipatex/app/modules/product/create_product/bindings/create_product_binding.dart';
import 'package:app_assignment_sipatex/app/modules/product/create_product/views/create_product_view.dart';
import 'package:app_assignment_sipatex/app/modules/product/edit_product/bindings/edit_product_binding.dart';
import 'package:app_assignment_sipatex/app/modules/product/edit_product/views/edit_product_view.dart';
import 'package:app_assignment_sipatex/app/modules/user/create_user/bindings/create_user_binding.dart';
import 'package:app_assignment_sipatex/app/modules/user/create_user/views/create_user_view.dart';
import 'package:app_assignment_sipatex/app/modules/user/edit_user/bindings/edit_user_binding.dart';
import 'package:app_assignment_sipatex/app/modules/user/edit_user/views/edit_user_view.dart';
import 'package:get/get.dart';

import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';
import '../modules/product/bindings/product_binding.dart';
import '../modules/product/product_list/bindings/product_list_binding.dart';
import '../modules/product/product_list/views/product_list_view.dart';
import '../modules/product/views/product_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/user/bindings/user_binding.dart';
import '../modules/user/views/user_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT,
      page: () => const ProductView(),
      binding: ProductBinding(),
      children: [
        GetPage(
          name: _Paths.CREATE_PRODUCT,
          page: () => const CreateProductView(),
          binding: CreateProductBinding(),
        ),
        GetPage(
          name: _Paths.EDIT_PRODUCT,
          page: () => const EditProductView(),
          binding: EditProductBinding(),
        ),
        GetPage(
          name: _Paths.PRODUCT_LIST,
          page: () => const ProductListView(),
          binding: ProductListBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.USER,
      page: () => const UserView(),
      binding: UserBinding(),
      children: [
        GetPage(
          name: _Paths.CREATE_USER,
          page: () => const CreateUserView(),
          binding: CreateUserBinding(),
        ),
        GetPage(
          name: _Paths.EDIT_USER,
          page: () => const EditUserView(),
          binding: EditUserBinding(),
        ),
      ],
    ),
  ];
}
