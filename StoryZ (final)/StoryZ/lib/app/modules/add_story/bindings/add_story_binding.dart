import 'package:get/get.dart';
import 'package:storyz/app/modules/add_story/controllers/add_story_controller.dart';

class AddStoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddStoryController>(() => AddStoryController());
  }
}
