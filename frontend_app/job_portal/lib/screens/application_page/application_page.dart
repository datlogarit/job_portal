import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_portal/screens/home/widgets/job_detail2.dart';
import 'package:quickalert/quickalert.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/models/job_model.dart';
import 'package:job_portal/providers/applicant_provider.dart';
import 'package:job_portal/repositories/application_repository.dart';
import 'package:job_portal/screens/application_page/upload_cv.dart';
import 'package:provider/provider.dart';

class ApplicationPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File? fileByUser;
  Job job;
  ApplicationPage({super.key, required this.job});
  void getFile(File? file) {
    fileByUser = file;
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<ApplicantProvider>();
    final TextEditingController nameController =
        TextEditingController(text: userProvider.applicant.userId!.name);
    final TextEditingController emailController =
        TextEditingController(text: userProvider.applicant.userId!.email);
    final TextEditingController phoneNumberController = TextEditingController();
    final TextEditingController messageController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, //ẩn nút back khi đi từ trang detail
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 26,
              ),
            ),
            Text(
              "Apply the job",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(
              width: 25,
            )
          ],
        ),

        centerTitle: true,
        backgroundColor: Color.fromRGBO(67, 177, 183, .8),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(158, 158, 158, .2),
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Apply the job",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text('Please read the recruitment information carefully '
                          'before applying. If you are sure, please fill in the '
                          'information in the form below and click the "confirm"'
                          ' button. When you apply, the information below will be sent to the employer.')
                    ],
                  ),
                ),
              ),
              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: const Color.fromRGBO(158, 158, 158, .4),
                        width: 1),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Job post",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        // color: const Color.fromRGBO(179, 229, 252, .4),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            // color: Color.fromRGBO(179, 229, 252, .3),
                            color: Color.fromRGBO(67, 177, 183, .17),
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 60,
                              width: 60,
                              child: CachedNetworkImage(
                                imageUrl: job.postedBy!.companyId!.urlAvt!
                                        .startsWith("http")
                                    ? job.postedBy!.companyId!.urlAvt!
                                    : 'http://10.0.2.2:8088/api/v1/company/images/${job.postedBy!.companyId!.urlAvt!}',
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  'assets/images/vietnamwork_avt.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Stringhelper.formatText(
                                        job.postedBy!.companyId!.name!, 50),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    job.title!,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              UploadCv(
                bindingValue: getFile,
              ),
              SizedBox(
                height: 5,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Full name",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "*",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.redAccent),
                          ),
                        ],
                      ),
                    ),
                    TextField(
                      controller: nameController,
                      enabled: false,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Theme.of(context).primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Theme.of(context).primaryColor),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: const Color.fromRGBO(158, 158, 158, .6)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Email",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "*",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.redAccent),
                            ),
                          ],
                        )),
                    TextField(
                      controller: emailController,
                      enabled: false,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Theme.of(context).primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Theme.of(context).primaryColor),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: const Color.fromRGBO(158, 158, 158, .6)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Phone number",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "*",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.redAccent),
                            ),
                          ],
                        )),
                    TextFormField(
                      controller: phoneNumberController,
                      enabled: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field cann't left empty";
                        }
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "Enter the phone number",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Color.fromRGBO(67, 177, 183, .5)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Color.fromRGBO(67, 177, 183, .5)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Theme.of(context).primaryColor),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: const Color.fromRGBO(158, 158, 158, .6)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Message",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "*",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.redAccent),
                            ),
                          ],
                        )),
                    TextFormField(
                      controller: messageController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cannot be left empty.';
                        }
                      },
                      enabled: true,
                      minLines: 5,
                      maxLines: 6,
                      decoration: InputDecoration(
                        hintText: "Write a brief introduction about yourself "
                            "(strengths, weaknesses and reasons for applying for the job)",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Color.fromRGBO(67, 177, 183, .5)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Color.fromRGBO(67, 177, 183, .5)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Theme.of(context).primaryColor),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: const Color.fromRGBO(158, 158, 158, .6)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: SizedBox(
                        width: double.maxFinite,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              if (fileByUser == null) {
                                Fluttertoast.showToast(
                                  msg: "Please upload your CV file!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.redAccent,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                                return; // Dừng xử lý nếu chưa có file
                              }
                              bool isSuccess =
                                  await ApplicationRepository.createApplication(
                                      userProvider.applicant.id!,
                                      job.id!,
                                      userProvider.applicant.userId!.name!,
                                      userProvider.applicant.userId!.email!,
                                      phoneNumberController.text,
                                      fileByUser!,
                                      messageController.text);
                              isSuccess
                                  ? QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.success,
                                      text: 'Apply successfully!',
                                      // barrierColor: Colors.redAccent,
                                      // autoCloseDuration:
                                      //     const Duration(seconds: 3),
                                      showConfirmBtn: true,
                                      onConfirmBtnTap: () {
                                        Navigator.of(context).pop();
                                        Navigator.pop(context, 'Pending');
                                      })
                                  : QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.error,
                                      title: 'Oops...',
                                      text: 'Sorry, something went wrong',
                                      backgroundColor: Colors.black,
                                      titleColor: Colors.white,
                                      textColor: Colors.white,
                                    );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            backgroundColor: Theme.of(context).primaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Confirm",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w900,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class Stringhelper {
//   static String formatText(String title, int character) {
//     // Viết hoa chữ cái đầu mỗi từ
//     String capitalizedTitle = title
//         .split(' ')
//         .map((word) => word.isNotEmpty
//             ? word[0].toUpperCase() + word.substring(1).toLowerCase()
//             : '')
//         .join(' ');
//     // Giới hạn 15 ký tự, thêm "..." nếu quá dài
//     return capitalizedTitle.length > character
//         ? "${capitalizedTitle.substring(0, character)}..."
//         : capitalizedTitle;
//   }

//   static String formatLocation(String location) {
//     return location.contains(',')
//         ? location
//             .split(',')[0]
//             .trim() // Lấy phần trước dấu ',' và loại bỏ khoảng trắng
//         : location.trim(); // Nếu không có dấu ',', giữ nguyên
//   }

//   static String formatSalary(int? salary) {
//     String salaryStr = salary.toString();
//     List<String> parts = [];
//     while (salaryStr.length > 3) {
//       parts.insert(0, salaryStr.substring(salaryStr.length - 3));
//       salaryStr = salaryStr.substring(0, salaryStr.length - 3);
//     }
//     parts.insert(0, salaryStr);
//     return parts.join('.');
//   }
// }
