import 'package:flutter/material.dart';
import 'package:job_portal/screens/home/widgets/recommend_detail.dart';

class TagList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TagListState();
  }
}

class _TagListState extends State<TagList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18),
      height: 43,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: Color.fromRGBO(67, 177, 183, .3),
              borderRadius: BorderRadius.circular(10), //18
              border: Border.all(color: Color.fromRGBO(67, 177, 183, 1)),
            ),
            child: Text(
              "Recommended for you",
              style: TextStyle(fontSize: 16),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => RecommendDetail()),
              );
            },
            child: Text(
              "Detail",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
            ),
          )
        ],
      ),
    );
  }
}
