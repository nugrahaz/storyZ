import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:storyz/app/constants/constants.dart';
import 'package:storyz/app/modules/splash/controllers/splash_controller.dart';
import 'package:storyz/app/utils/utils.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.openStartPage(context);

    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppStyles.colors.bgDark,
      body: Stack(
        children: [
          SizedBox(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: SizeConfig.blockWidth * 15,
                  ),
                  Container(
                    height: SizeConfig.blockWidth * 50,
                    padding: EdgeInsets.only(bottom: SizeConfig.blockWidth * 4),
                    child: Lottie.asset(
                      AssetsPaths.lotties.story,
                      reverse: false,
                      repeat: false,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    "StoryZ",
                    style: AppStyles.textStyles.poppinsBold.copyWith(
                        color: AppStyles.colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        wordSpacing: 0.2,
                        fontSize: SizeConfig.blockWidth * 5.5),
                  ),
                  SizedBox(
                    height: SizeConfig.blockWidth * 30.0,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: SizeConfig.blockWidth * 5.0,
            right: 0,
            left: 0,
            child: Center(
              child: DelayedWidget(
                delayDuration: 1.5.seconds,
                animationDuration: 500.milliseconds,
                child: Text(
                  "Ver 1.0.0",
                  style: AppStyles.textStyles.poppinsSemiBold.copyWith(
                      color: AppStyles.colors.white,
                      fontSize: SizeConfig.blockWidth * 3.5,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.2),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
