import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';

class SuggestionSetting extends StatefulWidget {
  const SuggestionSetting({super.key});

  @override
  State<SuggestionSetting> createState() => _SuggestionSettingState();
}

class _SuggestionSettingState extends State<SuggestionSetting> {
  String _selectedValue = "value"; // giá trị mặc định
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, //ẩn nút back khi đi từ trang detail
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.close_rounded,
                size: 26,
                color: Colors.white,
              ),
            ),
            Text(
              "Suggestion Settings",
              style: TextStyle(
                // fontFamily: "Roboto",
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(width: 16)
          ],
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(67, 177, 183, .8),
        // backgroundColor: Color.fromRGBO(67, 177, 183, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Gender",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    RadioButton(
                      description: "description",
                      value: "value",
                      groupValue: _selectedValue,
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value!;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Working time",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  // obscureText: !isVisibilityPw,
                  validator: (value) {},
                  decoration: InputDecoration(
                    hintText: "Current password",
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.all(8),
                    isDense: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: .6),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: .6),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Profession/Field",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  // obscureText: !isVisibilityPw,
                  validator: (value) {},
                  decoration: InputDecoration(
                    hintText: "Current password",
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.all(8),
                    isDense: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: .6),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: .6),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Job Position",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  // obscureText: !isVisibilityPw,
                  validator: (value) {},
                  decoration: InputDecoration(
                    hintText: "Current password",
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.all(8),
                    isDense: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: .6),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: .6),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Work location",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  // obscureText: !isVisibilityPw,
                  validator: (value) {},
                  decoration: InputDecoration(
                    hintText: "Current password",
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.all(8),
                    isDense: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: .6),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: .6),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Work experience",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  // obscureText: !isVisibilityPw,
                  validator: (value) {},
                  decoration: InputDecoration(
                    hintText: "Current password",
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.all(8),
                    isDense: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: .6),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: .6),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Center(
                child: SizedBox(
                  height: 50,
                  width: 360,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white),
                    onPressed: () {},
                    child: Text(
                      "Update",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
