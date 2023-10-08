part of '../constants.dart';

class AppRoutes {
  static const splashPage = '/app/splashPage';
  static const authenticationPage = '/app/authPage';
  static const mainPage = '/app/mainPage';
  static const addStoriesPage = '/app/addStoriesPage';
  static const detailStoriesPage = '/app/detailStoriesPage';
  static const settingPage = '/app/settingPage';
  static const informationPage = '/app/informationPage';
  static const languagePage = '/app/languagePage';
  static const dialog = '/app/dialog';
  static const mapPicker = '/app/mapPickerPage';

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splashPage,
    routes: [
      GoRoute(
        name: AppRoutes.splashPage,
        path: AppRoutes.splashPage,
        builder: (context, state) => GetBuilder(
          init: SplashController(),
          dispose: (state) {
            Get.delete<SplashController>();
          },
          builder: (controller) => const SplashPage(),
        ),
      ),
      GoRoute(
        name: AppRoutes.authenticationPage,
        path: AppRoutes.authenticationPage,
        builder: (context, state) => GetBuilder(
          init: AuthenticationController(),
          dispose: (state) {
            Get.delete<AuthenticationController>();
          },
          builder: (controller) => const AuthenticationPage(),
        ),
      ),
      GoRoute(
        name: AppRoutes.mainPage,
        path: AppRoutes.mainPage,
        builder: (context, state) => GetBuilder(
          init: HomeController(),
          dispose: (state) {
            Get.delete<HomeController>();
          },
          builder: (controller) => const HomePage(),
        ),
      ),
      GoRoute(
        name: AppRoutes.addStoriesPage,
        path: AppRoutes.addStoriesPage,
        builder: (context, state) => GetBuilder(
          init: AddStoryController(),
          dispose: (state) {
            Get.delete<AddStoryController>();
          },
          builder: (controller) => const AddStoryPage(),
        ),
      ),
      GoRoute(
        name: AppRoutes.detailStoriesPage,
        path: AppRoutes.detailStoriesPage,
        builder: (context, state) => GetBuilder(
          init: ListStoryController(),
          dispose: (state) {
            Get.delete<ListStoryController>();
          },
          builder: (controller) {
            final id = state.extra as String;
            return DetailStoriesPage(
              storyId: id,
            );
          },
        ),
      ),
      GoRoute(
        name: AppRoutes.settingPage,
        path: AppRoutes.settingPage,
        builder: (context, state) => GetBuilder(
          init: ListStoryController(),
          dispose: (state) {
            Get.delete<ListStoryController>();
          },
          builder: (controller) => const SettingPage(),
        ),
      ),
      GoRoute(
        name: AppRoutes.languagePage,
        path: AppRoutes.languagePage,
        builder: (context, state) => GetBuilder(
          init: ListStoryController(),
          dispose: (state) {
            Get.delete<ListStoryController>();
          },
          builder: (controller) => const ChangeLanguagePage(),
        ),
      ),
      GoRoute(
        name: AppRoutes.mapPicker,
        path: AppRoutes.mapPicker,
        builder: (context, state) => GetBuilder(
          init: AddStoryController(),
          dispose: (state) {
            Get.delete<AddStoryController>();
          },
          builder: (controller) => const MapPicker(),
        ),
      ),
    ],
  );

// static final getPages = [
//   GetPage(
//     name: AppRoutes.splashPage,
//     page: () => const SplashPage(),
//     binding: SplashBinding(),
//   ),
//   GetPage(
//     name: AppRoutes.authenticationPage,
//     page: () => const AuthenticationPage(),
//     binding: AuthenticationBinding(),
//     transition: Transition.fadeIn,
//   ),
//   GetPage(
//     name: AppRoutes.mainPage,
//     page: () => const HomePage(),
//     bindings: [HomePageBinding(), ListStoryBinding()],
//     transition: Transition.cupertinoDialog,
//     transitionDuration: const Duration(milliseconds: 125),
//   ),
//   GetPage(
//       name: AppRoutes.addStoriesPage,
//       page: () => const AddStoryPage(),
//       transition: Transition.fadeIn,
//       binding: AddStoryBinding()),
//   GetPage(
//       name: AppRoutes.detailStoriesPage,
//       page: () => DetailStoriesPage(),
//       binding: ListStoryBinding()),
//   GetPage(
//     name: AppRoutes.settingPage,
//     page: () => const SettingPage(),
//     transition: Transition.fadeIn,
//     showCupertinoParallax: false,
//     preventDuplicates: false,
//     opaque: false,
//   ),
//   GetPage(
//     name: AppRoutes.languagePage,
//     page: () => const ChangeLanguagePage(),
//   ),
// ];
}
