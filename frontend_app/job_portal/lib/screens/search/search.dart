import 'package:flutter/material.dart';
import 'package:job_portal/screens/search/widgets/tag_list.dart';
import 'package:job_portal/screens/search/widgets/list_search.dart';

import 'package:job_portal/screens/search/widgets/search_app_bar.dart';
import 'package:job_portal/screens/search/widgets/search_input.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                SizedBox(
                  height: 5,
                ),
                SearchInput(),
                SizedBox(
                  height: 15,
                ),
                CatagoryListSearch(),
                SizedBox(
                  height: 15,
                ),
                ListSearch(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
