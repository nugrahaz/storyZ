part of '../constants.dart';

class AssetsPaths {
  static final fontFamily = _FontFamily();
  static final lotties = _Lotties();
  static final icons = _Icons();
  static final images = _Images();
}

//Font Familly
class _FontFamily {
  final poppinsBold = 'poppins_bold';
  final poppinsMedium = 'poppins_medium';
  final poppinsSemiBold = 'poppins_semi_bold';
}

class _Icons {
  static const path = 'assets/icons';

  //
  final translate = '$path/translate.png';
  final indonesianFlag = '$path/indonesian.png';
  final englishFlag = '$path/english.png';
}

class _Lotties {
  static const path = 'assets/lotties';

  //
  final noConnection = "$path/no_connection.json";
  final exit = "$path/exit.json";
  final feedback = "$path/feedback.json";
  final checklist = "$path/checklist.json";
  final notFound = "$path/not_found.json";
  final info = "$path/info.json";
  final settings = "$path/settings.json";
  final lock = "$path/lock.json";
  final search = "$path/search.json";
  final searching = "$path/searching.json";
  final story = "$path/story.json";
}

class _Images {
  static const path = 'assets/images';
  final appLogo = '$path/app_logo.png';
  final chat = '$path/onboarding_chat.png';
  final observation = '$path/onboarding_observation.png';
  final campusLogo = '$path/campus_logo.png';

  //
  final information = '$path/menu_information.png';
  final messaging = '$path/menu_messaging.png';

  //
  final medicalDoctor = '$path/medical_doctor.png';
  final history = '$path/history.png';

  //
  final flowBottom = '$path/flow_bottom.png';
  final flowTop = '$path/flow_top.png';

  //
  final activityHistory = '$path/activity_history.png';
  final healthCheckup = '$path/health_checkup.png';
}
