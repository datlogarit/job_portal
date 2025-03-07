import 'package:flutter/material.dart';
// import 'package:job_portal/screens/start/login/formContent.dart';
import 'package:job_portal/screens/start/login/login.dart';
import 'package:job_portal/screens/start/register/formContentRegister.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg_login.jpg"),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned(
                          top: 100,
                          left: 30,
                          child: Text(
                            "REGISTER",
                            style: TextStyle(
                                fontSize: 45,
                                fontWeight: FontWeight.w900,
                                color: Colors.white),
                          ),
                        ),
                        Positioned(
                          top: 160,
                          left: 35, // Đ
                          child: Text(
                            "To Processed",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 11,
              child: SizedBox(
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(35)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: FormContentRegister(),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "You aready have an account  ",
                            style: TextStyle(fontSize: 15),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
                            },
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
