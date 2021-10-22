import 'dart:convert';

import 'package:config_generator/landingpage.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

// unique id of the device
var globaluserid = null;
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

  static Route<Object?> _dialogBuilder(
      BuildContext context, Object? arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        insetPadding: EdgeInsets.all(15),
        // backgroundColor: Colors.transparent,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: spinkit,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Please Wait'),
            )
          ],
        ),
      ),
    );
  }

  static Route<Object?> _successBuilder(
      BuildContext context, Object? arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Success!',
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.headline4,
            color: Colors.black54,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          "You have been successfully logged-in",
          style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.bodyText1,
            color: Colors.black54,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
          softWrap: true,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Landing()));
            },
            child: Text('OK'),
          )
        ],
      ),
    );
  }

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

  void _GetId() async {
    var device_id = await _getId();
    params["device_id"] = device_id;
    print('device id $device_id updating params ${params['device_id']}');
  }

  // get device_id = await _getId();

  Future<dynamic> login() async {
    print('device_id');
    // start loding animation on function call
    Navigator.of(context).restorablePush(_dialogBuilder);

    String base_url = "http://192.168.1.8:5020/users/login";
    var response =
        await http.post(Uri.parse(base_url), body: jsonEncode(params));
    print('params: $params');
    print('response received: ${response.body}');

    Navigator.of(context, rootNavigator: true).pop(_dialogBuilder);

    // verification of the response from the server
    //
    if (response.statusCode == 200) {
      // calling API and saving response
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data.keys);

      // checking if data is more than just error
      if (data.keys.length > 1 || data['password'] == _password) {
        globaluserid = data['userId']; // check userid spelling from backend
        print(
            "global device id: ${params['device_id']} and global username: $globaluserid");
        loginStatus = true;
        print("login status: $loginStatus");
        Navigator.of(context).restorablePush(_successBuilder);
      } else if (data.keys.length <= 1) {
        try {
          return "status from other side: ${error_flag[data['error']]}";
        } catch (error) {
          return "some error occured: $error";
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
        body: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              alignment: AlignmentDirectional.bottomCenter,
              height: 400,
              child: Card(
                  child: AutofillGroup(
                child: Form(
                  key: _globalKey,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          style: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.headline6,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email_rounded),
                            labelText: "E-mail",
                            labelStyle: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.bodyText2,
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
                          autofillHints: [AutofillHints.email],
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
                                textStyle:
                                    Theme.of(context).textTheme.bodyText2,
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
                          autofillHints: [AutofillHints.password],
                          onEditingComplete: () {
                            TextInput.finishAutofillContext();
                          },
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
                              // setState(() async {
                              // _isLoading = true;
                              // _isLoading
                              //     ? showLoaderDialog(context)
                              //     : showErrorDialog(context);
                              // });
                              params['email'] = _email.text.toLowerCase();
                              print('email saved ${params['email']}');
                              params['password'] = _password.text;
                              _GetId();
                              // params['device_id'] = device_id;
                              print('device_id ${params['device_id']}');
                              print('you tapped button');
                              login();
                            } else {
                              print('Error... unable to connect to API');
                            }
                            // GetData();
                            // print("get data : $pr");
                          },
                        ),
                        // ElevatedButton(
                        //   child: Text('function check'),
                        //   onPressed: () {
                        //     newFun();
                        //   },
                        // ),
                      ],
                    ),
                  ),
                ),
              )),
            ),
          ],
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
Map<int, dynamic> error_flag = {
  1: "User is already logged-in somewhere",
  2: "Invalid E-Mail or password",
  3: "No result found"
};

// loading indicator
// showLoaderDialog(BuildContext context) {
//   AlertDialog alert = AlertDialog(
//     content: new Row(
//       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         SizedBox(
//           width: 10,
//         ),
//         CircularProgressIndicator(),
//         Container(
//           margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
//           child: Text("Please wait..."),
//         ),
//       ],
//     ),
//   );
//   showDialog(
//     useRootNavigator: true,
//     barrierDismissible: true,
//     context: context,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }

// spinkit loading container
dynamic spinkit = SpinKitFadingCube(
  color: Colors.blue[100],
  size: 100.0,
);

// showErrorDialog(BuildContext context) {
//   AlertDialog alert = AlertDialog(
//     title: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           'Error!',
//           textAlign: TextAlign.center,
//           style: GoogleFonts.lato(
//             textStyle: Theme.of(context).textTheme.headline4,
//             color: Colors.black54,
//             fontSize: 24,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         Text(
//           "😵",
//         ),
//       ],
//     ),
//     content: Text(
//       error_flag[1],
//       style: GoogleFonts.lato(
//         textStyle: Theme.of(context).textTheme.bodyText1,
//         color: Colors.black54,
//         fontSize: 18,
//         fontWeight: FontWeight.w400,
//       ),
//       textAlign: TextAlign.center,
//       softWrap: true,
//     ),
//     actions: [
//       TextButton(
//         onPressed: () {
//           Navigator.pop(context);
//         },
//         child: Text('OK'),
//       )
//     ],
//   );
//   showDialog(
//     barrierDismissible: true,
//     context: context,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }
