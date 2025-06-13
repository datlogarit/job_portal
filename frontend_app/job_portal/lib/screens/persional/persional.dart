import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_portal/home.dart';
import 'package:job_portal/providers/applicant_provider.dart';
import 'package:job_portal/repositories/applicant_repository.dart';
import 'package:job_portal/screens/authenticate/login/login.dart';
import 'package:job_portal/screens/persional/widget/change_pass.dart';
import 'package:job_portal/screens/persional/widget/suggestion_setting.dart';
import 'package:provider/provider.dart';

// class ProfileScreen extends StatelessWidget {

// }

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  // ApplicantRepository applicantRepository = ApplicantRepository();
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<ApplicantProvider>();
    Future<void> pickFile() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png'],
      );

      if (result != null && result.files.single.path != null) {
        //lấy file, xử lý và gửi lên cho backend
        //cập nhật giao ảnh đại diện bên dưới là file đó

        File file = File(result.files.single.path!); // nếu cần xử lý file
        await ApplicantRepository.updateAvt(userProvider.applicant.id!, file);
        await context.read<ApplicantProvider>().getApplicant(
            userProvider.applicant.userId!.email!, userProvider.password!);
        setState(() {});
      } else {
        // Người dùng hủy
        print("Nothing happen");
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                      },
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    const Text(
                      "Profile",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4), // độ dày của viền
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).primaryColor, // màu viền
                            width: 1, // độ dày viền
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              'http://10.0.2.2:8088/api/v1/user/images/${userProvider.applicant.userId!.urlAvatar}'),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        padding: const EdgeInsets.all(4),
                        child: GestureDetector(
                          onTap: () {
                            pickFile();
                            print("say goodbey");
                          },
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '${userProvider.applicant.userId!.name}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${userProvider.applicant.userId!.email}',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                _grap,
                CustomProfileOption(
                  icon: Icons.settings_suggest,
                  label: "Job Suggestion Settings",
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SuggestionSetting()));
                    // Xử lý sự kiện khi click
                  },
                ),
                // CustomProfileOption(
                //   icon: Icons.person,
                //   label: "Edit Profile",
                //   onTap: () {
                //     // Xử lý sự kiện khi click
                //   },
                // ),
                CustomProfileOption(
                  icon: Icons.lock,
                  label: "Change Password",
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ChangePass()));
                    // Xử lý sự kiện khi click
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Center(
                child: SizedBox(
                  height: 50,
                  width: 350,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                        (rount) => false,
                      );
                      Fluttertoast.showToast(
                        msg: "Logged out",
                        fontSize: 18,
                        backgroundColor: Theme.of(context).primaryColor,
                        gravity: ToastGravity.CENTER,
                      );
                    },
                    child: const Text(
                      "Logout",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _grap = SizedBox(
  height: 30,
);

class CustomProfileOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const CustomProfileOption({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5), // màu nền xám nhẹ
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.black87,
              size: 25,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
              weight: 800,
              size: 25,
            ),
          ],
        ),
      ),
    );
  }
}
