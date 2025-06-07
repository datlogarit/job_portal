import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_portal/home.dart';
import 'package:job_portal/providers/applicant_provider.dart';
import 'package:job_portal/repositories/applicant_repository.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class ChangePass extends StatefulWidget {
  ChangePass({super.key});
  ApplicantRepository applicantRepository = ApplicantRepository();
  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  final TextEditingController _currentPwController = TextEditingController();
  final TextEditingController _newPwController = TextEditingController();
  final TextEditingController _retypePwController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isVisibilityPw = false;
  bool isVisibilityNPw = false;
  bool isVisibilityCFNPw = false;

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<ApplicantProvider>();
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
              "Change Password",
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
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Current Password",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _currentPwController,
                    obscureText: !isVisibilityPw,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your current password.';
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Current password",
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
                      border: OutlineInputBorder(),
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
                    "New Password",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _newPwController,
                    obscureText: !isVisibilityNPw,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the new password';
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Enter the new password",
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
                      border: OutlineInputBorder(),
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
                    "Retype Password",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _retypePwController,
                    obscureText: !isVisibilityCFNPw,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please retype new password";
                      }
                      if (value != _newPwController.text) {
                        return "Confirm password not match";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Re-enter new password",
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
                      border: OutlineInputBorder(),
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Center(
                child: SizedBox(
                  height: 50,
                  width: 360,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white),
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        try {
                          await ApplicantRepository.changePassword(
                              userProvider.applicant.id!,
                              _currentPwController.text,
                              _newPwController.text);
                        } catch (e) {
                          Fluttertoast.showToast(
                            msg: e.toString().replaceFirst("Exception: ", ""),
                            backgroundColor: Colors.red,
                            fontSize: 17,
                          );
                          return;
                        }
                        QuickAlert.show(
                            context: context,
                            type: QuickAlertType.success,
                            text: 'Change password successfully!',
                            // autoCloseDuration: const Duration(seconds: 3),
                            showConfirmBtn: true,
                            onConfirmBtnTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Home()),
                              );
                            });

                        // Fluttertoast.showToast(
                        //   msg: "Change password successfully",
                        //   backgroundColor: Theme.of(context).primaryColor,
                        //   fontSize: 17,
                        //   gravity: ToastGravity.CENTER,
                        // );
                        //gửi dữ liệu lên server và trả về thông báo là xong
                      }
                    },
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
