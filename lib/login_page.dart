import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image(
          image: AssetImage('assets/images/bannar.png'),
          fit: BoxFit.fill,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              // controller: ,
              style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.headline6,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                labelText: "E-mail",
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
            TextField(
              // controller: ,
              style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.headline6,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                labelText: "Password",
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
          ],
        ),
      ),
    );
  }
}
