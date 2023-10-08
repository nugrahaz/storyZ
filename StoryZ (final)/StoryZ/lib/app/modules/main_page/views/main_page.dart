import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:storyz/app/constants/constants.dart';
import 'package:storyz/app/modules/list_story/views/list_story_page.dart';
import 'package:storyz/app/modules/main_page/controllers/home_controller.dart';
import 'package:storyz/app/modules/main_page/views/component/list_menu_drawer_screen.dart';
import 'package:storyz/app/services/local/storage_service.dart';
import 'package:storyz/app/utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final HomeController _mainController = HomeController.to;

  GetStorage box = GetStorage();

  @override
  void initState() {
    SharedMethod.systemBarColor(AppStyles.colors.white, AppStyles.colors.white);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleBack(
        onFirstBackPress: (context) {
          SharedMethod.showSnackBar(
              title: "pressMore".tr,
              description: "toLeave".tr,
              context: context);
        },
        waitForSecondBackPress: 3,
        child: Stack(
          children: [
            Container(
              color: AppStyles.colors.bgDark,
              padding: EdgeInsets.only(
                  left: 4.5 * SizeConfig.blockWidth,
                  bottom: 20.0 * SizeConfig.blockWidth),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ListMenuDrawerScreen(
                    text: "addStory".tr,
                    icon: Icons.add_circle_outline_outlined,
                    function: () {
                      if (_mainController.getDrawerIsOpen == true) {
                        _mainController.drawerIsOpen(
                            false,
                            AppStyles.colors.transparent,
                            AppStyles.colors.white);
                      }

                      Future.delayed(300.milliseconds, () {
                        // Get.toNamed(AppRoutes.addStoriesPage);
                        GoRouter.of(context)
                            .pushNamed(AppRoutes.addStoriesPage);
                      });
                    },
                  ),
                  SizedBox(
                    height: 5.9 * SizeConfig.blockWidth,
                  ),
                  ListMenuDrawerScreen(
                    text: 'Settings'.tr,
                    icon: Icons.settings,
                    function: () {
                      if (_mainController.getDrawerIsOpen == true) {
                        _mainController.drawerIsOpen(
                            false,
                            AppStyles.colors.transparent,
                            AppStyles.colors.white);
                      }

                      Future.delayed(300.milliseconds, () {
                        // Get.toNamed(AppRoutes.settingPage);
                        GoRouter.of(context).pushNamed(AppRoutes.settingPage);
                      });
                    },
                  ),

                  SizedBox(
                    height: 3.7 * SizeConfig.blockWidth,
                  ),
                  Divider(
                    color: AppStyles.colors.white,
                  ),
                  SizedBox(
                    height: 3.7 * SizeConfig.blockWidth,
                  ),
                  //
                  ListMenuDrawerScreen(
                    text: "suggestions".tr,
                    icon: Icons.description_outlined,
                    function: () {},
                  ),

                  SizedBox(
                    height: 5.9 * SizeConfig.blockWidth,
                  ),
                  ListMenuDrawerScreen(
                    text: "about".tr,
                    icon: Icons.info_outline_rounded,
                    function: () {
                      //
                    },
                  ),
                  SizedBox(
                    height: 5.9 * SizeConfig.blockWidth,
                  ),
                  ListMenuDrawerScreen(
                    text: "logout".tr,
                    icon: Icons.logout_sharp,
                    function: () {
                      SharedMethod.customDialog(
                        title: 'Keluar',
                        description:
                            "Hai, ${StorageServices().getUserInfo().name}. Apakah Anda ingin meninggalkan akun ini?",
                        function: () {
                          StorageServices().clearUserData().then((_) {
                            GoRouter.of(context).pushReplacementNamed(
                                AppRoutes.authenticationPage);
                          });

                          if (_mainController.getDrawerIsOpen == true) {
                            _mainController.drawerIsOpen(
                                false,
                                AppStyles.colors.transparent,
                                AppStyles.colors.bgDark);
                          }
                        },
                        buttonText: 'Keluar',
                        imagePath: AssetsPaths.lotties.exit,
                        colorStatusBar: AppStyles.colors.transparent,
                        colorNavigationBar: AppStyles.colors.bgDark,
                        context: context,
                      );
                    },
                  ),
                  SizedBox(
                    height: 5.9 * SizeConfig.blockWidth,
                  ),
                ],
              ),
            ),
            const ListStoryPage(),
          ],
        ),
      ),
    );
  }
}
