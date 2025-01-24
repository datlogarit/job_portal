import 'package:flutter/material.dart';

import 'package:job_portal/screens/search/widgets/search_app_bar.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Stack(children: [
      Row(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                color: Colors.white,
              )),
          Expanded(
              flex: 1,
              child: Container(
                color: const Color.fromRGBO(158, 158, 158, .1),
              )),
        ],
      ),
      SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SearchAppBar(),
        ],
      ))
    ]));
  }
}
