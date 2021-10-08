import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// void main() {
//   runApp(PortalPage());
// }

class PortalPage extends StatelessWidget {
  final String link;

  const PortalPage({Key? key, required this.link}) : super(key: key);

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
        child: WebView(
          initialUrl: link,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
