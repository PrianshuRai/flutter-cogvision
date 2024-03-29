import 'dart:convert';
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';

import './MainPage.dart';
import './inputs_page.dart';
import './web_view_page.dart';
import 'login_page.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  int _bellCounter = 0;

  // this is a test function
  // but before removing it please check
  // function call properly
  static Route<Object?> _userdialogBuilder(
      BuildContext context, Object? arguments) {
    return DialogRoute<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        insetPadding: EdgeInsets.all(15),
        // backgroundColor: Colors.transparent,
        content: Stack(
          children: <Widget>[
            Text(
              'Hi! ${userDetails["first_name"]}',
              style: GoogleFonts.lato(
                textStyle: Theme.of(context).textTheme.headline4,
                color: Colors.black54,
                // fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            ListView.builder(
                itemCount: userDetails.length,
                itemBuilder: (BuildContext context, int index) {
                  String key = userDetails.keys.elementAt(index);
                  return Card(
                    child: ListTile(
                      title: Text('$key'),
                      subtitle: Text(userDetails[key]),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  static Route<Object?> _logoutBuilder(
      BuildContext context, Object? arguments) {
    return DialogRoute<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        insetPadding: EdgeInsets.all(15),
        title: Text(
          'WARNING!',
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.headline4,
            color: Colors.black54,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          "Are you sure you want to log out?",
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.headline4,
            color: Colors.black54,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              print("running function");
              CircularProgressIndicator();
              try {
                var base_url = Uri.parse(
                    "http://184.105.174.77:5021/logout_mobile"); //"http://192.168.1.10:5020/users/logout_mobile"   //http://184.105.174.77:5021/logout_mobile
                print("Map made : ${globalDeviceId} and user $globaluserid}");
                var response = await http.post(base_url,
                    body: jsonEncode(
                        {"userId": globaluserid, "device_id": globalDeviceId}));
                globaluserid = null;
                print("response body : ${response.body}");

                if (response.statusCode == 200) {
                  Map<String, dynamic> data = jsonDecode(response.body);
                  print("data: $data");
                  if (data["status"] == "successfull") {
                    print('changing route');
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => LoginPage()));
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => new LoginPage()),
                        (Route<dynamic> route) => false);
                  } else if (data["status"] == "failed") {
                    print("error");
                    print(data["error"]);
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "Can not logout, It seems something is not right"),
                        duration: Duration(seconds: 2),
                        action: SnackBarAction(label: "OK", onPressed: () {}),
                      ),
                    );
                  }
                } else {
                  print("else function running");
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Unable to connect... Check network]}"),
                      duration: Duration(seconds: 1),
                      action: SnackBarAction(label: "OK", onPressed: () {}),
                    ),
                  );
                }
              } catch (e) {
                print("exception function running $e");
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Unable to connect... Check network"),
                    duration: Duration(seconds: 3),
                    action: SnackBarAction(label: "OK", onPressed: () {}),
                  ),
                );
              }
            },
            child: Text(
              'Log out',
              style: TextStyle(fontSize: 18),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel', style: TextStyle(fontSize: 18)),
          )
        ],
      ),
    );
  }

  static Route<Object?> _exitBuilder(BuildContext context, Object? arguments) {
    return DialogRoute<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        insetPadding: EdgeInsets.all(15),
        title: Text(
          'WARNING ⚠️',
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.headline4,
            color: Colors.black54,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          "Do you really want to exit?",
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.headline4,
            color: Colors.black54,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: Text(
                "Yes, I'll quit",
                style: TextStyle(fontSize: 18),
              )),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "No, I'll stay",
                style: TextStyle(fontSize: 18),
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      AnimatedTextKit(
                        repeatForever: true,
                        stopPauseOnTap: false,
                        animatedTexts: [
                          RotateAnimatedText(
                            'WELCOME',
                            textStyle: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.headline2,
                                fontWeight: FontWeight.w900),
                          ),
                          RotateAnimatedText(
                            'TO',
                            textStyle: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.headline2,
                                fontWeight: FontWeight.w900),
                          ),
                          RotateAnimatedText(
                            'COGVISION',
                            textStyle: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.headline2,
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
                    'assets/images/undraw_add_information.png',
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      children: <Widget>[
                        Card(
                          color: Colors.blue[50],
                          elevation: 5,
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => MainPage()));
                              Navigator.of(context).push(PageTransition(
                                  type: PageTransitionType.rightToLeftWithFade,
                                  alignment: Alignment.bottomCenter,
                                  child: MainPage()));
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
                        Card(
                          color: Colors.red[50],
                          clipBehavior: Clip.antiAlias,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            onTap: () {
                              Navigator.of(context).push(
                                PageTransition(
                                  type: PageTransitionType.rightToLeftWithFade,
                                  alignment: Alignment.bottomCenter,
                                  child: PortalPage(
                                      // put the URL here
                                      link:
                                          // "http://192.168.1.10:8085/mobile1iot?userId=$globaluserid"),
                                          "http://184.105.174.77:8086/login"),
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
                                      'assets/images/search.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                  ),
                                  Text(
                                    'Web View', // change name of the tile
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
                        Card(
                          color: Colors.yellow[50],
                          clipBehavior: Clip.antiAlias,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const PortalPage(
                              //         link: 'http://192.168.1.8:8085/mobile1iot'),
                              //   ),
                              // );
                              Navigator.of(context).push(PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                alignment: Alignment.bottomCenter,
                                child: PortalPage(
                                    // put the URL here
                                    link:
                                        "http://184.105.174.77:8086/mobile2report"),
                              ));
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
                        Card(
                          color: Colors.blueGrey[50],
                          clipBehavior: Clip.antiAlias,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => PortalPage(
                              //             link: 'https://www.google.com/')));
                              Navigator.of(context).push(PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                alignment: Alignment.bottomCenter,
                                child: PortalPage(
                                    // put the URL here
                                    link:
                                        "http://184.105.174.77:8086/mobile1iot?userId=$globaluserid"),
                              ));
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
                        Card(
                          color: Colors.indigo[50],
                          elevation: 5,
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: InkWell(
                            splashColor: Colors.lightBlue.withAlpha(30),
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => PortalPage(
                              //             link: 'https://www.mozilla.com')));
                              Navigator.of(context).push(PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                alignment: Alignment.bottomCenter,
                                child: PortalPage(
                                    // put the URL here
                                    link: "http://www.cogvision.ai/about-us/"),
                              ));
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
                        Card(
                          color: Colors.amber[50],
                          clipBehavior: Clip.antiAlias,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => Inputs_page()));
                              Navigator.of(context).push(PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                alignment: Alignment.bottomCenter,
                                child: Inputs_page(),
                              ));
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
                        // Card(
                        //   color: Colors.red[50],
                        //   clipBehavior: Clip.antiAlias,
                        //   elevation: 5,
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(18),
                        //   ),
                        //   child: InkWell(
                        //     splashColor: Colors.red.withAlpha(30),
                        //     onTap: () {
                        //       // Navigator.push(
                        //       //     context,
                        //       //     MaterialPageRoute(
                        //       //         builder: (context) => PortalPage(
                        //       //             link: 'https://www.google.com/')));
                        //       Navigator.of(context).push(PageTransition(
                        //         type: PageTransitionType.rightToLeftWithFade,
                        //         alignment: Alignment.bottomCenter,
                        //         child: FaceReg(),
                        //       ));
                        //     },
                        //     child: Center(
                        //       child: Column(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: <Widget>[
                        //           Padding(
                        //             padding: const EdgeInsets.all(8.0),
                        //             child: Image.asset(
                        //               'assets/images/faceScanner.png',
                        //               height: 60,
                        //               width: 60,
                        //             ),
                        //           ),
                        //           Text(
                        //             'FRS',
                        //             style: GoogleFonts.lato(
                        //                 textStyle: Theme.of(context)
                        //                     .textTheme
                        //                     .headline5,
                        //                 fontWeight: FontWeight.w500),
                        //           ),
                        //           SizedBox(
                        //             height: 15,
                        //           ),
                        //           Text(
                        //             'Face Registration system',
                        //             style: GoogleFonts.lato(
                        //                 textStyle: Theme.of(context)
                        //                     .textTheme
                        //                     .subtitle2,
                        //                 fontSize: 15,
                        //                 fontWeight: FontWeight.w400),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    Positioned(
                      bottom: 15.0,
                      left: 30.0,
                      right: 30.0,
                      child: Container(
                        height: 65,
                        width: 40,
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(18),
                        //   boxShadow: <BoxShadow>[
                        //     BoxShadow(
                        //         color: Color(0xFF5C5EDD).withOpacity(0.6),
                        //         offset: const Offset(1.1, 4.0),
                        //         blurRadius: 8.0),
                        //   ],
                        //   gradient: LinearGradient(
                        //     colors: <Color>[
                        //       Color(0xFFF3E5F5),
                        //       Color(0xFFFFEBEE),
                        //     ],
                        //     begin: Alignment.topLeft,
                        //     end: Alignment.bottomRight,
                        //   ),
                        // ),
                        child: ClipRRect(
                          // convert this to card if not in use
                          // color: Color,
                          // elevation: 12,
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(18)
                          // ),
                          borderRadius: BorderRadius.circular(18),

                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Colors.white.withOpacity(0.6),
                                    Colors.white.withOpacity(0.8)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton.icon(
                                      icon: Icon(Icons.logout),
                                      label: Text("Logout"),
                                      style: TextButton.styleFrom(
                                          primary: Colors.blueGrey),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .restorablePush(_logoutBuilder);
                                      },
                                    ),
                                    TextButton.icon(
                                      icon: Icon(Icons.person_outlined),
                                      label: Text("User"),
                                      style: TextButton.styleFrom(
                                          primary: Colors.blueGrey),
                                      onPressed: () {
                                        // setState(() {
                                        //   _bellCounter++;
                                        // });
                                        // Navigator.of(context)
                                        //     .restorablePush(_userdialogBuilder);
                                        showUserDialog(context);
                                      },
                                    ),
                                    TextButton.icon(
                                      icon: Icon(Icons.door_back_door_outlined),
                                      label: Text('Exit'),
                                      style: TextButton.styleFrom(
                                          primary: Colors.blueGrey),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .restorablePush(_exitBuilder);
                                      },
                                    ),
                                    AlertCounter(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// Test dialog do not remove it
// if necessary to remove please make changes in
// login_page.dart and new_test.dart files
showUserDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
    actionsAlignment: MainAxisAlignment.center,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onLongPress: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("This app was made by Prianshu Rai for CogvisionAI"),
              ),
            );
          },
          child: CircleAvatar(
            radius: 14,
            backgroundColor: Colors.white70,
            backgroundImage: AssetImage('assets/images/icon.png'),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          'Hi! ${userDetails["First Name"]}',
          style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.headline4,
            color: Colors.black54,
            // fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 400.0,
          width: 400.0,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: userDetails.length,
              itemBuilder: (BuildContext context, int index) {
                String key = userDetails.keys.elementAt(index);
                return Card(
                  color: Colors.white,
                  elevation: 2,
                  child: ListTile(
                    title: Text(
                      '$key: ',
                      style: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.headline6,
                        fontSize: 18,
                        color: Colors.black54,
                        // fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      userDetails[key],
                      style: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.caption,
                        fontSize: 18,
                        color: Colors.black54,
                        // fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    ),
    actions: [
      // call support functionality

      // IconButton(
      //   onPressed: () {
      //     Navigator.pop(context);
      //   },
      //   icon: Icon(Icons.support_agent_rounded, color: Colors.black38,),
      // ),
      IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.close_rounded,
          color: Colors.black38,
        ),
      )
    ],
  );
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

// bottom menu alert button
class AlertCounter extends StatefulWidget {
  const AlertCounter({Key? key}) : super(key: key);

  @override
  _AlertCounterState createState() => _AlertCounterState();
}

class _AlertCounterState extends State<AlertCounter> {
  int _bellCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        TextButton.icon(
            onPressed: () {
              setState(() {
                _bellCounter = 0;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "All alerts cleared... but can be seen on our portal",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            icon: Icon(Icons.notifications_outlined),
            label: Text('Alerts'),
            style: TextButton.styleFrom(primary: Colors.blueGrey)),
        _bellCounter != 0
            ? Positioned(
                top: 7,
                left: 21,
                child: new Container(
                  padding: EdgeInsets.all(3),
                  decoration: new BoxDecoration(
                    color: Color(0xFFFF5722),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 15,
                    minHeight: 12,
                  ),
                  child: Text(
                    '$_bellCounter',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : new Padding(padding: EdgeInsets.all(1))
        //Container(
        //   padding: EdgeInsets.all(3),
        //   decoration: new BoxDecoration(
        //     color: Colors.transparent,
        //     borderRadius:
        //     BorderRadius.circular(18),
        //   ),
        //   constraints: BoxConstraints(
        //     minWidth: 15,
        //     minHeight: 12,
        //   ),
        //   child: Text(
        //     '0',
        //     style: TextStyle(
        //       color: Colors.transparent,
        //       fontSize: 14,
        //     ),
        //     textAlign: TextAlign.center,
        //   ),
        // )
      ],
    );
  }
}
