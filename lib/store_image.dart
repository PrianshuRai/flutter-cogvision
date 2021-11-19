import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class getImage extends StatefulWidget {
  const getImage({Key? key}) : super(key: key);

  @override
  _getImageState createState() => _getImageState();
}

class _getImageState extends State<getImage> {
  XFile? image;

  Future _saveImage() async {
    final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
    final directory = await getExternalStorageDirectory();
    print("directory name: $directory");
    String mainDir = '';
    if (directory != null) {
      var dirName = directory.path.split('/');
      for (String item in dirName) {
        if (item == 'Android')
          break;
        else {
          mainDir = mainDir + item + '/';
          print(mainDir);
        }
      }
      final mainStorage = Directory(mainDir);
      final myImagePath = '${mainStorage.path}MyImages';
      print("Image path is as follow: $myImagePath");
      final myImgDir = await new Directory(myImagePath).create();
      print("directory made, $myImgDir");
    }

    // var imge = new File("$myImagePath/image_$DateTime.now().jpg")
    //   ..writeAsBytesSync(_image.encodeJpg(imge, quality: 95));

    //   dynamic splitFun(){
    //     String mainDir = '';
    //     final li = dir.split('/');
    //     for(String item in li){
    //       if(item == 'Android') break;
    //       else {mainDir = mainDir + item + "/";}
    //     }
    //     return mainDir;
    // }
  }

  Future _storeImage() async {
    // final image = await ImagePicker().pickImage(source: ImageSource.camera);
    // if (image == null) return;
    // final String path = await getApplicationDocumentsDirectory().toString();
    // final var filename = basename
  }



  _saveLocal() async {
    XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front
    );
    if (image == null) return;
    File tempFile = File(image.path);
    try{
      final directory = await getExternalStorageDirectory();
      print("directory name: $directory");
      String mainDir = '';
      if (directory != null) {
        var dirName = directory.path.split('/');
        for (String item in dirName) {
          if (item == 'Android')
            break;
          else {
            mainDir = mainDir + item + '/';
            print(mainDir);
          }
        }
        final mainStorage = Directory(mainDir);
        final myImagePath = '${mainStorage.path}MyImages';
        print("Image path is as follow: $myImagePath");
        final myImgDir = await new Directory(myImagePath).create();
        print("directory made, $myImgDir");
      }
    } on Exception catch(e){
      print("exception: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Run _saveImage function"),
              onPressed: () {
                _saveImage();
              },
            ),
            ElevatedButton(
              onPressed: () async {
                // _loadImage();
                await Permission.manageExternalStorage.request();
                var status = await Permission.manageExternalStorage.status;
                if (status.isDenied) {
                  // We didn't ask for permission yet or the permission has been denied   before but not permanently.
                  return;
                }
                if (status.isGranted) {
                  _saveImage();
                }
              },
              child: Text('Run Newfunction'),
            ),
            ElevatedButton(
              onPressed: () {
                // @TODO _saveLocal function
              },
              child: Text("_saveLocal"),
            )
          ],
        ),
      )),
    );
  }
}
