import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';

class FileHandle extends StatefulWidget {
  const FileHandle({Key? key}) : super(key: key);

  @override
  State<FileHandle> createState() => _FileHandleState();
}

class _FileHandleState extends State<FileHandle> {
  TextEditingController _user = TextEditingController();
  TextEditingController _ip = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _user,
            decoration: InputDecoration(
              labelText: "username",
            ),
          ),
          TextField(
            controller: _ip,
            decoration: InputDecoration(
              labelText: "username",
            ),
          ),
          ElevatedButton(
            child: Text('Send'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
