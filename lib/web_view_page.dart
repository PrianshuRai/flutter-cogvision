import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PortalPage extends StatefulWidget {
  final String link;

  const PortalPage({Key? key, required this.link}) : super(key: key);

  @override
  State<PortalPage> createState() => _PortalPageState();
}

class _PortalPageState extends State<PortalPage> {
  bool isLoading = true;

  static const spinkit = SpinKitSpinningLines(
    color: Colors.blueGrey,
    size: 200.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[50],
        title: Image(
          image: AssetImage('assets/images/bannar.png'),
          fit: BoxFit.fill,
        ),
        // shadowColor: Colors.indigo[900],
        elevation: 20,
      ),
      body: Container(
        child: Stack(
          children: [
            // make sure to give following code
            // to html file for proper scaling
            //
            // <meta name="viewport" content="width=device-width, initial-scale=1">
            WebView(
              initialUrl: widget.link,
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (finish) {
                setState(() {
                  isLoading = false;
                });
              },
            ),
            isLoading
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: spinkit,
                      ),
                      Text(
                        "Please wait...",
                        style: GoogleFonts.lato(
                            textStyle: Theme.of(context).textTheme.headline6,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w500,
                            fontSize: 24),
                      )
                    ],
                  )
                : Stack(),
          ],
        ),
      ),
      // isLoading ? Center( child: CircularProgressIndicator(),)
      //     : Stack(),
    );
  }
}
