import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class getImage extends StatefulWidget {
  const getImage({Key? key}) : super(key: key);

  @override
  _getImageState createState() => _getImageState();
}

class _getImageState extends State<getImage> {
  XFile? image;


  Future _saveImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
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
        }
      }
      final mainStorage = Directory(mainDir);
      final myImagePath = '${mainStorage.path}/MyImages';
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

  Future _storeImage() async{
    // final image = await ImagePicker().pickImage(source: ImageSource.camera);
    // if (image == null) return;
    // final String path = await getApplicationDocumentsDirectory().toString();
    // final var filename = basename
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text("Run _saveImage function"),
                onPressed: () {
                  _saveImage();
                },
              ),
              ElevatedButton(onPressed: () {
                // _loadImage();
              },
                  child: Text('Run Newfunction'),
              ),
            ],
          )),
    );
  }
}
