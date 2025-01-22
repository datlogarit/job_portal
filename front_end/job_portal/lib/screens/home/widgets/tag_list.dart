import 'package:flutter/material.dart';

class TagLiss extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TagListState();
  }
}

class _TagListState extends State<TagLiss> {
  final List<String> tagList = [
    '💡Recommened',
    'All',
    '⚡Popular',
    '🌟Featured',
    '🔝 Top Company',
  ];
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 45,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => GestureDetector(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  decoration: BoxDecoration(
                      color: selected == index
                          ? Color.fromRGBO(67, 177, 183, .3)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: selected == index
                            ? Color.fromRGBO(67, 177, 183, 1)
                            : Color.fromRGBO(67, 177, 183, .3),
                      )),
                  child: Text(
                    tagList[index],
                    style: TextStyle(fontSize: 18),
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
