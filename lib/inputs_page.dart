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
      child: Hero(
        tag: 'inputs',
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.blue[50],
            title: Image.asset('assets/images/bannar.png', fit: BoxFit.fill),
            elevation: 8,
          ),

          // 'static_ip': null,
          // 'interface': null,
          // 'syspass': null,
          // 'netmask': null,
          // 'gateway': null,
          // 'network_file':

          body: Configs(),
        ),
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
    'static_ip': null,
    'interface': null,
    'syspass': null,
    'netmask': null,
    'gateway': null,
    'network_file': "/etc/netplan/"
  };

  TextEditingController _static_ip = TextEditingController();
  TextEditingController _interface = TextEditingController();
  TextEditingController _syspass = TextEditingController();
  TextEditingController _netmask = TextEditingController();
  TextEditingController _gateway = TextEditingController();
  TextEditingController _network_file = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      itemExtent: 70.0,
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        TextFormField(
          controller: _static_ip,
          style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.headline6,
              color: Colors.blueGrey,
              fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            labelText: "Static IP",
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
          controller: _interface,
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
          controller: _syspass,
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
          controller: _netmask,
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
          controller: _gateway,
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
          controller: _network_file,
          style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.headline6,
              color: Colors.blueGrey,
              fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            labelText: "Network File",
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
              formData['static_ip'] = _static_ip.text;
              formData['interface'] = _interface.text;
              formData['syspass'] = _syspass.text;
              formData['netmask'] = _netmask.text;
              formData['gateway'] = _gateway.text;
              formData['network_file'] = _network_file.text;
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
