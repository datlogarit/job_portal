import 'package:flutter/material.dart';

class CatagoryListSearch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CatagoryListSearchState();
  }
}

class _CatagoryListSearchState extends State<CatagoryListSearch> {
  final Map<String, bool> catagoryList = {
    'Developer': true,
    'Designer': false,
    'Accounting': false,
    'Engineer': false,
    'Doctor': false,
    'Teacher': false,
  };
  // final
  @override
  Widget build(BuildContext context) {
    List<String> keys = catagoryList.keys.toList();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setState(() {
              var res = catagoryList[keys[index]] ?? false;
              catagoryList[keys[index]] = !res;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).primaryColor, width: .6),
                borderRadius: BorderRadius.circular(20),
                color: catagoryList[keys[index]] != null &&
                        catagoryList[keys[index]] == true
                    ? Theme.of(context).primaryColor
                    : Colors.white),
            child: Row(children: [
              Text(
                keys[index],
                style: catagoryList[keys[index]] != null &&
                        catagoryList[keys[index]] == true
                    ? TextStyle(color: Colors.white, fontSize: 13)
                    : TextStyle(color: Colors.black, fontSize: 13),
              ),
              catagoryList[keys[index]] != null &&
                      catagoryList[keys[index]] == true
                  ? Row(children: [
                      SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.close,
                        color: Colors.white,
                      )
                    ])
                  : Container()
            ]),
          ),
        ),
        separatorBuilder: (context, index) => SizedBox(
          width: 10,
        ),
        itemCount: keys.length,
      ),
    );
    // return Text('data');
  }
}
