import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

// import 'package:permission_handler/permission_handler.dart';
// import 'dart:async';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';

class Inputs_page extends StatefulWidget {
  const Inputs_page({Key? key}) : super(key: key);

  @override
  _Inputs_pageState createState() => _Inputs_pageState();
}

class _Inputs_pageState extends State<Inputs_page> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.blue[50],
          title: Image.asset('assets/images/bannar.png', fit: BoxFit.fill),
          elevation: 8,
        ),

        // user
        // ip
        // port
        // netmask
        // interface
        // Syspassword
        // Management Server IP
        // Gateway
        // Mac id
        // status
        body: Configs(),
      ),
    );
  }
}

class Configs extends StatefulWidget {
  const Configs({Key? key}) : super(key: key);

  @override
  _ConfigsState createState() => _ConfigsState();
}

class _ConfigsState extends State<Configs> {
  final Map<String, dynamic> formData = {
    'user': null,
    'ip': null,
    'port': null,
    'netmask': null,
    'interface': null,
    'syspassword': null,
    'management_server_ip': null,
    'gateway': null,
    'mac_id': null,
    'status': null
  };

  TextEditingController _user = TextEditingController();
  TextEditingController _ip = TextEditingController();
  TextEditingController _port = TextEditingController();
  TextEditingController _mask = TextEditingController();
  TextEditingController _inter = TextEditingController();
  TextEditingController _sys = TextEditingController();
  TextEditingController _serv = TextEditingController();
  TextEditingController _gate = TextEditingController();
  TextEditingController _mac = TextEditingController();
  TextEditingController _sts = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      itemExtent: 70.0,
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        TextFormField(
          controller: _user,
          style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.headline6,
              color: Colors.blueGrey,
              fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            labelText: "User",
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
          obscureText: false,
        ),
        TextFormField(
          controller: _ip,
          style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.headline6,
              color: Colors.blueGrey,
              fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            labelText: "IP",
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
        TextFormField(
          controller: _port,
          style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.headline6,
              color: Colors.blueGrey,
              fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            labelText: "Port",
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
        TextFormField(
          controller: _mask,
          style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.headline6,
              color: Colors.blueGrey,
              fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            labelText: "Netmask",
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
        TextFormField(
          controller: _inter,
          style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.headline6,
              color: Colors.blueGrey,
              fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            labelText: "Interface",
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
        TextFormField(
          controller: _sys,
          style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.headline6,
              color: Colors.blueGrey,
              fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            labelText: "System Password",
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
        TextFormField(
          controller: _serv,
          style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.headline6,
              color: Colors.blueGrey,
              fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            labelText: "Management Server IP",
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
        TextFormField(
          controller: _gate,
          style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.headline6,
              color: Colors.blueGrey,
              fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            labelText: "Gateway",
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
        TextFormField(
          controller: _mac,
          style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.headline6,
              color: Colors.blueGrey,
              fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            labelText: "Mac_id",
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
        TextFormField(
          controller: _sts,
          style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.headline6,
              color: Colors.blueGrey,
              fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            labelText: "Status",
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

        // Add ElevatedButton here.
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue[100],
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
              ),
            ),
            child: Text(
              'Submit',
              style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.headline6,
                  color: Colors.blueGrey[800],
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            ),
            onPressed: () async {
              formData['user'] = _user.text;
              formData['ip'] = _ip.text;
              formData['port'] = _port.text;
              formData['netmask'] = _mask.text;
              formData['interface'] = _inter.text;
              formData['syspassword'] = _sys.text;
              formData['management_server_ip'] = _serv.text;
              formData['gateway'] = _gate.text;
              formData['mac_id'] = _mac.text;
              formData['status'] = _sts.text;
              // trying to make json file out of formData
              // print('trying to convert json file');
              dynamic config = json.encode(formData);

              // gettig permission for storage
              // bool req = await Permission.storage.request().isGranted;
              // print(req);
              // print(config);
              Share.share(config);
            }),
      ],
    );
  }
}

// TextField myTextField ({required String hint1, String? placeholder, TextEditingController? ctrl, required BuildContext contxt}) {
//   return TextField(
//     controller: ctrl,
//     style: GoogleFonts.lato(
//         textStyle: Theme.of(contxt).textTheme.headline6,
//         color: Colors.blueGrey,
//         fontWeight: FontWeight.w500),
//     decoration: InputDecoration(
//       labelText: hint1,
//       labelStyle: GoogleFonts.lato(
//           textStyle: Theme.of(contxt).textTheme.bodyText2,
//           fontWeight: FontWeight.w600,
//           fontSize: 20),
//       filled: true,
//       fillColor: Colors.white,
//       border: const OutlineInputBorder(
//         borderRadius: BorderRadius.all(
//           Radius.circular(15.0),
//         ),
//       ),
//     ),
//   );
// }
