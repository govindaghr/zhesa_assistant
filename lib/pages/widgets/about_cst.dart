import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutCST extends StatelessWidget {
  const AboutCST({Key? key}) : super(key: key);

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
                'businessPartner'.tr,
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
                child: Image.asset('assets/images/cst_logo.png'),
              ),
              Expanded(
                child: Text(
                  'aboutCst'.tr,
                  // overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    // fontFamily: 'font'.tr,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
