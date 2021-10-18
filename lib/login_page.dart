import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

// unique id of the device
var device_id = _getId();
bool loginStatus = false;

// this class contains all visual elements of
// login page
// functions are on separate page.
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // value for password visibility on password input page
  bool visible = true;

  // loading indicator value
  bool _isLoading = false;

  // Sign-in form key for login page
  final _globalKey = GlobalKey<FormState>();

  // user input values from email and password field
  // this field should be stored as a map value
  // and has to be passed through API
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  // the user email and password are stored here
  // this map is sent through API
  Map<String, dynamic> params = {
    "email": null,
    "password": null,
    "device_id": null
  };

  Future<dynamic> login() async {
    String base_url = "http://192.168.1.8:5020/users/login";
    var response =
        await http.post(Uri.parse(base_url), body: jsonEncode(params));
    print('params: $params');
    print('response received: ${response.body}');

    // verification of the response from the server
    //
    if (response.statusCode == 200) {
      setState(() {
        _isLoading = true;
      });
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data.keys);
      if (data.keys.length > 1) {
        print('success');
        loginStatus = true;
        print("login status: $loginStatus");
        setState(() {
          _isLoading = false;
        });
        return "Successfully Logged-in";
      } else if (data.keys.length <= 1) {
        try {
          print("status from other side: ${error_flag[data['error']]}");
        } catch (error) {
          print("some error occured: $error");
        }
      }
    } else if (response.statusCode == 500) {
      print("username and password is not correct");
    } else if (response.statusCode == 400) {
      print("no data found");
    }
  }

  // instance of GetData class from network.dart page
  // here
  // GetData _api_call = GetData();

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
                  controller: _email,
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
                    if (!value.contains('@') ||
                        !value.contains('cogvision.ai')) {
                      return "Email is incorrect";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _password,
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
                  onPressed: () async {
                    if (_globalKey.currentState!.validate()) {
                      if (_isLoading) {
                        setState(() {
                          showLoaderDialog(context);
                        });
                      }
                      ;
                      params['email'] = _email.text.toLowerCase();
                      params['password'] = _password.text;
                      params['device_id'] = await _getId();
                      login();
                    } else {
                      print('Error... unable to connect to API');
                    }
                    // GetData();
                    // print("get data : $pr");
                  },
                ),
                ElevatedButton(
                    child: Text('function check'),
                    onPressed: () {
                      setState(() {
                        // loading function
                        showLoaderDialog(context);
                      });
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// getting device id here
Future<String?> _getId() async {
  DeviceInfoPlugin deviceInfo = await DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  // print('${androidInfo.androidId}');
  // params['device_id'] = androidInfo.androidId.toString();
  return androidInfo.androidId;
}

// error flags received from the API call
// during error, don't change without matching
// from the other end (API).
Map<String, dynamic> error_flag = {
  "1": "User is already logged-in somewhere",
  "2": "Invalid E-Mail or password",
  "3": "No result found"
};

// loading indicator
showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 10,
        ),
        CircularProgressIndicator(),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          child: Text("Please wait..."),
        ),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
