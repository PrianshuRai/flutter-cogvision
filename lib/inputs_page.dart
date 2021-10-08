import 'dart:convert';

// import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class Inputs_page extends StatefulWidget {
  const Inputs_page({Key? key}) : super(key: key);

  @override
  _Inputs_pageState createState() => _Inputs_pageState();
}

class _Inputs_pageState extends State<Inputs_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

  final _formKey = GlobalKey<FormState>();

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
          onSaved: (String? value) {
            formData['user'] = value;
          },
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
          onSaved: (String? value) {
            formData['ip'] = value;
          },
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
          onSaved: (String? value) {
            formData['port'] = value;
          },
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
          onSaved: (String? value) {
            formData['netmask'] = value;
          },
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
          onSaved: (String? value) {
            formData['interface'] = value;
          },
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
          onSaved: (String? value) {
            formData['syspassword'] = value;
          },
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
          onSaved: (String? value) {
            formData['management_server_ip'] = value;
          },
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
          onSaved: (String? value) {
            formData['gateway'] = value;
          },
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
          onSaved: (String? value) {
            formData['mac_id'] = value;
          },
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
          onSaved: (String? value) {
            formData['status'] = value;
          },
        ),

        // Add ElevatedButton here.
        ElevatedButton(
            child: Text('Submit'),
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

TextFormField inputs_field({String? txt1}) {
  return TextFormField(
    style: TextStyle(
      fontFamily: 'Lato',
      // fontStyle: 'Lato-Regular',
      color: Colors.blue[200],
      fontWeight: FontWeight.w400,
      fontSize: 22,
    ),
    decoration: InputDecoration(
        labelText: '$txt1',
        hintStyle: TextStyle(fontSize: 20),
        // filled: true,
        // fillColor: Colors.purple[50],
        border: InputBorder.none,
        labelStyle: TextStyle(
          fontSize: 18,
          color: Colors.grey,
          fontWeight: FontWeight.w800,
        )),
    // onSaved: (String? value) {
    //   formData['$txt1'] = value;
    // }, @TODO add onSaved function
  );
}

// '''
// TextFormField(
// decoration: const InputDecoration(
// // icon: Icon(Icons.person),
// labelText: 'User',
// ),
// validator: (String? value) {
// return (value != null && value.contains('@'))
// ? 'Do not use special characters'
//     : null;
// },
// onSaved: (String? value) {
// formData['user'] = value;
// },
// ),
// TextFormField(
// decoration: const InputDecoration(
// // icon: Icon(Icons.person),
// labelText: 'IP',
// ),
// onSaved: (String? value) {
// formData['IP'] = value;
// },
// ),
// TextFormField(
// decoration: const InputDecoration(
// // icon: Icon(Icons.person),
// labelText: 'Port',
// ),
// onSaved: (String? value) {
// formData['port'] = value;
// },
// validator: (String? value) {
// return (value != null && value.contains(' '))
// ? "Only ':' is allowed"
//     : null;
// },
// ),
// TextFormField(
// decoration: const InputDecoration(
// // icon: Icon(Icons.person),
// labelText: 'Netmask',
// ),
// onSaved: (String? value) {
// formData['netmask'] = value;
// },
// ),
// TextFormField(
// decoration: const InputDecoration(
// // icon: Icon(Icons.person),
// labelText: 'Interface',
// ),
// onSaved: (String? value) {
// formData['interface'] = value;
// },
// ),
// TextFormField(
// decoration: const InputDecoration(
// // icon: Icon(Icons.person),
// labelText: 'System Password',
// ),
// onSaved: (String? value) {
// formData['syspassword'] = value;
// },
//
// // @TODO Make this a password field
// ),
// TextFormField(
// decoration: const InputDecoration(
// // icon: Icon(Icons.person),
// labelText: 'Management Server IP',
// ),
// onSaved: (String? value) {
// formData['management_server_ip'] = value;
// },
// ),
// TextFormField(
// decoration: const InputDecoration(
// // icon: Icon(Icons.person),
// labelText: 'Gateway',
// ),
// onSaved: (String? value) {
// formData['gateway'] = value;
// },
// ),
// TextFormField(
// decoration: const InputDecoration(
// // icon: Icon(Icons.person),
// labelText: 'MAC ID',
// ),
// onSaved: (String? value) {
// formData['mac_id'] = value;
// },
// ),
// TextFormField(
// decoration: const InputDecoration(
// // icon: Icon(Icons.person),
// labelText: 'Status',
// ),
// onSaved: (String? value) {
// formData['status'] = value;
// },
// ),
// '''
