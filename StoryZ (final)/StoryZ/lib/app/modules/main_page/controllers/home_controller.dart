import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storyz/app/utils/utils.dart';

class HomeController extends GetxController {
  static HomeController to = Get.find<HomeController>();

  double xOffset = 0;
  double yOffset = 0;

  final RxBool _isDrawerOpen = false.obs;

  //getter isDrawerOpen
  bool get getDrawerIsOpen => _isDrawerOpen.value;

  //setter isDrawerOpen
  set setDrawerIsOpen(bool isDrawerOpen) {
    _isDrawerOpen.value = isDrawerOpen;
  }

  drawerIsOpen(bool status, Color statusColor, Color navColor) {
    setDrawerIsOpen = status;
    if (getDrawerIsOpen == false) {
      xOffset = 0;
      yOffset = 0;
    } else {
      xOffset = SizeConfig.blockWidth * 72.5;
      yOffset = 11.0 * SizeConfig.blockHeight;
    }

    SharedMethod.systemBarColor(statusColor, navColor);
  }
}
