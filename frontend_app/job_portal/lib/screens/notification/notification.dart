import 'package:flutter/material.dart';

class CustomNotification extends StatefulWidget {
  const CustomNotification({super.key});

  @override
  State<CustomNotification> createState() => _CustomNotificationState();
}

class _CustomNotificationState extends State<CustomNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false, //ẩn nút back khi đi từ trang detail
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.close_rounded,
                size: 26,
                color: Colors.black,
              ),
            ),
            Text(
              "Thông báo",
              style: TextStyle(
                // fontFamily: "Roboto",
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.download_done_rounded,
                size: 26,
                color: Colors.black,
              ),
            ),
          ],
        ),

        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 4,
          ),
          Container(
            width: double.maxFinite,
            height: 1,
            color: const Color.fromRGBO(158, 158, 158, .4),
          ),
          ListView.separated(
              itemBuilder: (context, index) => GestureDetector(
                    onTap: () {},
                  ),
              separatorBuilder: (_, index) => SizedBox(
                    height: 10,
                  ),
              itemCount: 20)
        ],
      ),
    );
  }
}


// Row(
//             children: [
//               Container(
//                 width: 90,
//                 height: 90,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(20))),
//                 child: Image(
//                   image: AssetImage("assets/images/avt_nam.jpg"),
//                 ),
//               )
//             ],
//           )