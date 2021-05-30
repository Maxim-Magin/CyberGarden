import 'package:flutter/material.dart';

class ApplicationImages{
  static String getFirstImage(){
    return "assets/firstImage.jpg";
  }
  static String getDefendersImage(){
    return "assets/defenders.jpg";
  }
  static String getSmokeImage(){
    return "assets/smoke.jpg";
  }
  static String getTheBestImage(){
    return "assets/theBest.jpg";
  }
  static String getCannonImage(){
    return "assets/cannon.png";
  }
  static String backgroundDefenders(){
    return "assets/background.jpg";
  }
  static String locationPointer(){
    return "assets/location-pointer.png";
  }
  static String team(){
    return "assets/team.png";
  }
  static String calendar(){
    return "assets/calday.png";
  }
  static String defendersScreen(){
    return "assets/back.jpg";
  }
  static String festivalMap(){
    return "assets/map.png";
  }

  static String code(){
    return "assets/code.jpg";
  }

  static List<String> photoGalleryLinks(){
    List<String> imagesLinks = [
      getFirstImage(),
      getDefendersImage(),
      getSmokeImage(),
      getTheBestImage(),
      getFirstImage(),
      getDefendersImage(),
      getSmokeImage(),
      getTheBestImage(),
      getFirstImage(),
      getDefendersImage(),
      getSmokeImage(),
      getTheBestImage(),
      getFirstImage(),
      getDefendersImage(),
      getSmokeImage(),
      getTheBestImage(),
    ];
    return imagesLinks;
  }
}