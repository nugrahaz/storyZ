part of 'utils.dart';

class SizeConfig {
  static late MediaQueryData _mediaQuery;
  static double screenWidth = 0;
  static double screenHeight = 0;

  static double blockWidth = 0;
  static double blockHeight = 0;

  void init(BuildContext context) {
    _mediaQuery = MediaQuery.of(context);
    screenWidth = _mediaQuery.size.width;
    screenHeight = _mediaQuery.size.height;

    blockWidth = screenWidth / 100;
    blockHeight = screenHeight / 100;
  }
}
