import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutDDC extends StatelessWidget {
  const AboutDDC({Key? key}) : super(key: key);
  // static const int copy = 0x00A9;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Colors.white,
      shadowColor: Colors.amber[500],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /* const SizedBox(
            height: 5,
          ), */
          Container(
            padding: const EdgeInsets.all(5.0),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.orange[800],
              border: Border.all(
                color: Colors.amber.shade100,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                'aboutApp'.tr,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.only(bottom: 10),
                height: 150,
                width: 150,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset('assets/images/rgob_logo.png'),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'aboutAppBody'.tr,
                      // overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        // fontFamily: 'font'.tr,
                      ),
                    ),
                    /* Text(
                      '\u{00A9} རྫོང་ཁ་གོང་འཕེལ་ལྷན་ཚོགས། \n ss',
                      // overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ), */
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
