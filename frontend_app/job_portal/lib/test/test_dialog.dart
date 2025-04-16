import 'package:flutter/material.dart';

class TestDialog extends StatelessWidget {
  const TestDialog({super.key});
  void showSuccessBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 50),
              SizedBox(height: 10),
              Text("Đăng ký thành công!", style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Text("Bạn đã tạo tài khoản thành công. Vui lòng đăng nhập."),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => Navigator.pop(context), // Đóng BottomSheet
                child: Text("OK"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            // style: ,
            onPressed: () {
              // showSuccessBottomSheet(context);
              // showDialog(
              //   context: context,
              //   builder: (BuildContext context) {
              //     return AlertDialog(
              //       title: Text("Đăng ký thành công!"),
              //       content: Text(
              //           "Bạn đã tạo tài khoản thành công. Vui lòng đăng nhập."),
              //       actions: [
              //         TextButton(
              //           onPressed: () {
              //             Navigator.of(context).pop(); // Đóng dialog
              //           },
              //           child: Text("OK"),
              //         ),
              //       ],
              //     );
              //   },
              // );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Đăng ký thành công!\nHãy đăng nhập để sử dụng dịch vụ",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                  duration: Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating, // Hiển thị nổi
                ),
              );
            },
            child: Text("xin chao")),
      ),
    );
  }
}
