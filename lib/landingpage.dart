import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './MainPage.dart';
import './inputs_page.dart';
import './web_view_page.dart';
import 'login_page.dart';

class Landing extends StatelessWidget {
  const Landing({Key? key}) : super(key: key);

  // IOT Programs Report Notification

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    AnimatedTextKit(
                      repeatForever: true,
                      stopPauseOnTap: false,
                      animatedTexts: [
                        RotateAnimatedText(
                          'WELCOME',
                          textStyle: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.headline2,
                              fontWeight: FontWeight.w900),
                        ),
                        RotateAnimatedText(
                          'TO',
                          textStyle: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.headline2,
                              fontWeight: FontWeight.w900),
                        ),
                        RotateAnimatedText(
                          'COGVISION',
                          textStyle: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.headline2,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                      onTap: () {
                        print("Tap Event");
                      },
                    ),
                    // Text(
                    //   'Welcome',
                    //   style: GoogleFonts.lato(
                    //       textStyle: Theme.of(context).textTheme.headline2,
                    //       fontWeight: FontWeight.w900),
                    //
                    // ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                child: Image.asset(
                  'assets/images/fly.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Stack(
                children: <Widget>[
                  GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 8,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    children: <Widget>[
                      Hero(
                        tag: 'btpage',
                        child: Card(
                          color: Colors.blue[50],
                          elevation: 5,
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainPage()));
                            },
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/images/bluetooth.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                  ),
                                  Text(
                                    'Bluetooth',
                                    style: GoogleFonts.lato(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'Control Bluetooth',
                                    style: GoogleFonts.lato(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Hero(
                        tag: 'web_view',
                        child: Card(
                          color: Colors.red[50],
                          clipBehavior: Clip.antiAlias,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PortalPage(
                                            link:
                                                'http://192.168.1.8:8085/mobile1iot?userId=$globaluserid',
                                            routes: 'web_view',
                                          )));
                            },
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/images/search.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                  ),
                                  Text(
                                    'Web View',
                                    style: GoogleFonts.lato(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'Glance at our portal',
                                    style: GoogleFonts.lato(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Hero(
                        tag: 'alerts',
                        child: Card(
                          color: Colors.yellow[50],
                          clipBehavior: Clip.antiAlias,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PortalPage(
                                    link: 'http://192.168.1.8:8085',
                                    routes: 'alerts',
                                  ),
                                ),
                              );
                            },
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/images/notification.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                  ),
                                  Text(
                                    'Alerts',
                                    style: GoogleFonts.lato(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'View all alerts',
                                    style: GoogleFonts.lato(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Hero(
                        tag: 'camera',
                        child: Card(
                          color: Colors.blueGrey[50],
                          clipBehavior: Clip.antiAlias,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PortalPage(
                                            link: 'https://www.google.com/',
                                            routes: 'camera',
                                          )));
                            },
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/images/iot.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                  ),
                                  Text(
                                    'IOT',
                                    style: GoogleFonts.lato(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'All IOT devices',
                                    style: GoogleFonts.lato(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Hero(
                        tag: 'programs',
                        child: Card(
                          color: Colors.indigo[50],
                          elevation: 5,
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: InkWell(
                            splashColor: Colors.lightBlue.withAlpha(30),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PortalPage(
                                            link: 'https://www.mozilla.com',
                                            routes: 'programs',
                                          )));
                            },
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/images/code.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                  ),
                                  Text(
                                    'Programs',
                                    style: GoogleFonts.lato(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'View running programs ',
                                    style: GoogleFonts.lato(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Hero(
                        tag: 'inputs',
                        child: Card(
                          color: Colors.amber[50],
                          clipBehavior: Clip.antiAlias,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Inputs_page()));
                            },
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/images/smartphone.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                  ),
                                  Text(
                                    'Sync',
                                    style: GoogleFonts.lato(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'Enter values manually',
                                    style: GoogleFonts.lato(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 15.0,
                    left: 50.0,
                    right: 50.0,
                    child: Container(
                      // height: 40,
                      // width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Card(
                            color: Colors.white.withOpacity(1.0),
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Row(
                                children: [
                                  TextButton.icon(
                                    icon: Icon(Icons.person_outlined),
                                    label: Text("User"),
                                    style: TextButton.styleFrom(
                                        primary: Colors.blueGrey),
                                    onPressed: () {},
                                  ),
                                  VerticalDivider(
                                    thickness: 50,
                                    width: 1,
                                    color: Colors.black12,
                                  ),
                                  TextButton.icon(
                                    icon: Icon(Icons.logout),
                                    label: Text("Logout"),
                                    style: TextButton.styleFrom(
                                        primary: Colors.blueGrey),
                                    onPressed: () {},
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
