import 'package:flutter/material.dart';

class ChangePass extends StatefulWidget {
  const ChangePass({super.key});

  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  bool isVisibilityPw = false;
  bool isVisibilityNPw = false;
  bool isVisibilityCFNPw = false;

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
              "Đổi mật khẩu",
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Mật khẩu hiện tại",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: !isVisibilityPw,
                  validator: (value) {},
                  decoration: InputDecoration(
                    hintText: "Nhập mật khẩu hiện tại",
                    hintStyle: TextStyle(color: Colors.grey),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          isVisibilityPw = !isVisibilityPw;
                        });
                      },
                      child: Icon(
                        !isVisibilityPw
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: 24,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
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
                  height: 25,
                ),
                Text(
                  "Mật khẩu mới",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: !isVisibilityNPw,
                  validator: (value) {},
                  decoration: InputDecoration(
                    hintText: "Nhập mật khẩu mới",
                    hintStyle: TextStyle(color: Colors.grey),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          isVisibilityNPw = !isVisibilityNPw;
                        });
                      },
                      child: Icon(
                        !isVisibilityNPw
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: 24,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
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
                  height: 25,
                ),
                Text(
                  "Xác nhận mật khẩu mới",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: !isVisibilityCFNPw,
                  validator: (value) {},
                  decoration: InputDecoration(
                    hintText: "Nhập lại mật khẩu mới",
                    hintStyle: TextStyle(color: Colors.grey),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          isVisibilityCFNPw = !isVisibilityCFNPw;
                        });
                      },
                      child: Icon(
                        !isVisibilityCFNPw
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: 24,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
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
              padding: const EdgeInsets.symmetric(vertical: 28),
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
                      "Cập nhật",
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

// class ChangePass extends StatelessWidget {
//   const ChangePass({super.key});

// }
