import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 300,
      width: double.maxFinite,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.symmetric(vertical: 35, horizontal: 25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          image: DecorationImage(
              image: AssetImage("assets/images/search_bg.png"),
              fit: BoxFit.contain)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Fast search",
            style: TextStyle(
                fontSize: 26, fontWeight: FontWeight.w700, color: Colors.white),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "You can search quickly\n for the jobs you want",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      "Search",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
