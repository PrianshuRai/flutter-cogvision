import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class FileHandle extends StatefulWidget {
  const FileHandle({Key? key}) : super(key: key);

  @override
  State<FileHandle> createState() => _FileHandleState();
}

class _FileHandleState extends State<FileHandle> {
  TextEditingController _user = TextEditingController();
  TextEditingController _ip = TextEditingController();

  Future<bool> savefile(String url, String filename) async {
    Directory directory;
    try {
      if (await _requestPermission(Permission.storage)) {
        // directory = await getExternalStorageDirectory();
      }
    } catch (e) {}

    return true;
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
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
              onPressed: () {
                //
              },
            ),
          ],
        ),
      ),
    );
  }
}
