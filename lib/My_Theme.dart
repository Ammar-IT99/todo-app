import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryColor = const Color(0xff5D9CEC);
  static Color whiteColor = const Color(0xffFFFFFF);
  static Color blackcolor = const Color(0xff383838);
  static Color greenColor = const Color(0xff61E757);
  static Color redColor = const Color(0xffEC4B4B);
  static Color greyColor = const Color(0xff707070);
  static Color backGroundColor = const Color(0xffDFECDB);
  static Color blackDarkColor = const Color(0xff141922);
  static Color backGroundDarkColor = const Color(0xff091222);
  static ThemeData lightMode = ThemeData(
      primaryColor: primaryColor,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            side: BorderSide(color: MyTheme.blackcolor, width: 3)),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        shape: StadiumBorder(side: BorderSide(color: whiteColor, width: 6)),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: primaryColor,
        unselectedItemColor: greyColor,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      scaffoldBackgroundColor: backGroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      textTheme: TextTheme(
          titleLarge: TextStyle(
              color: blackcolor, fontSize: 22, fontWeight: FontWeight.bold),
          titleSmall: TextStyle(
              color: blackcolor, fontSize: 18, fontWeight: FontWeight.bold)
      )
  );
  static ThemeData darkMode = ThemeData(
    primaryColor: backGroundDarkColor,
    scaffoldBackgroundColor: backGroundDarkColor,
    appBarTheme:  AppBarTheme(
             backgroundColor: primaryColor,
        elevation: 0,

        iconTheme: IconThemeData(
            color: whiteColor
        ),
        centerTitle: true

    ),
    bottomNavigationBarTheme:BottomNavigationBarThemeData(
        selectedItemColor: primaryColor,
        unselectedItemColor: whiteColor,
        showUnselectedLabels: true,
        backgroundColor: backGroundDarkColor
    ) ,
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: whiteColor,
      ),
      titleMedium: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w500,
        color: whiteColor,
      ),
      titleSmall: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w400,
        color: whiteColor,
      ),
    ),
  );
}
