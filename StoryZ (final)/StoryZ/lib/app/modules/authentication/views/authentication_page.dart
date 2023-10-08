import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:storyz/app/constants/constants.dart';
import 'package:storyz/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:storyz/app/utils/utils.dart';
import 'package:storyz/app/widgets/widgets.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationScreen();
}

class _AuthenticationScreen extends State<AuthenticationPage> {
  final AuthenticationController _authController = AuthenticationController.to;

  @override
  void initState() {
    SharedMethod.systemBarColor(
        AppStyles.colors.transparent, AppStyles.colors.bgDark);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;

    return WillPopScope(
      onWillPop: () {
        _authController.unFocusTextField();
        SharedMethod.customDialog(
            colorStatusBar: AppStyles.colors.transparent,
            colorNavigationBar: AppStyles.colors.bgDark,
            context: context);
        return Future<bool>.value(true);
      },
      child: Scaffold(
        backgroundColor: AppStyles.colors.bgDark,
        drawerScrimColor: AppStyles.colors.bgDark,
        body: Stack(
          children: [
            //gambar pojok kiri atas
            Positioned(
              top: -2.5 * SizeConfig.blockHeight,
              left: -7.0 * SizeConfig.blockWidth,
              child: Image.asset(
                AssetsPaths.images.flowTop,
                color: AppStyles.colors.cyan.withOpacity(0.2),
                width: 35.0 * SizeConfig.blockWidth,
              ),
            ),
            //gambar pojok kanan bawah
            Positioned(
              bottom: -2.0 * SizeConfig.blockHeight,
              right: -7.0 * SizeConfig.blockWidth,
              child: Image.asset(
                AssetsPaths.images.flowBottom,
                width: 40.0 * SizeConfig.blockWidth,
                color: AppStyles.colors.cyan.withOpacity(0.2),
              ),
            ),

            Obx(() => Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockWidth * 6),
                  child: Center(
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 3.0 * SizeConfig.blockHeight),
                          AnimatedContainer(
                            duration: 200.milliseconds,
                            height: (_authController.isLoginScreen.value)
                                ? 65.0 * SizeConfig.blockWidth
                                : !isKeyboardShowing
                                    ? 55.0 * SizeConfig.blockWidth
                                    : 45.0 * SizeConfig.blockWidth,
                            child: Lottie.asset(
                              AssetsPaths.lotties.feedback,
                              reverse: false,
                              fit: BoxFit.cover,
                            ),
                          ),
                          AnimatedContainer(
                              duration: 400.milliseconds,
                              height: isKeyboardShowing
                                  ? 1.0 * SizeConfig.blockHeight
                                  : 2.5 * SizeConfig.blockHeight),
                          AnimatedContainer(
                            duration: 200.milliseconds,
                            height:
                                (_authController.isLoginScreen.value == false)
                                    ? 20.0 * SizeConfig.blockWidth
                                    : 0,
                            child: (_authController.isLoginScreen.value ==
                                    false)
                                ? CustomTextField(
                                    controller: _authController
                                        .usernameTextEditingController,
                                    hintText: 'fullname'.tr,
                                    colorIcon: AppStyles.colors.cyan,
                                    currentNode: _authController.fullnameFocus,
                                    nextNode: _authController.emailFocus,
                                    useSuffixIcon: false,
                                    textCapitalization:
                                        TextCapitalization.words,
                                  )
                                : Container(),
                          ),
                          CustomTextField(
                            controller:
                                _authController.emailTextEditingController,
                            icon: Icons.email_outlined,
                            hintText: 'email'.tr,
                            colorIcon: AppStyles.colors.cyan,
                            currentNode: _authController.emailFocus,
                            nextNode: _authController.passwordFocus,
                            useSuffixIcon: false,
                            filteringTextInputFormatter: [
                              FilteringTextInputFormatter.deny(
                                  RegExp(r"\s\b|\b\s"))
                            ],
                          ),
                          CustomTextField(
                            controller:
                                _authController.passwordTextEditingController,
                            hintText: 'password'.tr,
                            visibility:
                                _authController.passwordVisibility.value,
                            currentNode: _authController.passwordFocus,
                            icon: Icons.lock_rounded,
                            colorIcon: AppStyles.colors.cyan,
                            useSuffixIcon: true,
                            iconSuffix:
                                _authController.passwordVisibility.value ==
                                        false
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.remove_red_eye,
                            function: () {
                              _authController.checkPasswordVisibility();
                            },
                            filteringTextInputFormatter: [
                              FilteringTextInputFormatter.deny(
                                  RegExp(r"\s\b|\b\s"))
                            ],
                            nextNode: null,
                          ),
                          SizedBox(
                            height: 1.5 * SizeConfig.blockHeight,
                          ),
                          //awalnya pake widget visibility
                          //cuman berhubung A13 menyisipkan
                          //soft animation di keyboard jadi janky
                          AnimatedContainer(
                            duration: 200.milliseconds,
                            height: isKeyboardShowing
                                ? 0
                                : 27.0 * SizeConfig.blockWidth,
                            child: Container(
                              color: AppStyles.colors.transparent,
                              child: SingleChildScrollView(
                                physics: const NeverScrollableScrollPhysics(),
                                // fix scroll
                                child: Column(
                                  children: [
                                    (_authController.isLoading.value)
                                        ? SizedBox(
                                            height: SizeConfig.blockWidth * 14,
                                            child: Center(
                                              child: SpinKitWave(
                                                color: AppStyles.colors.white,
                                                size: SizeConfig.blockWidth * 6,
                                              ),
                                            ),
                                          )
                                        : CustomButton(
                                            onlyIcon: false,
                                            borderRadius: 12,
                                            height: SizeConfig.blockWidth * 14,
                                            color: AppStyles.colors.cyan,
                                            borderColor: AppStyles.colors.cyan,
                                            titleColor: AppStyles.colors.bgDark,
                                            title: (_authController
                                                    .isLoginScreen.value)
                                                ? "login".tr
                                                : "registration".tr,
                                            function: () async {
                                              if (!Get.isSnackbarOpen) {
                                                _authController
                                                    .unFocusTextField();

                                                if (_authController
                                                    .isLoginScreen.value) {
                                                  _authController
                                                      .loginC(context);
                                                } else {
                                                  _authController.registrationC(
                                                      context: context);
                                                }
                                              }
                                            }),
                                    SizedBox(
                                        height: 4.0 * SizeConfig.blockWidth),
                                    GestureDetector(
                                      onTap: () {
                                        _authController.switchScreen();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(
                                            SizeConfig.blockWidth * 3),
                                        color: AppStyles.colors.transparent,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                (_authController
                                                        .isLoginScreen.value)
                                                    ? "dontHaveAnAccount".tr
                                                    : "alreadyHaveAnAccount".tr,
                                                style: AppStyles
                                                    .textStyles.poppinsMedium
                                                    .copyWith(
                                                        color: AppStyles
                                                            .colors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        letterSpacing: 0.3,
                                                        wordSpacing: 0.3,
                                                        fontSize: 3.4 *
                                                            SizeConfig
                                                                .blockWidth)),
                                            Text(
                                              (_authController
                                                      .isLoginScreen.value)
                                                  ? "registration".tr
                                                  : "login".tr,
                                              style: AppStyles
                                                  .textStyles.poppinsSemiBold
                                                  .copyWith(
                                                      color:
                                                          AppStyles.colors.cyan,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      letterSpacing: 0.2,
                                                      wordSpacing: 0.2,
                                                      fontSize: 3.4 *
                                                          SizeConfig
                                                              .blockWidth),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
