import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:storyz/app/constants/constants.dart';
import 'package:storyz/app/utils/utils.dart';
import 'package:storyz/app/widgets/widgets.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  SettingPageState createState() => SettingPageState();
}

class SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    super.initState();
    SharedMethod.systemBarColor(
        AppStyles.colors.transparent, AppStyles.colors.bgDark);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.colors.bgDark,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 6)
            .copyWith(top: SizeConfig.blockWidth * 11),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              //Header

              Padding(
                padding: EdgeInsets.only(bottom: SizeConfig.blockWidth * 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Divider(
                        height: 2,
                        color: AppStyles.colors.white,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Center(
                        child: Text(
                          "appearance".tr,
                          style: AppStyles.textStyles.poppinsBold.copyWith(
                              color: AppStyles.colors.white,
                              fontSize: SizeConfig.blockWidth * 6),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Divider(
                        height: 2,
                        color: AppStyles.colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              ListItem(
                icon: Icons.language_outlined,
                text: "languages".tr,
                function: () {
                  GoRouter.of(context).pushNamed(AppRoutes.languagePage);

                  // Get.toNamed(AppRoutes.languagePage);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
