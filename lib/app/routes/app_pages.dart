import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/products/bindings/products_binding.dart';
import '../modules/products/create_product/bindings/create_product_binding.dart';
import '../modules/products/create_product/views/create_product_view.dart';
import '../modules/products/detail_product/bindings/detail_product_binding.dart';
import '../modules/products/detail_product/views/detail_product_view.dart';
import '../modules/products/edit_product/bindings/edit_product_binding.dart';
import '../modules/products/edit_product/views/edit_product_view.dart';
import '../modules/products/views/products_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/users/bindings/users_binding.dart';
import '../modules/users/create_user/bindings/create_user_binding.dart';
import '../modules/users/create_user/views/create_user_view.dart';
import '../modules/users/detail_user/bindings/detail_user_binding.dart';
import '../modules/users/detail_user/views/detail_user_view.dart';
import '../modules/users/edit_user/bindings/edit_user_binding.dart';
import '../modules/users/edit_user/views/edit_user_view.dart';
import '../modules/users/views/users_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
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
      name: _Paths.USERS,
      page: () => const UsersView(),
      binding: UsersBinding(),
      children: [
        GetPage(
          name: _Paths.EDIT_USER,
          page: () => const EditUserView(),
          binding: EditUserBinding(),
        ),
        GetPage(
          name: _Paths.DETAIL_USER,
          page: () => const DetailUserView(),
          binding: DetailUserBinding(),
        ),
        GetPage(
          name: _Paths.CREATE_USER,
          page: () => const CreateUserView(),
          binding: CreateUserBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.PRODUCTS,
      page: () => const ProductsView(),
      binding: ProductsBinding(),
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
          name: _Paths.DETAIL_PRODUCT,
          page: () => const DetailProductView(),
          binding: DetailProductBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}
