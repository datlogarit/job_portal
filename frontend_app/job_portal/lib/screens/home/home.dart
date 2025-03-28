import 'package:flutter/material.dart';
import 'package:job_portal/models/user_model.dart';
import 'package:job_portal/providers/user_provider.dart';
import 'package:job_portal/screens/home/widgets/home_app_bar.dart';
import 'package:job_portal/screens/home/widgets/job_list.dart';
import 'package:job_portal/screens/home/widgets/search_card.dart';
import 'package:job_portal/screens/home/widgets/tag_list.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  User user = User();
  HomePage({required this.user});
  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
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
                // Text("${userProvider.user.email}"),
                HomeAppBar(),
                SearchCard(),
                TagList(),
                JobList(),
              ],
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
              Icons.home,
              size: 28,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Bookmark',
            icon: Icon(
              Icons.bookmark_added_outlined,
              size: 28,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Contact',
            icon: Icon(
              Icons.contact_mail_outlined,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Chat',
            icon: Icon(
              Icons.chat_outlined,
              size: 28,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Person',
            icon: Icon(
              Icons.person_outline,
              size: 28,
            ),
          )
        ],
      ),
    );
  }
}
