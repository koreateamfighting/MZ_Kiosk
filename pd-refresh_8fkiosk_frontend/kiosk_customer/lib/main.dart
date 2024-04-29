import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiosk_customer/controller/order_list_controller.dart';
import 'package:window_manager/window_manager.dart';
import 'package:kiosk_customer/screen/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final OrderListController orderController = Get.put(OrderListController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    WindowManager.instance.setFullScreen(true);
    return const GetMaterialApp(home: HomeScreen());
  }
}
