import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:storyz/app/models/story_model.dart';
import 'package:storyz/app/services/local/storage_service.dart';
import 'package:storyz/app/services/remote/api_service.dart';

class ListStoryController extends GetxController {
  static ListStoryController to = Get.find();
  RxBool isLoading = false.obs;
  late StoryModel story;
  RxList<StoryModel> listStory = <StoryModel>[].obs;
  RxString address = "location not set".obs;

  late Position position;

  @override
  void onInit() {
    // TODO: implement onInit
    determinePosition().then((value) => position = value);
    super.onInit();
  }

  //
  final int _limit = 10;
  int _page = 1;
  var hasMore = true.obs;

  Future getList() async {
    try {
      List<StoryModel> response = await ApiService().getListStoryX(
        token: StorageServices().getUserInfo().token.toString(),
        page: _page,
        limit: _limit,
      );

      if (response.length < _limit) {
        hasMore.value = false;
      }

      listStory.addAll(response);
      _page++;
    } catch (e) {
      if (kDebugMode) print(e.toString());
    }
  }

  Future refreshData() async {
    _page = 1;
    hasMore.value = true;
    listStory.clear();

    await getList();
  }

  //

  Future<Position> determinePosition() async {
    late bool serviceEnabled;
    late LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // SharedMethod.showSnackBar(
      //     title: "Location services are disabled",
      //     description: "accessing the location is prohibited", context: context);
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      //cek ulang
      if (permission == LocationPermission.denied) {
        // SharedMethod.showSnackBar(
        //     title: "Location permissions are denied",
        //     description: "please give permission in advance");
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // SharedMethod.showSnackBar(
      //     title: "Location permissions permanently denied",
      //     description: "please give permission in advance");

      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  void getAddressByLatLong({required double lat, required double long}) async {
    if (lat != 0.0 || long != 0.0) {
      List<Placemark> placemark = await placemarkFromCoordinates(lat, long);
      address.value =
          "${placemark.first.locality}, ${placemark.first.street}, ${placemark.first.administrativeArea}, ${placemark.first.postalCode.toString()}, ${placemark.first.country}";
    }
  }

  // Future<void> fetchListStories() async {
  //   isLoading(true);
  //   ApiService apiService = ApiService();
  //
  //   try {
  //     await apiService
  //         .getListStory(token: StorageServices().getUserInfo().token.toString())
  //         .then((List<ListStory> response) {
  //       listStory.value = response;
  //
  //       Future.delayed(1.seconds, () {
  //         getAddressByLatLong(lat: story.lat ?? 0.0, long: story.lon ?? 0.0);
  //       });
  //       isLoading(false);
  //     });
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e.toString());
  //     }
  //   }
  // }

  Future<void> fetchDetailStories(String storyId) async {
    isLoading(true);
    ApiService apiService = ApiService();

    try {
      await apiService
          .getStoryDetail(
              storyId: storyId,
              token: StorageServices().getUserInfo().token.toString())
          .then((response) {
        story = response.story;

        Future.delayed(1.seconds, () {
          getAddressByLatLong(lat: story.lat ?? 0.0, long: story.lon ?? 0.0);
        });
        isLoading(false);
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
