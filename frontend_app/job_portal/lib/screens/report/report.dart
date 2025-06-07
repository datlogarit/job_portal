import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_portal/models/job_model.dart';
import 'package:job_portal/providers/applicant_provider.dart';
import 'package:job_portal/repositories/report_repository.dart';
import 'package:job_portal/screens/report/widgets/radio_list.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class Report extends StatelessWidget {
  Job job = Job();
  final TextEditingController reasonController = TextEditingController();
  Report({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<ApplicantProvider>();
    return Scaffold(
      // resizeToAvoidBottomInset: false,
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
              "Report",
              style: TextStyle(
                // fontFamily: "Roboto",
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(width: 20)
          ],
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(67, 177, 183, .8),
      ),
      body: Container(
        height: 800,
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
                        "Job posting report",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                          "Research the employer and the job you are applying for. Be wary of jobs that require a fee or offer unclear, ambiguous contracts. If you think a job posting is incorrect, please report it to us.")
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
                        "Recruitment post",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        job.title!,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: const Color.fromRGBO(158, 158, 158, .4),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Reason  ",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              "*",
                              style: TextStyle(color: Colors.red, fontSize: 20),
                            ),
                          )
                        ],
                      ),
                      RadioList(
                        reasonController,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: SizedBox(
                  height: 52,
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () async {
                      bool isSuccess = await ReportRepository.sendReport(
                          job.id!,
                          userProvider.applicant.id!,
                          reasonController.text);
                      isSuccess
                          ? QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              text: 'Report successfully!',
                              // autoCloseDuration: const Duration(seconds: 3),
                              showConfirmBtn: true,
                              onConfirmBtnTap: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              })
                          : Fluttertoast.showToast(msg: "An error occurrred");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
