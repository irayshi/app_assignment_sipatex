import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_user_controller.dart';

class DetailUserView extends GetView<DetailUserController> {
  const DetailUserView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail User'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Text(
            'Name: ${controller.user.displayName}',
            style: context.textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          Text(
            'Email: ${controller.user.email}',
            style: context.textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          Text(
            'Role: ${controller.user.role}',
            style: context.textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
