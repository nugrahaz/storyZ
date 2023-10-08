import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storyz/app/constants/constants.dart';
import 'package:storyz/app/modules/add_story/views/component/google_map_view_model.dart';
import 'package:storyz/app/models/request_add_story.dart';
import 'package:storyz/app/models/response_api.dart';
import 'package:storyz/app/services/local/storage_service.dart';
import 'package:storyz/app/services/remote/api_service.dart';
import 'package:storyz/app/utils/utils.dart';

class AddStoryController extends GetxController {
  static AddStoryController to = Get.find<AddStoryController>();

  //
  late TextEditingController descriptionTextEditingController;
  late FocusNode descriptionFocusNode;

  late File images;
  RxBool isShare = false.obs;

  final viewModel = GoogleMapViewModel();
  var latitude = "0.0";
  var longitude = "0.0";

  //

  RxBool isLoading = false.obs;
  RxBool isImageDeleted = false.obs;

  var selectedImagePath = "".obs;
  var cropImagePath = "".obs;
  var compressImagePath = "".obs;

  GetStorage box = GetStorage();

  @override
  void onInit() {
    descriptionTextEditingController = TextEditingController(text: "");
    descriptionFocusNode = FocusNode();
    super.onInit();
  }

  Future<void> pickImage(
      {required ImageSource imageSource,
      required String filename,
      required BuildContext context}) async {
    final picker = ImagePicker();
    try {
      final XFile? pickedImage = await picker.pickImage(source: imageSource);

      if (pickedImage != null) {
        selectedImagePath.value = pickedImage.path;
        final cropImageFile = await ImageCropper().cropImage(
          sourcePath: selectedImagePath.value,
          maxHeight: 512,
          maxWidth: 512,
          compressFormat: ImageCompressFormat.jpg,
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Crop Photo',
                backgroundColor: AppStyles.colors.bgDark,
                toolbarColor: AppStyles.colors.cyan,
                statusBarColor: AppStyles.colors.cyan,
                // cropFrameColor: AppColor.bgDark,
                cropFrameStrokeWidth: 10,
                cropGridColor: AppStyles.colors.cyan,
                cropFrameColor: AppStyles.colors.cyan,
                activeControlsWidgetColor: AppStyles.colors.cyan,
                showCropGrid: false,
                hideBottomControls: false,
                toolbarWidgetColor: AppStyles.colors.white,
                initAspectRatio: CropAspectRatioPreset.square,
                lockAspectRatio: false)
          ],
        );

        File? checkFile(File f) => f.existsSync() == true ? f : null;

        if (checkFile(File(cropImageFile!.path)) != null) {
          cropImagePath.value = cropImageFile.path;

          // compress image
          final dir = Directory.systemTemp;
          final targetPath = "${dir.absolute.path}/$filename.jpg";
          final XFile? compressedFile =
              await FlutterImageCompress.compressAndGetFile(
                  cropImagePath.value, targetPath,
                  quality: 90);

          compressImagePath.value = compressedFile!.path;

          images = File(compressImagePath.value);
        } else {
          deleteCacheImage();
          SharedMethod.showSnackBar(
              title: "Gambar tidak dipilih",
              description: "Mohon untuk mengambil gambar",
              context: context);
        }
      } else {
        selectedImagePath.value = "";
        cropImagePath.value = "";
        compressImagePath.value = "";
        SharedMethod.showSnackBar(
            title: "Gambar tidak dipilih",
            description: "Mohon untuk mengambil gambar",
            context: context);
      }
    } on PlatformException {
      SharedMethod.showSnackBar(
          title: "Kamera tidak tersedia",
          description: "Tidak dapat mengambil gambar",
          context: context);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      SharedMethod.showSnackBar(
          title: kDebugMode.toString(), description: "", context: context);
    }
    return;
  }

  void deleteCacheImage() {
    isImageDeleted(true);
    selectedImagePath.value = "";
    cropImagePath.value = "";
    compressImagePath.value = "";
    update();
  }

  void handleUpdate(BuildContext context) async {
    isLoading(true);

    Future.delayed(700.milliseconds, () {
      if (descriptionTextEditingController.text.trim() == "") {
        SharedMethod.showSnackBar(
            title: "Deskripsi masih kosong",
            description: "Harap untuk memeriksa kembali",
            context: context);
      } else {
        try {
          AddStoryRequest data;
          if (isShare.value == true) {
            data = AddStoryRequest(
                lat: double.parse(latitude),
                lon: double.parse(longitude),
                description: descriptionTextEditingController.text.trim(),
                photoUrl: images.path);
          } else {
            data = AddStoryRequest(
                description: descriptionTextEditingController.text.trim(),
                photoUrl: images.path);
          }

          ApiService()
              .postStory(
                  token: StorageServices().getUserInfo().token.toString(),
                  story: data)
              .then((ResponseApi response) async {
            SharedMethod.showSnackBar(
                title: response.message,
                description: "Information from server",
                context: context);

            if (response.error == false) {
              deleteCacheImage();
              // FocusScope.of(Get.context!).unfocus();
              descriptionTextEditingController.clear();
              Future.delayed(1.seconds, () {
                GoRouter.of(context).pushReplacementNamed(AppRoutes.mainPage);
              });
            }
            isLoading(false);
          });
        } catch (error) {
          if (kDebugMode) {
            print(error);
          }
        } finally {
          isLoading(false);
        }
      }
    });
    isLoading(false);
  }
}
