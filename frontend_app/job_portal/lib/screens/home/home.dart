import 'package:flutter/material.dart';
import 'package:job_portal/screens/home/widgets/home_app_bar.dart';
import 'package:job_portal/screens/home/widgets/job_list.dart';
import 'package:job_portal/screens/home/widgets/search_card.dart';
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
                    color: const Color.fromRGBO(158, 158, 158, .1),
                  )),
            ],
          ),
          SafeArea(
            child: Column(
              children: [HomeAppBar(), SearchCard(), TagLiss(), JobList()],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          // backgroundColor: const Color.fromRGBO(158, 158, 158, .001)/,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Theme.of(context).primaryColor,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(
                  Icons.house,
                  size: 25,
                )),
            BottomNavigationBarItem(
                label: 'Company',
                icon: Icon(
                  Icons.cases_outlined,
                  size: 25,
                )),
            BottomNavigationBarItem(
                label: 'Contact', icon: Icon(Icons.contact_mail_outlined)),
            BottomNavigationBarItem(
                label: 'Chat',
                icon: Icon(
                  Icons.chat_outlined,
                  size: 25,
                )),
            BottomNavigationBarItem(
                label: 'Person',
                icon: Icon(
                  Icons.person_outline,
                  size: 25,
                ))
          ]),
    );
  }
}
