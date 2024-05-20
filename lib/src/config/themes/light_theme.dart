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
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0.0,
        titleTextStyle: TextStyle(
          fontSize: 28,
          color: Colors.black,
          fontWeight: FontWeight.w800,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
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

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        showUnselectedLabels: false,
        selectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      // *******( End bottomNavigationBarTheme )*******
    );
