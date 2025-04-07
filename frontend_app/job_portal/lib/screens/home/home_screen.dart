import 'package:flutter/material.dart';

import 'package:job_portal/screens/home/widgets/home_app_bar.dart';
import 'package:job_portal/screens/home/widgets/job_list.dart';
import 'package:job_portal/screens/home/widgets/search_card.dart';
import 'package:job_portal/screens/home/widgets/tag_list.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.white,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: const Color.fromRGBO(158, 158, 158, .1),
                ),
              ),
            ],
          ),
          SafeArea(
            child: Column(
              children: [
                HomeAppBar(),
                SearchCard(),
                TagList(),
                JobList(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
