import 'package:flutter/material.dart';
import 'package:job_portal/providers/user_provider.dart';
import 'package:job_portal/screens/notification/notification.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome home",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 15),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Jame Madision",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              )
            ],
          ),
          Row(
            children: [
              Container(
                transform: Matrix4.rotationZ(100),
                padding: EdgeInsets.only(top: 30, right: 15),
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CustomNotification()));
                      },
                      child: Icon(
                        Icons.notifications_none_outlined,
                        size: 32,
                        color: Colors.grey,
                      ),
                    ),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                        ))
                  ],
                ),
              ),
              SizedBox(
                width: 32,
              ),
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/images/avt_nam.jpg'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
