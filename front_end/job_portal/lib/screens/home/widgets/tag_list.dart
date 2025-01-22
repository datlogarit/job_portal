import 'package:flutter/material.dart';

class TagLiss extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TagListState();
  }
}

class _TagListState extends State<TagLiss> {
  final List<String> tagList = ['All', '⚡Popular', '🌟Featured'];
  // final taglist = <String> ['xin','chao'];
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      // padding: ,
      height: 50,
      decoration: BoxDecoration(
        // color: Colors.lightBlue,
        borderRadius: BorderRadius.circular(20),
        // border: Border.all(color: Color(prima))
      ),
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    tagList[index],
                    style: TextStyle(
                        fontSize: 18, backgroundColor: Colors.lightBlue),
                  ),
                ),
                onTap: () {
                  setState(() {
                    selected = index;
                  });
                },
              ),
          separatorBuilder: (_, index) => SizedBox(
                width: 15,
              ),
          itemCount: tagList.length),
    );
  }
}
