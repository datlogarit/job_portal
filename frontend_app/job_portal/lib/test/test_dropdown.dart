import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestDropdown extends StatefulWidget {
  @override
  _TestDropdownState createState() => _TestDropdownState();
}

class _TestDropdownState extends State<TestDropdown> {
  List<String> items = ["Option 1", "Option 2", "Option 3", "Option 4"];
  int selectedIndex = 0; // Chỉ số mục được chọn

  void _showPicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 250,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 200,
              child: CupertinoPicker(
                backgroundColor: Colors.white,
                itemExtent: 40, // Chiều cao mỗi item
                scrollController:
                    FixedExtentScrollController(initialItem: selectedIndex),
                onSelectedItemChanged: (int index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                children: items.map((item) => Text(item)).toList(),
              ),
            ),
            CupertinoButton(
              child: Text("Chọn"),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("iOS Style Dropdown")),
      body: Center(
        child: GestureDetector(
          onTap: _showPicker,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(items[selectedIndex], style: TextStyle(fontSize: 16)),
          ),
        ),
      ),
    );
  }
}
