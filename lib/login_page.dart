import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool visible = true;

  final _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Image(
            image: AssetImage('assets/images/bannar.png'),
            fit: BoxFit.fill,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Form(
          key: _globalKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  // controller: ,
                  style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.headline6,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_rounded),
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
                  validator: (value) {
                    // add your custom validation here.
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    if (value.length < 9) {
                      return 'Something is wrong here';
                    }
                    if (!value.contains('@') || !value.contains('.com')) {
                      return "Email is incorrect";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  // controller: ,
                  obscureText: visible,
                  style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.headline6,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(visible
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded),
                      onPressed: () {
                        setState(() {
                          visible = !visible;
                        });
                      },
                    ),
                    prefixIcon: Icon(Icons.vpn_key_rounded),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password!';
                    }
                    if (value.length < 6) {
                      return "Password is too small to be secure!";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text('Submit'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue[100],
                      onPrimary: Colors.blueGrey[900]),
                  onPressed: () {
                    if (_globalKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Processing Data'),
                        ),
                      );
                      print('Validating');
                    } else {
                      print('Error...');
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
