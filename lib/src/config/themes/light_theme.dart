import 'package:social_app/src/core/utls/constants/constants.dart';

import 'theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData getLightTheme() => ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: HexColor('#191b1c'),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),

      // *******( Start TabBarTheme )******
      // tabBarTheme: TabBarTheme(
      //   labelColor: Colors.black,
      //   indicatorColor: HexColor('#8eb93a'),
      //   indicator: UnderlineTabIndicator(
      //     borderSide: BorderSide(
      //       color: HexColor('#bbe362'),
      //       width: 4,
      //     ),
      //   ),
      //   unselectedLabelStyle: const TextStyle(
      //     fontSize: 20,
      //     color: Colors.black,
      //     // fontWeight: FontWeight.bold,
      //   ),
      //   labelStyle: const TextStyle(
      //     fontSize: 20,
      //     color: Colors.black,
      //     fontWeight: FontWeight.bold,
      //   ),
      // ),
      // // *******( End TabBarTheme )******

      // *******( Start AppBarTheme )******
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: HexColor('#191b1c'),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0.0,
        titleTextStyle: const TextStyle(
          fontSize: 20.0,
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontFamily: 'poppins',
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('#191b1c'),
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      // *******( End AppBarTheme )******

      // *******( Start inputDecorationTheme )******
      inputDecorationTheme: const InputDecorationTheme(
        errorStyle: TextStyle(
          // color: Colors.red,
          fontSize: 16.0,
          // fontWeight: FontWeigh,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        prefixIconColor: Colors.black,
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        suffixIconColor: Colors.black,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: .8,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: .8,
          ),
        ),
      ),
      // *******( End inputDecorationTheme )******

      fontFamily: 'poppins',
      primarySwatch: mainAppColorLight,

      // *******( Start TextTheme )*******
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          fontSize: 47,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        bodySmall: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
        displaySmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      // *******( End TextTheme )*******

      // *******( Start filledButtonTheme )*******
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          textStyle: const MaterialStatePropertyAll(
            TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          backgroundColor: MaterialStatePropertyAll(HexColor('#c0e863')),
        ),
      ),
      // *******( End filledButtonTheme )*******

      // *******( Start bottomNavigationBarTheme )*******

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0.0,
        backgroundColor: HexColor('#191b1c'),
        unselectedItemColor: Colors.grey,
        selectedItemColor: mainColor,
        showUnselectedLabels: false,
        selectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      // *******( End bottomNavigationBarTheme )*******
    );
