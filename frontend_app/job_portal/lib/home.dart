import 'package:flutter/material.dart';
import 'package:job_portal/screens/application/application.dart';
import 'package:job_portal/screens/chat/chat_page.dart';
import 'package:job_portal/screens/contact_page/contact_page.dart';
import 'package:job_portal/screens/home/home_screen.dart';
import 'package:job_portal/screens/persional/persional.dart';

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
          ApplicationPage(),
          ContactPage(),
          ChatPage(),
          PersionalPage()
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
