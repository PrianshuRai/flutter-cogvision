import 'dart:ui';

import 'package:flutter/material.dart';

class userinfo extends StatelessWidget {
  final String title;

  userinfo({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        this.title,
        style: Theme.of(context).textTheme.headline5,
      ),
      content: Center(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
          child: Container(
            color: Colors.red,
            width: 500,
            height: 600,
            alignment: Alignment.center,
            decoration: new BoxDecoration(
              color: Colors.grey.shade200.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }
}
