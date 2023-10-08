import 'package:get/get.dart';

import '../controllers/list_story_controller.dart';

class ListStoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ListStoryController>(ListStoryController());
  }
}
