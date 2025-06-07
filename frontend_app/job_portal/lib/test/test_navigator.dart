import 'package:flutter/material.dart';
import 'package:job_portal/models/user_model.dart';
import 'package:job_portal/providers/applicant_provider.dart';
import 'package:job_portal/screens/job_interaction/job_interaction.dart';
import 'package:job_portal/screens/home/widgets/home_app_bar.dart';
import 'package:job_portal/screens/home/widgets/job_list.dart';
import 'package:job_portal/screens/home/widgets/search_card.dart';
import 'package:job_portal/screens/home/widgets/tag_list.dart';
import 'package:provider/provider.dart';

class HomePageTest extends StatefulWidget {
  final User user;
  const HomePageTest({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageTestState createState() => _HomePageTestState();
}

class _HomePageTestState extends State<HomePageTest> {
  int currentIndex = 0;

  final List<Widget> pages = [
    HomeScreen(), // Trang Home
    // Application(), // Trang Bookmark
    ContactScreen(), // Trang Contact
    ChatScreen(), // Trang Chat
    ProfileScreen(), // Trang Profile
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Bookmark',
            icon: Icon(Icons.bookmark_added_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Contact',
            icon: Icon(Icons.contact_mail_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Chat',
            icon: Icon(Icons.chat_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Person',
            icon: Icon(Icons.person_outline),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          HomeAppBar(),
          SearchCard(),
          TagList(),
          JobList(),
        ],
      ),
    );
  }
}

// Các màn hình khác cần tạo riêng:
class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Contact Screen"));
  }
}

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Chat Screen"));
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Profile Screen"));
  }
}
