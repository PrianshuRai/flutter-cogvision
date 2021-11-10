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
      if (image == null) return;

      final imagePermanent = await saveImage(image.path);
      setState(() {
        this.image = imagePermanent;
      });
    } on PlatformException catch (e) {
      print("failed to pick an image error: $e");
    }
  }

  Future<XFile> saveImage(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return XFile(imagePath); //.copy(image.path);
  }

  Future<ImageSource?> showImageSource(BuildContext context) async {
    if (Platform.isIOS) {
      return showCupertinoModalPopup<ImageSource>(
        context: context,
        builder: (context) =>
            CupertinoActionSheet(
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
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      gradient: LinearGradient(
                        colors: <Color>[
                          Colors.white.withOpacity(0.6),
                          Colors.white.withOpacity(0.6)
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
                              Navigator.of(context)
                                  .pop(_pickImage(ImageSource.camera));
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
                            width: 1,
                            color: Colors.black12,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () {
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
      appBar: AppBar(
        title: Image.asset(
          'assets/images/bannar.png',
          fit: BoxFit.fill,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: Icon(icon: ),
      ),
      body: Container(
        color: Colors.red.withAlpha(50),
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //       image: AssetImage("assets/images/bluish.png"), fit: BoxFit.fill),
        // ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      height: 150,
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
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.camera_alt_rounded,
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
                                  'Choose Image',
                                  colors: <Color>[
                                    Color(0xFFFFCCBC),
                                    Color(0xFFFFCC80),
                                    Color(0xFFCE93D8),
                                    Color(0xFFF48FB1),
                                    Color(0xFFFFCCBC),
                                  ],
                                  textStyle: GoogleFonts.lato(
                                      textStyle: Theme
                                          .of(context)
                                          .textTheme
                                          .headline3,
                                      fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -35,
                      right: 30,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(30),
                          primary: Color(0xFFFA7D82), // <-- Button color
                          onPrimary: Color(0xFFFFE0B2), // <-- Splash color
                        ),
                        onPressed: () {
                          showImageSource(context);
                        },
                        child: Text('Select',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 80,
                ),
                Stack(
                  overflow: Overflow.visible,
                  // clipBehavior: Clip.none,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      height: 150,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // SizedBox(width: 20,),
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
                                    Theme
                                        .of(context)
                                        .textTheme
                                        .headline3,
                                    fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: -35,
                      right: 35,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(30),
                          primary: Color(0xFF5C5EDD), // <-- Button color
                          onPrimary: Color(0xFFE3F2FD), // <-- Splash color
                        ),
                        onPressed: () {
                          showImageSource(context);
                        },
                        child: Text('Select',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    )

                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

// Future openDialog() => showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text,
//       )
//     );
}
