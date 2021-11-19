import 'dart:io';
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FaceReg extends StatefulWidget {
  const FaceReg({Key? key}) : super(key: key);

  @override
  _FaceRegState createState() => _FaceRegState();
}

class _FaceRegState extends State<FaceReg> {
  XFile? image;

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      print("image is: $image \nand type is: ${image.runtimeType}");
      if (image == null) return;

      final imagePermanent = await saveImage(image.path);
      setState(() {
        this.image = imagePermanent;
      });
    } on PlatformException catch (e) {
      print("failed to pick an image error: $e");
    }
  }

  Future<dynamic> saveImage(String imagePath) async {
    print('receiving imagePath: $imagePath');
    await Permission.manageExternalStorage.request();
    var status = await Permission.manageExternalStorage.status;
    if (status.isDenied) {
      // We didn't ask for permission yet or the permission has been denied
      // before but not permanently.
      print("permission denied");
      return;
    }
    if (status.isGranted) {
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
        final myImagePath = '${mainStorage.path}CogvisionAI';
        print("Image path is as follow: $myImagePath");
        final myImgDir = await new Directory(myImagePath).create();
        print("directory made, $myImgDir");
        try {
          final name = basename(imagePath);
          final image = File('${myImgDir.path}/$name');
          print("file saved to the new location: $image");
          print(XFile(imagePath));

          return XFile(imagePath);
        } on Exception catch (e) {
          print('Unable to create the required file due to error: \n>>$e');
          print('trying different method---');
        }
      }
    }
    // try {
    //   print("trying to save the file...");
    //   final directory = await getApplicationDocumentsDirectory();
    //   print("directory name: $directory");
    //   final name = basename(imagePath);
    //   final image = File('${directory.path}/$name');
    //   print("file saved to the new location: $image");
    //   print(XFile(imagePath));
    //
    //   return XFile(imagePath);
    // } on Exception catch (e) {
    //   print("some error has occured... Exception is $e");
    //   return XFile(imagePath);
    // }
//.copy(image.path);
  }

  Future<ImageSource?> showImageSource(BuildContext context) async {
    if (Platform.isIOS) {
      //@ TODO add tags in pinfo file in ios folder
      return showCupertinoModalPopup<ImageSource>(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop(ImageSource.camera);
              },
              child: Text('Camera'),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop(ImageSource.gallery);
              },
              child: Text('Gallery'),
            ),
          ],
        ),
      );
    } else {
      return showModalBottomSheet(
        barrierColor: Colors.black26.withOpacity(.3),
          backgroundColor: Colors.transparent,
          elevation: 0,
          context: context,
          builder: (context) {
            //Column(
            //   mainAxisSize: MainAxisSize.min,
            //   children: <Widget>[
            //     ListTile(
            //       leading: Icon(Icons.camera_alt_rounded),
            //       title: Text("Camera"),
            //       onTap: () {
            //         Navigator.of(context).pop(_pickImage(ImageSource.camera));
            //       },
            //     )
            //   ],
            // ),
            return new Container(
              height: 250.0,
              color: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFFFFEBEE).withOpacity(0.6),//BBDEFB
                          Color(0xFFE3F2FD).withOpacity(0.6) // FFCDD2
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            onPressed: () {
                              // _pickImage(ImageSource.camera);
                              Navigator.pop(context);
                              _pickImage(ImageSource.camera);
                            },
                            icon: Icon(
                              Icons.camera_alt_rounded,
                              size: 60,
                              color: Colors.white70,
                              semanticLabel: "Take image from Camera",
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 60.0, bottom: 60.0),
                          child: VerticalDivider(
                            thickness: 1.5,
                            width: 1,
                            color: Colors.black12,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _pickImage(ImageSource.gallery);
                            },
                            icon: Icon(
                              Icons.crop_original,
                              size: 60,
                              color: Colors.white70,
                              semanticLabel: "Choose image from Gallery",
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Image.asset(
          'assets/images/bannar.png',
          fit: BoxFit.fill,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        // leading: Icon(icon: ),
      ),
      body: Container(
        // color: Colors.red.withAlpha(50),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/backgroundTexture_abstract.jpg"), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  height: 170,
                  padding: EdgeInsets.all(2),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(22)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Color(0xFFFFB295).withOpacity(0.6),
                          offset: const Offset(1.1, 4.0),
                          blurRadius: 8.0),
                    ],
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFFFA7D82),
                        Color(0xFFFFB295),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height:20),
                        Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.white.withOpacity(0.7),
                          size: 36,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        AnimatedTextKit(
                          repeatForever: true,
                          stopPauseOnTap: false,
                          animatedTexts: [
                            ColorizeAnimatedText(
                              'Choose Image',
                              colors: <Color>[
                                Color(0xFFFFCCBC),
                                Color(0xFFFFCC80),
                                Color(0xFFCE93D8),
                                Color(0xFFF48FB1),
                                Color(0xFFFFCCBC),
                              ],
                              textStyle: GoogleFonts.lato(
                                  textStyle:
                                      Theme.of(context).textTheme.headline2,
                                  fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: -15,
                  right: 50,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: LinearGradient(
                        colors: [Color(0xFFFFB295), Color(0xFFFA7D82)],
                      ),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shadowColor: Color(0xFFFA7D82),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                        //CircleBorder(),
                        padding: EdgeInsets.symmetric(
                            vertical: 20, horizontal: 40),
                        primary: Colors.transparent,
                        // <-- Button color
                        onPrimary: Color(0xFFFFE0B2), // <-- Splash color
                      ),
                      onPressed: () {
                        showImageSource(context);
                      },
                      child: Text(
                        'Select',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 80,
            ),
            Stack(
              // overflow: Overflow.visible,
              clipBehavior: Clip.none,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  height: 170,
                  padding: EdgeInsets.all(2),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(22)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Color(0xFF738AE6).withOpacity(0.6),
                          offset: const Offset(1.1, 4.0),
                          blurRadius: 8.0),
                    ],
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF5C5EDD),
                        Color(0xFF738AE6),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 20,),
                        Icon(
                          Icons.verified_rounded,
                          color: Colors.white.withOpacity(0.8),
                          size: 32,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        AnimatedTextKit(
                          repeatForever: true,
                          stopPauseOnTap: false,
                          animatedTexts: [
                            ColorizeAnimatedText(
                              'Verify Image',
                              colors: <Color>[
                                Color(0xFFD1C4E9),
                                Color(0xFFFFCC80),
                                Color(0xFFCE93D8),
                                Color(0xFFF48FB1),
                                Color(0xFFD1C4E9),
                              ],
                              textStyle: GoogleFonts.lato(
                                  textStyle:
                                      Theme.of(context).textTheme.headline2,
                                  fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: -15,
                  right: 50,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: LinearGradient(
                        colors: [Color(0xFF738AE6), Color(0xFF5C5EDD)],
                      ),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shadowColor: Color(0xFF5C5EDD),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                        //CircleBorder(),
                        padding: EdgeInsets.symmetric(
                            vertical: 20, horizontal: 40),
                        primary: Colors.transparent,
                        // <-- Button color
                        onPrimary: Color(0xFFBBDEFB), // <-- Splash color
                      ),
                      onPressed: () {
                        showImageSource(context);
                      },
                      child: Text(
                        'Select',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

