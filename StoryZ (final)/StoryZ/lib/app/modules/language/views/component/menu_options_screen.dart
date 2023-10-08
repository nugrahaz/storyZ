import 'package:flutter/material.dart';
import 'package:storyz/app/constants/constants.dart';
import 'package:storyz/app/modules/language/views/component/list_language.dart';
import 'package:storyz/app/services/local/localization_services.dart';

class MenuOptionsScreen extends StatefulWidget {
  const MenuOptionsScreen({Key? key}) : super(key: key);

  @override
  MenuOptionsScreenState createState() => MenuOptionsScreenState();
}

class MenuOptionsScreenState extends State<MenuOptionsScreen> {
  int _selectedOption = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: LocalizationServices.langs.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return const SizedBox();
        } else if (index == LocalizationServices.langs.length + 1) {
          return const SizedBox();
        } else {
          return ListLanguage(
              assetPath: LocalizationServices.iconLangs[index - 1],
              title: LocalizationServices.langs[index - 1],
              borderColor: _selectedOption == index
                  ? Colors.cyan
                  : AppStyles.colors.white,
              function: () {
                LocalizationServices()
                    .changeLocale(LocalizationServices.langs[index - 1]);
                setState(() {
                  _selectedOption = index;
                });
              });
        }
      },
    );
  }
}
