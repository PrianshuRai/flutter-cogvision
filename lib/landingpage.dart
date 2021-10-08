import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './MainPage.dart';
import './inputs_page.dart';
import './web_view_page.dart';

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
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 8,
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                children: <Widget>[
                  Card(
                    color: Colors.blue[50],
                    elevation: 5,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
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
                                  textStyle:
                                      Theme.of(context).textTheme.headline5,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Control Bluetooth',
                              style: GoogleFonts.lato(
                                  textStyle:
                                      Theme.of(context).textTheme.subtitle2,
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
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Links()));
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
                                  textStyle:
                                      Theme.of(context).textTheme.headline5,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Glance at our portal',
                              style: GoogleFonts.lato(
                                  textStyle:
                                      Theme.of(context).textTheme.subtitle2,
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
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PortalPage(
                                    link: 'https://www.facebook.com/')));
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
                                  textStyle:
                                      Theme.of(context).textTheme.headline5,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'View all alerts',
                              style: GoogleFonts.lato(
                                  textStyle:
                                      Theme.of(context).textTheme.subtitle2,
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
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PortalPage(
                                    link: 'https://www.google.com/')));
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
                                  textStyle:
                                      Theme.of(context).textTheme.headline5,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'All IOT devices',
                              style: GoogleFonts.lato(
                                  textStyle:
                                      Theme.of(context).textTheme.subtitle2,
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
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: InkWell(
                      splashColor: Colors.lightBlue.withAlpha(30),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PortalPage(
                                    link: 'https://www.mozilla.com')));
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
                                  textStyle:
                                      Theme.of(context).textTheme.headline5,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'View running programs ',
                              style: GoogleFonts.lato(
                                  textStyle:
                                      Theme.of(context).textTheme.subtitle2,
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
                      borderRadius: BorderRadius.circular(15),
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
                                  textStyle:
                                      Theme.of(context).textTheme.headline5,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Enter values manually',
                              style: GoogleFonts.lato(
                                  textStyle:
                                      Theme.of(context).textTheme.subtitle2,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Links extends StatefulWidget {
  const Links({Key? key}) : super(key: key);

  @override
  _LinksState createState() => _LinksState();
}

class _LinksState extends State<Links> {
  String link = 'https://www.google.com';
  TextEditingController _link = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _link,
                style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.headline6,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  labelText: "Enter link",
                  labelStyle: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.bodyText2,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                  filled: true,
                  fillColor: Colors.white,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    link = _link.text;
                    print(link);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PortalPage(link: link)));
                  },
                  child: Icon(Icons.arrow_right))
            ],
          ),
        ),
      ),
    );
  }
}
