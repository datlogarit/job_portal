import 'package:flutter/material.dart';
import 'package:job_portal/screens/home/widgets/home_app_bar.dart';
import 'package:job_portal/screens/home/widgets/search_app_bar.dart';
import 'package:job_portal/screens/home/widgets/tag_list.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: [
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
                    color: const Color.fromRGBO(158, 158, 158, 0.1),
                  )),
            ],
          ),
          SafeArea(
            child: Column(
              children: [HomeAppBar(), SearchAppBar(), TagLiss()],
            ),
          )
        ],
      ),
    );
  }
}
