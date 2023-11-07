import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double pageView = screenHeight / 2.78;
  static double pageViewContainer = screenHeight / 4.04;
  static double pageViewTextContainer = screenHeight / 7.41;

//dynamic height padding and margin
  static double height10 = screenHeight / 89.02;
  static double height20 = screenHeight / 44.51;
  static double height15 = screenHeight / 59.34;
  static double height30 = screenHeight / 27.56;
  static double height45 = screenHeight / 18.37;

//button height
  static double bottomheightbar = screenHeight / 7.4;

//dynamic width padding and margin
  static double width10 = screenHeight / 89.02;
  static double width20 = screenHeight / 44.51;
  static double width15 = screenHeight / 59.34;
  static double width30 = screenHeight / 27.56;

//fontsizes
  static double font20 = screenHeight / 55.12;
  static double font26 = screenHeight / 34.24;
  static double font16 = screenHeight / 55.75;

  //radius
  static double radius15 = screenHeight / 59.34;
  static double radius20 = screenHeight / 59.34;
  static double radius30 = screenHeight / 27.56;

  //icons size
  static double iconSize24 = screenHeight / 34.45;
  static double iconSize16 = screenHeight / 55.64;

  //list view size
  static double listViewImageSize = screenWidth / 3.27;
  static double listViewTextCountSize = screenWidth / 3.927;

  //food details
  static double foodImageSize = screenWidth / 1.24;

  //splash screen
  static double splashImg = screenHeight / 3.40;
}
