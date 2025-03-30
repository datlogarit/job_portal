import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_portal/models/job_model.dart';
import 'package:job_portal/providers/application_provider.dart';
import 'package:job_portal/providers/user_provider.dart';
import 'package:provider/provider.dart';

class SaveIcon extends StatefulWidget {
  final Job job;
  const SaveIcon({super.key, required this.job});

  @override
  State<SaveIcon> createState() => _SaveIconState();
}

class _SaveIconState extends State<SaveIcon> {
  bool isSave = false;
  @override
  void initState() {
    super.initState();
    getApplication();
  }

  void getApplication() async {
    try {
      final userProvider = context.read<UserProvider>();
      final applicationProvider = context.read<ApplicationProvider>();
      await applicationProvider.fetchApplication(
          userProvider.user.id!, widget.job.id!);
      setState(() {
        if (applicationProvider.application.isSaved == 1) {
          isSave = true;
        } else {
          isSave = false;
        }
      });
    } catch (e) {
      setState(() {
        isSave = false;
      });
    }
  }

  void toggleSave() {
    setState(() {
      isSave = !isSave;
      final applicationProvider = context.read<ApplicationProvider>();
      final userProvider = context.read<UserProvider>();

      applicationProvider.toggleIsSave(
          userProvider.user.id!, widget.job.id!, isSave);
    });

    Fluttertoast.showToast(
      msg: isSave ? "Lưu tin thành công" : "Đã bỏ lưu tin",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Theme.of(context).primaryColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        isSave ? Icons.bookmark : Icons.bookmark_outline,
        color: isSave ? Theme.of(context).primaryColor : Colors.grey,
        size: 32,
      ),
      onTap: () {
        toggleSave();
      },
    );
  }
}
