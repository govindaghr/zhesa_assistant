import 'package:flutter/material.dart';
import 'package:zhebsa_assistant/pages/widgets/about_cst.dart';
import 'package:zhebsa_assistant/pages/widgets/about_developer.dart';
import 'widgets/about_ddc.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final TextStyle textStyle = Theme.of(context).textTheme.headline4;
    return SingleChildScrollView(
      child: Column(
        children: const <Widget>[
          AboutDDC(),
          AboutCST(),
          AboutDeveloper(),
        ],
      ),
    );
  }
}
