import 'package:flutter/material.dart';
import 'package:zhebsa_assistant/pages/components/text_detail.dart';

class ZhebsaOfDayDetail extends StatelessWidget {
  final String searchQuery;
  const ZhebsaOfDayDetail({Key? key, required this.searchQuery})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(searchQuery), //'wordOfTheDay'.tr
      ),
      body: TextDetail(
        searchQuery: searchQuery,
      ),
    );
  }
}
