import 'package:flutter/material.dart';
import 'package:job_portal/home.dart';

class SearchAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      // borderRadius: BorderRadius.circular(19)
                      shape: BoxShape.circle),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
              Icon(
                Icons.more_horiz,
                size: 30,
                color: Colors.grey,
              ),
              // Row(
              //   children: [
              //     Container(
              //       transform: Matrix4.rotationZ(100),
              //       padding: EdgeInsets.only(top: 30, right: 15),
              //       child: Stack(
              //         children: [
              //           Icon(
              //             Icons.notifications_none_outlined,
              //             size: 30,
              //             color: Colors.grey,
              //           ),
              //           Positioned(
              //             top: 0,
              //             right: 0,
              //             child: Container(
              //               padding: EdgeInsets.all(4),
              //               decoration: BoxDecoration(
              //                   color: Colors.red,
              //                   borderRadius: BorderRadius.circular(10)),
              //             ),
              //           )
              //         ],
              //       ),
              //     ),
              //     SizedBox(
              //       width: 12,
              //     ),
              //     Icon(
              //       Icons.more_horiz,
              //       size: 30,
              //     )
              //   ],
              // ),
            ],
          )
        ],
      ),
    ));
  }
}
