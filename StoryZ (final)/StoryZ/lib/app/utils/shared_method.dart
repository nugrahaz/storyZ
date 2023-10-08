part of 'utils.dart';

bool isIntersect(List listOne, List listTwo) {
  return listOne.toSet().intersection(listTwo.toSet()).isNotEmpty;
}

class SharedMethod {
  //Coloring System Bar
  static void systemBarColor(Color statusColor, Color navColor) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: statusColor, //top bar color
      statusBarIconBrightness: (statusColor != AppStyles.colors.white)
          ? Brightness.light
          : Brightness.dark, //top bar icons
      systemNavigationBarColor: navColor, //bottom bar color
      systemNavigationBarIconBrightness: (navColor != AppStyles.colors.white)
          ? Brightness.light
          : Brightness.dark, //bottom bar icons
    ));
  }

  //Check Connection
  static void checkConnectionBeforeExecute(void functions) async {
    var result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.none) {
      Get.dialog(
          NoConnectionDialog(
            colorNavigationBar: AppStyles.colors.bgDark,
          ),
          barrierDismissible: true);
    } else {
      functions;
    }
  }

  static void customDialog(
      {String? title,
      String? imagePath,
      String? description,
      String? buttonText,
      Function()? function,
      Color? colorStatusBar,
      Color? colorNavigationBar,
      required BuildContext context}) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CustomDialog(
          title: title ?? "Keluar",
          imagePath: imagePath ?? AssetsPaths.lotties.exit,
          description:
              description ?? "Apakah Anda ingin meninggalkan aplikasi ini?",
          buttonText: buttonText ?? "Ya, tentu",
          function: function ??
              () {
                // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                exit(0);
                // GoRouter.of(context).pop(context, true);
              },
          colorStatusBar: colorStatusBar,
          colorNavigationBar: colorNavigationBar,
        );
      },
    );
  }

  static void showSnackBar(
      {required String title,
      required String description,
      required BuildContext context}) {
    final snackBar = SnackBar(
      /// need to set following properties for best effect of flutter_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: FlutterSnackbarContent(
        message: title,
        contentType: ContentType.warning,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  // Get.snackbar(
  //   "", "",
  //   titleText: Padding(
  //     padding: EdgeInsets.only(left: SizeConfig.blockWidth * 3),
  //     child: Text(
  //       title,
  //       style: AppStyles.textStyles.poppinsMedium.copyWith(
  //         color: AppStyles.colors.white,
  //         fontSize: 3.2 * SizeConfig.blockWidth,
  //         wordSpacing: 0.3,
  //         letterSpacing: 0.3,
  //       ),
  //     ),
  //   ),
  //
  //   messageText: Padding(
  //     padding: EdgeInsets.only(
  //       left: SizeConfig.blockWidth * 3,
  //     ),
  //     child: Text(
  //       description,
  //       style: AppStyles.textStyles.poppinsMedium.copyWith(
  //         fontSize: 2.9 * SizeConfig.blockWidth,
  //         color: AppStyles.colors.white,
  //         wordSpacing: 0.6,
  //         letterSpacing: 0.6,
  //       ),
  //     ),
  //   ),
  //
  //   // borderRadius: 0,
  //   shouldIconPulse: false,
  //   icon: Container(
  //     padding: EdgeInsets.only(left: 4.0 * SizeConfig.blockWidth),
  //     child: Icon(
  //       Icons.info_outline_rounded,
  //       color: AppStyles.colors.white,
  //       size: 7.0 * SizeConfig.blockWidth,
  //     ),
  //   ),
  //   isDismissible: false,
  //   dismissDirection: DismissDirection.horizontal,
  //   forwardAnimationCurve: Curves.fastOutSlowIn,
  //   duration: const Duration(milliseconds: 3000),
  //   animationDuration: const Duration(milliseconds: 750),
  //   margin: EdgeInsets.all(6.25 * SizeConfig.blockWidth),
  //   snackPosition: SnackPosition.BOTTOM,
  //   backgroundColor: Colors.blueGrey,
  //   colorText: AppStyles.colors.white,
  // );

  static void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
