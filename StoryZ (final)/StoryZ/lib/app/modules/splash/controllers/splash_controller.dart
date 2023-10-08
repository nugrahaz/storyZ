import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:storyz/app/constants/constants.dart';
import 'package:storyz/app/services/local/storage_service.dart';

class SplashController extends GetxController {
  openStartPage(BuildContext context) async {
    bool isLogged = await StorageServices().getIsLogged();
    Timer(2.5.seconds, () async {
      if (isLogged == true) {
        GoRouter.of(context).pushReplacementNamed(AppRoutes.mainPage);
      } else {
        GoRouter.of(context).pushReplacementNamed(AppRoutes.authenticationPage);
      }
    });
  }
}
