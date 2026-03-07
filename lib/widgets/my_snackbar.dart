import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class MySnackbar {
  static void error({required String message}) => Get.rawSnackbar(
    backgroundColor: Colors.red,
    message: message,
    borderRadius: 10,
    dismissDirection: DismissDirection.down,
    snackPosition: SnackPosition.BOTTOM,
    margin: EdgeInsets.all(20),
  );
}
