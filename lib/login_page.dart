import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

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

  // Sign-in form key for login page
  final _globalKey = GlobalKey<FormState>();

  // user input values from email and password field
  // this field should be stored as a map value
  // and has to be passed through API
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  // the user email and password are stored here
  // this map is sent through API
  Map<String, dynamic> params = {"username": null, "password": null};

  Future<dynamic> login() async {
    String base_url = "http://192.168.1.8:5020/users/login";
    var response =
        await http.post(Uri.parse(base_url), body: jsonEncode(params));

    // verification of the response from the server
    //
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data.keys);
      if (data.keys.length > 1) {
        print('success');
        try {
          var unique_id = _getId();
          params['id'] = unique_id;
          loginStatus = true;
        } catch (e) {
          return "Error occured in getting id: $e";
        }
      } else {
        print('response is 200 but either username or password is wrong');
      }
    } else if (response.statusCode == 500) {
      print('username and password is not correct');
    } else if (response.statusCode == 400) {
      print('no data found');
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
                  onPressed: () {
                    if (_globalKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Processing Data'),
                        ),
                      );
                      params['email'] = _email.text.toLowerCase();
                      params['password'] = _password.text;
                      login();
                    } else {
                      print('Error... unable to connect to API');
                    }
                    // GetData();
                    // print("get data : $pr");
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

Future<String?> _getId() async {
  var deviceInfo = DeviceInfoPlugin();
  var androidDeviceInfo = await deviceInfo.androidInfo;
  return androidDeviceInfo.androidId; // unique ID on Android
}

// interaction to API
// class GetData extends LoginPage {
//   static Future<dynamic> login() async {
//     var params = {
//       "program": "fire",
//       "userId": "Prasad19f87",
//       "startdate": "2021-05-11",
//       "enddate": "2021-08-15",
//       "cameraname": "",
//       "deptCameras": ""
//     };
//
//     String base_url = "http://192.168.1.8:5020/getAnalyticsAlertsBySummary";
//     var response = await http.post(Uri.parse(base_url), body: {
//       "program": "fire",
//       "userId": "Prasad19f87",
//       "startdate": "2021-05-11",
//       "enddate": "2021-08-15",
//       "cameraname": "",
//       "deptCameras": ""
//     });
//     if (response.statusCode != null) {
//       print(" inside conditon ${response} ${response.body}");
//     } else {
//       print("else conditon ${response} ${response.body}");
//     }
//
//     // if (response.statusCode == HttpStatus.ok){
//     print("Success");
//     // }
//     print('getting response: ${response.body}');
//     return response.body;
//   }
// }
