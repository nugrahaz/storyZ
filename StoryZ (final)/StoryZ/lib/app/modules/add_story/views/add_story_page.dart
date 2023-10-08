import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storyz/app/constants/constants.dart';
import 'package:storyz/app/services/local/storage_service.dart';
import 'package:storyz/app/utils/utils.dart';
import 'package:storyz/app/widgets/widgets.dart';

import '../controllers/add_story_controller.dart';

class AddStoryPage extends StatefulWidget {
  const AddStoryPage({super.key});

  @override
  AddStoryPageState createState() => AddStoryPageState();
}

class AddStoryPageState extends State<AddStoryPage> {
  final AddStoryController controller = AddStoryController.to;

  @override
  void initState() {
    super.initState();
    SharedMethod.systemBarColor(
        AppStyles.colors.transparent, AppStyles.colors.bgDark);
    controller.viewModel.loadCurrentUserCoordinates().then((value) {
      controller.latitude = value.latitude.toString();
      controller.longitude = value.longitude.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;

    return WillPopScope(
      onWillPop: () {
        SharedMethod.systemBarColor(
            AppStyles.colors.transparent, AppStyles.colors.white);
        Future.delayed(750.milliseconds, () {
          controller.deleteCacheImage();
          controller.isImageDeleted(false);
        });
        return Future<bool>.value(true);
      },
      child: Scaffold(
          backgroundColor: AppStyles.colors.bgDark,
          body: Container(
            padding: EdgeInsets.only(
                right: SizeConfig.blockWidth * 5,
                left: SizeConfig.blockWidth * 5),
            child: Obx(
              () => Center(
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        isKeyboardShowing
                            ? const SizedBox()
                            : Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Divider(
                                      height: 2,
                                      color: AppStyles.colors.white,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Center(
                                      child: Text(
                                        "addStory".tr,
                                        style: AppStyles.textStyles.poppinsBold
                                            .copyWith(
                                                color: AppStyles.colors.white,
                                                fontSize:
                                                    SizeConfig.blockWidth *
                                                        6.5),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Divider(
                                      height: 2,
                                      color: AppStyles.colors.white,
                                    ),
                                  ),
                                ],
                              ),

                        //photo profile
                        Container(
                          margin:
                              EdgeInsets.only(top: SizeConfig.blockWidth * 6),
                          child: DottedBorder(
                            dashPattern: const [20, 10],
                            strokeWidth: 2,
                            color: AppStyles.colors.white,
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(12),
                            padding:
                                EdgeInsets.all(SizeConfig.blockWidth * 2.5),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              child: AnimatedContainer(
                                duration: 400.milliseconds,
                                height: isKeyboardShowing
                                    ? SizeConfig.blockWidth * 45
                                    : SizeConfig.blockWidth * 83,
                                width: isKeyboardShowing
                                    ? SizeConfig.blockWidth * 45
                                    : SizeConfig.blockWidth * 83,
                                color: AppStyles.colors.transparent,
                                child: Stack(
                                  children: <Widget>[
                                    //Image from local storage
                                    Positioned.fill(
                                      child: GestureDetector(
                                        onTap: () {
                                          showingModalBottomSheet();
                                        },
                                        child: (controller
                                                    .cropImagePath.value !=
                                                "")
                                            //Image Viewer
                                            ? Container(
                                                decoration: BoxDecoration(
                                                    color: AppStyles
                                                        .colors.transparent,
                                                    image: DecorationImage(
                                                        image: FileImage(File(
                                                            controller
                                                                .cropImagePath
                                                                .value)),
                                                        fit: BoxFit.cover)),
                                              )
                                            //Photo Picker
                                            : Container(
                                                decoration: BoxDecoration(
                                                  color: AppStyles
                                                      .colors.transparent,
                                                ),
                                                child: Center(
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.camera_alt,
                                                          size: isKeyboardShowing
                                                              ? SizeConfig
                                                                      .blockWidth *
                                                                  9
                                                              : SizeConfig
                                                                      .blockWidth *
                                                                  14,
                                                          color: AppStyles
                                                              .colors.white,
                                                        ),
                                                        SizedBox(
                                                          height: SizeConfig
                                                                  .blockWidth *
                                                              2.5,
                                                        ),
                                                        Text(
                                                          "Ambil Gambar",
                                                          maxLines: 2,
                                                          style: AppStyles
                                                              .textStyles
                                                              .poppinsMedium
                                                              .copyWith(
                                                                  fontSize: isKeyboardShowing
                                                                      ? SizeConfig
                                                                              .blockWidth *
                                                                          3.5
                                                                      : SizeConfig
                                                                              .blockWidth *
                                                                          5.0,
                                                                  color: AppStyles
                                                                      .colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900),
                                                          textAlign:
                                                              TextAlign.center,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          controller.deleteCacheImage();
                                        },
                                        child: Container(
                                          height: SizeConfig.blockWidth * 15,
                                          width: SizeConfig.blockWidth * 15,
                                          decoration: BoxDecoration(
                                              color: AppStyles.colors.white,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(12),
                                              )),
                                          child: Center(
                                            child: Text(
                                              "X",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize:
                                                      SizeConfig.blockWidth *
                                                          5.5,
                                                  color:
                                                      AppStyles.colors.bgDark),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockWidth * 6,
                        ),
                        //fullname
                        CustomTextField(
                          controller:
                              controller.descriptionTextEditingController,
                          hintText: "Masukan deskripsi disini",
                          currentNode: controller.descriptionFocusNode,
                          nextNode: null,
                          icon: Icons.description,
                          useSuffixIcon: false,
                          textCapitalization: TextCapitalization.words,
                        ),

                        SizedBox(
                          height: SizeConfig.blockWidth * 1.5,
                        ),
                        //
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.white),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(
                                SizeConfig.blockWidth * 3,
                              ),
                              topLeft: Radius.circular(
                                SizeConfig.blockWidth * 3,
                              ),
                              bottomLeft: Radius.circular(
                                (controller.isShare.value == true)
                                    ? 0
                                    : SizeConfig.blockWidth * 3,
                              ),
                              bottomRight: Radius.circular(
                                (controller.isShare.value == true)
                                    ? 0
                                    : SizeConfig.blockWidth * 3,
                              ),
                            ),
                          ),
                          padding: EdgeInsets.all(SizeConfig.blockWidth * 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 4.0 * SizeConfig.blockWidth,
                                  ),
                                  Center(
                                    child: Text(
                                      'Share my location',
                                      style: AppStyles.textStyles.poppinsMedium
                                          .copyWith(
                                              fontSize:
                                                  SizeConfig.blockWidth * 3.5,
                                              color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              Switch(
                                // This bool value toggles the switch.
                                value: controller.isShare.value,
                                activeColor: Colors.cyan,
                                inactiveTrackColor:
                                    Colors.white.withOpacity(0.5),
                                onChanged: (bool value) {
                                  setState(() {
                                    controller.isShare.value = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.descriptionFocusNode.unfocus();
                            GoRouter.of(context).push(AppRoutes.mapPicker);
                          },
                          child: IntrinsicHeight(
                            child: AnimatedContainer(
                              height: (controller.isShare.value == true)
                                  ? 13.5 * SizeConfig.blockWidth
                                  : 0,
                              duration: 200.milliseconds,
                              decoration: BoxDecoration(
                                color: AppStyles.colors.white,
                                border:
                                    Border.all(width: 2, color: Colors.white),
                                borderRadius: BorderRadius.only(
                                  topRight: const Radius.circular(0),
                                  topLeft: const Radius.circular(0),
                                  bottomLeft: Radius.circular(
                                    SizeConfig.blockWidth * 3,
                                  ),
                                  bottomRight: Radius.circular(
                                    SizeConfig.blockWidth * 3,
                                  ),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.blockWidth * 1,
                                  vertical: SizeConfig.blockWidth * 3.5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 4.0 * SizeConfig.blockWidth,
                                      ),
                                      Center(
                                        child: Text(
                                          'Use custom location',
                                          style: AppStyles
                                              .textStyles.poppinsMedium
                                              .copyWith(
                                                  fontSize:
                                                      SizeConfig.blockWidth *
                                                          3.5,
                                                  color:
                                                      AppStyles.colors.bgDark),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.chevron_right,
                                        color: AppStyles.colors.bgDark,
                                        size: 5.0 * SizeConfig.blockWidth,
                                      ),
                                      SizedBox(
                                        width: 4.0 * SizeConfig.blockWidth,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        //
                        SizedBox(
                          height: 4.5 * SizeConfig.blockWidth,
                        ),
                        //Button
                        controller.isLoading.value == true
                            ? SizedBox(
                                height: isKeyboardShowing
                                    ? 0
                                    : SizeConfig.blockWidth * 15,
                                child: Center(
                                  child: SpinKitWave(
                                    size: SizeConfig.blockWidth * 5,
                                    color: AppStyles.colors.white,
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: isKeyboardShowing
                                    ? 0
                                    : SizeConfig.blockWidth * 15,
                                child: CustomButton(
                                    function: () {
                                      SharedMethod.checkConnectionBeforeExecute(
                                          controller.handleUpdate(context));
                                    },
                                    title: "save".tr,
                                    color: AppStyles.colors.cyan,
                                    borderColor: AppStyles.colors.cyan,
                                    titleColor: AppStyles.colors.bgDark,
                                    height: SizeConfig.blockWidth * 15,
                                    fontSize: 4.2 * SizeConfig.blockWidth,
                                    onlyIcon: false),
                              )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }

  void showingModalBottomSheet() {
    if (controller.cropImagePath.value == "") {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              decoration: BoxDecoration(
                color: AppStyles.colors.bgDark,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(2.0 * SizeConfig.blockWidth),
                  topRight: Radius.circular(2.0 * SizeConfig.blockWidth),
                ),
              ),
              height: 35.0 * SizeConfig.blockWidth,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.image,
                        color: AppStyles.colors.white,
                        size: SizeConfig.blockWidth * 6,
                      ),
                      title: Text(
                        'Gallery',
                        style: TextStyle(
                          fontSize: 4.0 * SizeConfig.blockWidth,
                          fontWeight: FontWeight.w500,
                          color: AppStyles.colors.white,
                        ),
                      ),
                      onTap: () {
                        controller.pickImage(
                            imageSource: ImageSource.gallery,
                            filename: StorageServices()
                                .getUserInfo()
                                .userId
                                .toString(),
                            context: context);
                        GoRouter.of(context).pop();
                        // Navigator.pop(context);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.blockWidth * 3),
                      child: Divider(
                        height: 2,
                        color: AppStyles.colors.white.withOpacity(0.3),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.camera_alt,
                        color: AppStyles.colors.white,
                        size: SizeConfig.blockWidth * 6,
                      ),
                      title: Text(
                        'Camera',
                        style: TextStyle(
                            fontSize: 4.0 * SizeConfig.blockWidth,
                            fontWeight: FontWeight.w500,
                            color: AppStyles.colors.white),
                      ),
                      onTap: () {
                        controller.pickImage(
                            imageSource: ImageSource.camera,
                            filename: StorageServices()
                                .getUserInfo()
                                .userId
                                .toString(),
                            context: context);
                        GoRouter.of(context).pop();
                        // Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            );
          });
    }
  }
}
