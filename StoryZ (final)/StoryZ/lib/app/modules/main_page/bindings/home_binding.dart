import 'package:get/get.dart';
import 'package:storyz/app/modules/list_story/controllers/list_story_controller.dart';
import 'package:storyz/app/modules/main_page/controllers/home_controller.dart';

class HomePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ListStoryController>(ListStoryController());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
