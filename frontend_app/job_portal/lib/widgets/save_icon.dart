import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_portal/models/job_model.dart';
import 'package:job_portal/providers/interaction_provider.dart';
import 'package:job_portal/providers/applicant_provider.dart';
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
    getInteraction();
  }

  void getInteraction() async {
    final userProvider = context.read<ApplicantProvider>();
    final interactionProvider = context.read<InteractionProvider>();

    try {
      await interactionProvider.fetchInteraction(
        userProvider.applicant.userId!.id!,
        widget.job.id!,
      );

      final isSaved = interactionProvider.interaction.isSaved == 1;
      setState(() {
        isSave = isSaved;
      });
    } catch (e) {
      // Fluttertoast.showToast(msg: e.toString());
      // Bắt lỗi và gán isSave = false nếu có exception
      // setState(() {
      //   isSave = false;
      // });
    }
  }

  void toggleSave() {
    setState(() {
      isSave = !isSave;
      final interactionProvider = context.read<InteractionProvider>();
      final userProvider = context.read<ApplicantProvider>();

      interactionProvider.toggleIsSave(
          userProvider.applicant.userId!.id!, widget.job.id!, isSave);
    });

    Fluttertoast.showToast(
      msg: isSave ? "Successfully saved" : "Unsaved",
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
        size: 28,
      ),
      onTap: () {
        toggleSave();
      },
    );
  }
}
