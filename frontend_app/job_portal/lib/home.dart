import 'package:flutter/material.dart';
import 'package:job_portal/screens/job_interaction/job_interaction.dart';
import 'package:job_portal/screens/home/home_screen.dart';
import 'package:job_portal/screens/persional/persional.dart';
import 'package:job_portal/screens/search/search.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndexVar = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndexVar,
        children: [
          HomePage(),
          JobInteractionPage(),
          SearchPage(),
          ProfileScreen()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            currentIndexVar = value;
          });
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Theme.of(context).primaryColor,
        currentIndex: currentIndexVar,
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
            label: 'Search',
            icon: Icon(
              Icons.search_rounded,
              size: 28,
            ),
          ),
          // BottomNavigationBarItem(
          //   label: 'Chat',
          //   icon: Icon(
          //     Icons.chat_outlined,
          //     size: 28,
          //   ),
          // ),
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
