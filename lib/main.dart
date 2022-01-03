import 'login_page.dart';
import 'package:flutter/material.dart';
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
      // home: getImage(),
      home: loginStatus ? Landing() : LoginPage(), // FileHandle()
    ),
  );
}

/* go to landingpage.dart file and find "put URL here" comment
change its link to the desired link for the webview.
 */