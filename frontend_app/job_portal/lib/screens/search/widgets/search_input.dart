import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: TextField(
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(30),
                //   borderSide: BorderSide(
                //     color: Colors.lightGreenAccent, // Màu viền
                //     width: 2.0, // Độ dày viền
                //   ),
                // ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: const Color.fromRGBO(158, 158, 158,
                        .4), // Viền khi TextField không được chọn
                    width: .3,
                  ),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: const Color.fromRGBO(
                        158, 158, 158, 1), // Viền khi TextField được chọn
                    width: .6,
                  ),
                ),

                hintText: 'Search',
                hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                prefixIcon: Icon(
                  Icons.search,
                  size: 28,
                  color: const Color.fromARGB(255, 133, 132, 132),
                ),
                // scontentPadding: EdgeInsets.zero
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            height: 42,
            width: 42,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color.fromRGBO(254, 212, 8, .9)),
            child: Image.asset(
              "assets/images/filter.png",
              color: Colors.white,
              // width: 1,
            ),
          ),
          Row()
        ],
      ),
    );
  }
}
