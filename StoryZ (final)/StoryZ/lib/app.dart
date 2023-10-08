import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storyz/app/constants/constants.dart';
import 'package:storyz/app/services/local/localization_services.dart';
import 'package:storyz/app/services/local/storage_service.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      routeInformationParser: AppRoutes.router.routeInformationParser,
      routeInformationProvider: AppRoutes.router.routeInformationProvider,
      routerDelegate: AppRoutes.router.routerDelegate,
      backButtonDispatcher: AppRoutes.router.backButtonDispatcher,
      //
      debugShowCheckedModeBanner: false,
      enableLog: false,
      //

      color: AppStyles.colors.bgDark,
      theme: AppStyles.theme.defaultTheme,
      // defaultTransition: Transition.fadeIn,
      //
      // getPages: AppRoutes.getPages,
      // initialRoute: AppRoutes.splashPage,
      //
      locale:
          StorageServices().getLanguage() == LocalizationServices.langs.first
              ? LocalizationServices.engLocale
              : LocalizationServices.idLocale,
      fallbackLocale: LocalizationServices.idLocale,
      translations: LocalizationServices(),
    );
  }
}
