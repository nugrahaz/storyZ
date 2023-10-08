import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:storyz/app/models/login_model.dart';
import 'package:storyz/app/models/registration_model.dart';
import 'package:storyz/app/services/remote/api_service.dart';
import 'package:storyz/app/utils/utils.dart';

import '../../../constants/constants.dart';
import '../../../services/local/storage_service.dart';

class AuthenticationController extends GetxController {
  static final AuthenticationController to =
      Get.find<AuthenticationController>();

  late TextEditingController usernameTextEditingController;
  late TextEditingController emailTextEditingController;
  late TextEditingController passwordTextEditingController;

  late FocusNode fullnameFocus;
  late FocusNode emailFocus;
  late FocusNode passwordFocus;

  RxBool isLoading = false.obs;
  RxBool passwordVisibility = true.obs;
  RxBool isLoginScreen = true.obs;

  @override
  void onInit() {
    usernameTextEditingController = TextEditingController();
    emailTextEditingController = TextEditingController();
    passwordTextEditingController = TextEditingController();
    fullnameFocus = FocusNode();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
    super.onInit();
  }

  @override
  void onClose() {
    unFocusTextField();
    Get.delete<AuthenticationController>();
    super.onClose();
  }

  Future<void> loginC(BuildContext context) async {
    if (emailTextEditingController.text.isEmpty) {
      SharedMethod.showSnackBar(
          title: "emailNull".tr, description: "fieldNull".tr, context: context);
    } else if (passwordTextEditingController.text.isEmpty) {
      SharedMethod.showSnackBar(
          title: "passwordNull".tr,
          description: "fieldNull".tr,
          context: context);
    } else {
      if (!GetUtils.isEmail(emailTextEditingController.text)) {
        SharedMethod.showSnackBar(
            title: "emailInvalid".tr,
            description: "emailInvalidDesc".tr,
            context: context);
      } else {
        isLoading(true);
        try {
          ApiService apiService = ApiService();
          LoginModel dataLogin = LoginModel(
            email: emailTextEditingController.text.trim(),
            password: passwordTextEditingController.text.trim(),
          );

          var result = await apiService.login(loginModel: dataLogin);

          if (result.error == true) {
            SharedMethod.showSnackBar(
                title: result.message.toString(),
                description: "Information from server",
                context: context);
          } else {
            StorageServices services = StorageServices();
            // save user ke local storage
            services.setIsLogged(true);
            services
                .setUserInfo(result.loginResult!)
                .then((_) => {
                      GoRouter.of(context)
                          .pushReplacementNamed(AppRoutes.mainPage)
                    })
                .then((value) => services.getUserInfo());

            clearTextField();
          }
        } catch (error) {
          debugPrint(error.toString());
        } finally {
          Future.delayed(750.milliseconds, () {
            isLoading(false);
          });
        }
      }
    }
  }

  Future<void> registrationC({required BuildContext context}) async {
    if (usernameTextEditingController.text.isEmpty) {
      SharedMethod.showSnackBar(
          title: "fullnameNull".tr,
          description: "fieldNull".tr,
          context: context);
    } else if (emailTextEditingController.text.isEmpty) {
      SharedMethod.showSnackBar(
          title: "emailNull".tr, description: "fieldNull".tr, context: context);
    } else if (passwordTextEditingController.text.isEmpty) {
      SharedMethod.showSnackBar(
          title: "passwordNull".tr,
          description: "fieldNull".tr,
          context: context);
    } else if (passwordTextEditingController.text.length < 8) {
      SharedMethod.showSnackBar(
          title: "Password minimal 8 karakter",
          description: "Silahkan perbaiki password Anda",
          context: context);
    } else {
      if (!GetUtils.isEmail(emailTextEditingController.text)) {
        SharedMethod.showSnackBar(
            title: "emailInvalid".tr,
            description: "emailInvalidDesc".tr,
            context: context);
      } else {
        isLoading(true);
        try {
          ApiService apiService = ApiService();
          RegistrationModel dataRegistration = RegistrationModel(
            name: usernameTextEditingController.text.trim(),
            email: emailTextEditingController.text.trim(),
            password: passwordTextEditingController.text.trim(),
          );

          var result = await apiService.registration(
              registrationModel: dataRegistration);

          SharedMethod.showSnackBar(
              title: result.message.toString(),
              description: "Information from server",
              context: context);
          if (result.error != true) {
            clearTextField();
            isLoginScreen(true);
          }
        } catch (error) {
          debugPrint(error.toString());
        } finally {
          Future.delayed(500.milliseconds, () {
            isLoading(false);
          });
        }
      }
    }
    update();
  }

  void switchScreen() {
    isLoginScreen.value = !isLoginScreen.value;
    unFocusTextField(); //memperbaiki auto focus pas di klik back
  }

  void unFocusTextField() {
    emailFocus.unfocus();
    fullnameFocus.unfocus();
    passwordFocus.unfocus();
  }

  void clearTextField() {
    emailTextEditingController.clear();
    usernameTextEditingController.clear();
    passwordTextEditingController.clear();
  }

  void checkPasswordVisibility() =>
      passwordVisibility.value = !passwordVisibility.value;
}
