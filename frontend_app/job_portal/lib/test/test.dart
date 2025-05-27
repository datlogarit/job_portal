import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RadioExample(),
    );
  }
}

class RadioExample extends StatefulWidget {
  @override
  _RadioExampleState createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  String _selectedValue = "Option 1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Group Radio Button Example")),
      body: Column(
        children: [
          SizedBox(height: 10),
          RadioButton(
            description: "Option 1",
            value: "Option 1",
            groupValue: _selectedValue,
            onChanged: (value) {
              setState(() {
                _selectedValue = value!;
              });
            },
          ),
          RadioButton(
            description: "Option 2",
            value: "Option 2",
            groupValue: _selectedValue,
            onChanged: (value) {
              setState(() {
                _selectedValue = value!;
              });
            },
          ),
          SizedBox(height: 20),
          Text("Selected: $_selectedValue"),
        ],
      ),
    );
  }
}
