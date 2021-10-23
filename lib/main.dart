import 'package:config_generator/login_page.dart';
import 'package:flutter/material.dart';
import 'file_handle.dart';
import 'inputs_page.dart';
import 'landingpage.dart';

// import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        primaryColor: Colors.blue[100],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Landing(),
      // home: loginStatus ? Landing() : LoginPage(), FileHandle()
    ),
  );
}

// to start the login, set - home: LoginPage()
// to start the app, set - home: Landing()
// to start the inputs, set - home: Inputs_page()
// to start the testing_page, set - home: TestClass() or Testing()
// to start the mainpage, set - home: MainPage()

// https://drive.google.com/file/d/1jDtjua4V-lsPBm14kEMR3mwCF7T8ZQQw/view?usp=sharing
// viewer // https://drive.google.com/file/d/1k0DViG-D7f2rcCyLeULGYvCaaynEmPwh/view?usp=sharing
