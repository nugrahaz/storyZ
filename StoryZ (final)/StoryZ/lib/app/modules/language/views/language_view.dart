import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storyz/app/constants/constants.dart';
import 'package:storyz/app/modules/language/views/component/menu_options_screen.dart';
import 'package:storyz/app/utils/utils.dart';

class ChangeLanguagePage extends StatefulWidget {
  const ChangeLanguagePage({Key? key}) : super(key: key);

  @override
  ChangeLanguagePageState createState() => ChangeLanguagePageState();
}

class ChangeLanguagePageState extends State<ChangeLanguagePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppStyles.colors.bgDark,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 5),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  AssetsPaths.icons.translate,
                  width: SizeConfig.blockWidth * 50,
                  color: AppStyles.colors.white,
                ),
                SizedBox(
                  height: 2.0 * SizeConfig.blockWidth,
                ),
                IntrinsicHeight(
                  child: Padding(
                    padding: EdgeInsets.only(right: SizeConfig.blockWidth * 6),
                    child: SizedBox.expand(
                      child: Text(
                        'selectLang'.tr,
                        textAlign: TextAlign.start,
                        style: AppStyles.textStyles.poppinsBold.copyWith(
                          fontSize: 5.2 * SizeConfig.blockWidth,
                          letterSpacing: 1.8,
                          color: AppStyles.colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: 8.0 * SizeConfig.blockWidth,
                        top: SizeConfig.blockWidth * 6),
                    child: DottedBorder(
                      color: AppStyles.colors.white,
                      dashPattern: const [12, 18],
                      strokeWidth: 2,
                      child: Container(
                        height: 0.1,
                      ),
                    )),
                const MenuOptionsScreen()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
