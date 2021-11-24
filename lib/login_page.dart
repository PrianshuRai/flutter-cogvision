import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'landingpage.dart';

// unique id of the device
var globaluserid = null;
var globalDeviceId = null;
bool loginStatus = false;
bool face_reg_enable = true;

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

  // this text field shows the error msg on login screen
  String _errorMsg = '';

  // loading indicator value

  // Sign-in form key for login page
  final _globalKey = GlobalKey<FormState>();

  static Route<Object?> _dialogBuilder(
      BuildContext context, Object? arguments) {
    return DialogRoute<void>(
      context: context,
      barrierDismissible: false,
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
              padding: const EdgeInsets.only(top: 30.0),
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
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        insetPadding: EdgeInsets.all(15),
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
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => Landing()));
              // Navigator.of(context).pop();
              // Navigator.of(context).pushReplacement(MaterialPageRoute(
              //     builder: (BuildContext context) => Landing()));
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => new Landing()),
                  (Route<dynamic> route) => false);
            },
            child: Text('OK'),
          )
        ],
      ),
    );
  }

  String _errorMessage = '';

  static Route<Object?> _errorBuilder(BuildContext context, Object? arguments) {
    return DialogRoute<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        insetPadding: EdgeInsets.all(15),
        content: Text(
          'ERROR! ❌',
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.headline4,
            color: Colors.black54,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => Landing()));
              Navigator.of(context).pop();
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

  // void _GetId() async {
  //   var device_id = await _getId();
  //   params["device_id"] = device_id;
  //   print('device id $device_id updating params ${params['device_id']}');
  // }

  // get device_id = await _getId();

  Future<dynamic> login() async {
    // start loding animation on function call
    Navigator.of(context).restorablePush(_dialogBuilder);

    String base_url =
        // "http://192.168.1.10:5020/users/login1"; //"http://192.168.1.10:5020/users/login1";
    "http://184.105.174.77:5021/login1";
    var response =
        await http.post(Uri.parse(base_url), body: jsonEncode(params));
    print('params: $params');
    print('response received: ${response.body}');

    Navigator.of(context, rootNavigator: true).pop(_dialogBuilder);
    print("status for response: ${response.statusCode}");

    // verification of the response from the server
    //
    if (response.statusCode == 200) {
      // calling API and saving response
      Map<String, dynamic> data = jsonDecode(response.body);
      print("data = ${data.keys}");

      // checking if data is more than just error
      if (data.keys.length > 1 || data['password'] == _password) {
        globaluserid = data['userId']; // check userid spelling from backend
        print(
            "global device id: ${params['device_id']} and global username: $globaluserid");
        loginStatus = true;
        print("login status: $loginStatus");
        Navigator.of(context).restorablePush(_successBuilder);
      } else if (data.keys.length <= 1) {
        print('in else block');
        try {
          print('in try block');
          if (data.containsKey("error")) {
            Navigator.of(context).restorablePush(_errorBuilder);
            print('contains error');
            // setState(() {
            //   _errorMessage = error_flag[data['error']];
            //   // if (_errorMessage.isEmpty) {
            //   //   _errorMessage = error_flag[data["error"]];
            //   // } else {
            //   //   _errorMessage = "something is not correct";
            //   // }
            // });
            print('flag changed');
          } else {
            print("second else block");
            _errorMessage = 'error';
            Navigator.of(context).restorablePush(_errorBuilder);
          }
        } catch (error) {
          return "some error occurred: $error";
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
        extendBody: true,
        extendBodyBehindAppBar: true,
        // backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Image(
            image: AssetImage('assets/images/bannar.png'),
            fit: BoxFit.fill,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: Container(
            // height: MediaQuery.of(context).size.height * .98,
            decoration: BoxDecoration(
              // image: DecorationImage(
              //     image: ExactAssetImage(
              //         "assets/images/backgroundTexture_abstract.jpg"),
              //     fit: BoxFit.fill),
              gradient: LinearGradient(
                colors: <Color>[
                  Color(0xFFFFFFFF),
                  // Color(0xFF80D8FF),
                  Color(0xFFFAFAFA),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(height: 50,),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0.0,
                        left: 10.0,
                        right: 10.0,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(22)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Color(0xFF5C5EDD).withOpacity(0.6),
                                  offset: const Offset(1.1, 4.0),
                                  blurRadius: 8.0),
                            ],
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFF738AE6),
                                Color(0xFF5C5EDD),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          // height: 400,
                          child: AutofillGroup(
                            child: Form(
                              key: _globalKey,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    TextFormField(
                                      controller: _email,
                                      keyboardType:
                                          TextInputType.emailAddress,
                                      style: GoogleFonts.lato(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                          color: Colors.blueGrey,
                                          fontWeight: FontWeight.w500),
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.email_rounded,
                                          color: Color(0xFF738AE6),
                                        ),
                                        labelText: "E-mail",
                                        labelStyle: GoogleFonts.lato(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                            color: Color(0xFF738AE6)),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15.0),
                                          ),
                                        ),
                                        enabledBorder:
                                            const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15.0),
                                          ),
                                        ),
                                        focusedBorder: new OutlineInputBorder(
                                          borderRadius:
                                              new BorderRadius.circular(15.0),
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                        ),
                                        floatingLabelStyle: GoogleFonts.lato(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 28,
                                          color: Color(0xFF526EE0),
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
                                        if (!value.contains('@') || !value.contains('.')) {
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
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline6,
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
                                        prefixIcon: Icon(
                                          Icons.vpn_key_rounded,
                                          color: Color(0xFF738AE6),
                                        ),
                                        labelText: "Password",
                                        labelStyle: GoogleFonts.lato(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                            color: Color(0xFF738AE6)),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15.0),
                                          ),
                                        ),
                                        enabledBorder:
                                            const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15.0),
                                          ),
                                        ),
                                        focusedBorder: new OutlineInputBorder(
                                          borderRadius:
                                              new BorderRadius.circular(15.0),
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                        ),
                                        floatingLabelStyle: GoogleFonts.lato(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 28,
                                          color: Color(0xFF526EE0),
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
                                    Text(
                                      '$_errorMessage',
                                      style: GoogleFonts.lato(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    ElevatedButton(
                                      child: Text(
                                        'Submit',
                                        style: GoogleFonts.lato(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: Color(0xFF738AE6),
                                        onPrimary: Colors.blueGrey[900],
                                        fixedSize: Size(
                                            MediaQuery.of(context).size.width,
                                            50),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                      ),
                                      onPressed: () async {
                                        if (_globalKey.currentState!
                                            .validate()) {
                                          // setState(() async {
                                          // _isLoading = true;
                                          // _isLoading
                                          //     ? showLoaderDialog(context)
                                          //     : showErrorDialog(context);
                                          // });
                                          params['email'] =
                                              _email.text.toLowerCase();
                                          print(
                                              'email saved ${params['email']}');
                                          params['password'] = _password.text;
                                          //  _GetId();
                                          var device_id = await _getId();
                                          params["device_id"] = device_id;
                                          globalDeviceId = device_id;
                                          print(
                                              'device id---->>>>> $device_id updating params ${params['device_id']}');
                                          print('you tapped button');
                                          login();
                                        } else {
                                          print(
                                              'Error... unable to connect to API');
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
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
Map<int, dynamic> error_flag = {
  1: "User is already logged-in somewhere",
  2: "Invalid E-Mail or password",
  3: "No result found"
};

// loading indicator
// showExitDialog(BuildContext context) {
//   AlertDialog exit = AlertDialog(
//     title: Text(
//       'Warning! ⚠️',
//       textAlign: TextAlign.center,
//       style: GoogleFonts.lato(
//         textStyle: Theme.of(context).textTheme.headline4,
//         color: Colors.black54,
//         fontSize: 24,
//         fontWeight: FontWeight.w700,
//       ),
//     ),
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
//       return exit;
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

class customCard extends StatefulWidget {
  @override
  State<customCard> createState() => _customCardState();
}

class _customCardState extends State<customCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .99,
      color: Colors.transparent,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 1,
      ),
    );
  }
}
