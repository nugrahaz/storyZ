import 'package:get/get.dart';
import 'package:storyz/app/modules/list_story/controllers/list_story_controller.dart';
import 'package:storyz/app/modules/splash/controllers/splash_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ListStoryController>(ListStoryController(), permanent: true);
    Get.put<SplashController>(SplashController());
  }
}
