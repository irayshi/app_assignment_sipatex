import 'package:app_assignment_sipatex/modules/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('')),
      body: ListView(children: []),
    );
  }
}