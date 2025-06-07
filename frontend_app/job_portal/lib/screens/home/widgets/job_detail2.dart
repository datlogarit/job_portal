import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/models/job_model.dart';
import 'package:job_portal/providers/application_provider.dart';
import 'package:job_portal/providers/applicant_provider.dart';
import 'package:job_portal/screens/application_page/application_page.dart';

import 'package:job_portal/screens/report/report.dart';
import 'package:job_portal/widgets/save_icon.dart';
import 'package:job_portal/widgets/text_icons.dart';
import 'package:provider/provider.dart';
import 'package:step_tracker/step_tracker.dart';

class JobDetail extends StatefulWidget {
  final Job job;
  final bool workTime;
  JobDetail({required this.job, this.workTime = true});
  String formatRequirement(String requirement) {
    return requirement
        .replaceAll(RegExp(r"[\r\n]+"), "\n") // Chuẩn hóa xuống dòng
        .replaceAllMapped(RegExp(r"[●\•\-\+\*]"), (match) => "\n•")
        .replaceAll(RegExp(r"\n{2,}"), "\n") // Xóa dòng trống thừa
        .trim();
  }

  @override
  State<JobDetail> createState() => _JobDetailState();
}

class _JobDetailState extends State<JobDetail> {
  Widget applyButton() {
    return Column(
      children: [
        SizedBox(
          height: 50,
          width: double.maxFinite,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () async {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => ApplicationPage(
              //       job: widget.job,
              //     ),
              //   ),
              // );
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ApplicationPage(job: widget.job)),
              );

              if (result == 'applied') {
                // Gọi hàm reload lại dữ liệu
                setState(() {
                  statusApply = applied();
                }); // Ví dụ: hàm load lại job detail từ API
              }
            },
            child: Text(
              "Apply now",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
    // SizedBox(
    //   height: 20,
    // )
    //   ],
    // );
  }

  Widget applied() {
    return StepTracker(
      dotSize: 0,
      circleIconSize: 20,
      showIcon: false,
      selectedColor: Colors.green,
      unSelectedColor: Colors.red,
      stepTrackerType: StepTrackerType.indexedHorizontal,
      pipeSize: 60,
      steps: [
        Steps(
          title: "Applied",
          titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          state: TrackerState.complete,
        ),
        // Steps(title: "Progress", state: TrackerState.complete),
        Steps(
          title: "Result",
          state: TrackerState.none,
          titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget accepted() {
    return StepTracker(
      dotSize: 0,
      circleIconSize: 20,
      showIcon: false,
      selectedColor: Colors.green,
      unSelectedColor: Colors.red,
      stepTrackerType: StepTrackerType.indexedHorizontal,
      pipeSize: 60,
      steps: [
        Steps(
          title: "Applied",
          titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          state: TrackerState.complete,
        ),
        // Steps(title: "Progress", state: TrackerState.complete),
        Steps(
          title: "Accepted",
          state: TrackerState.complete,
          titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget rejected() {
    return StepTracker(
      dotSize: 0,
      circleIconSize: 20,
      showIcon: false,
      selectedColor: Colors.green,
      unSelectedColor: Colors.red,
      stepTrackerType: StepTrackerType.indexedHorizontal,
      pipeSize: 60,
      steps: [
        Steps(
          title: "Applied",
          titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          state: TrackerState.complete,
        ),
        // Steps(title: "Progress", state: TrackerState.complete),
        Steps(
          title: "Rejected",
          state: TrackerState.disabled,
          titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    getApplication();
  }

  void getApplication() async {
    try {
      final userProvider = context.read<ApplicantProvider>();
      final applicationProvider = context.read<ApplicationProvider>();
      await applicationProvider.fetchApplication(
          userProvider.applicant.userId!.id!, widget.job.id!);
      // print("ui: ${applicationProvider.application.statusApply}");
      setState(() {
        if (applicationProvider.application.statusApply == null) {
          statusApply = applyButton();
        } else if (applicationProvider.application.statusApply == 'Pending') {
          statusApply = applied();
        } else if (applicationProvider.application.statusApply == 'Approved') {
          statusApply = accepted();
        } else if (applicationProvider.application.statusApply == 'Rejected') {
          statusApply = rejected();
        }
      });
    } catch (e) {
      setState(() {
        statusApply = applyButton();
      });
    }
  }

  Widget statusApply = Container();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Job Detail"),
      // ),
      body: SafeArea(
        child: Container(
          // // height: 580,
          // width: double.maxFinite,
          // decoration: BoxDecoration(
          //   color: Colors.white,
          //   borderRadius: BorderRadius.only(
          //     topLeft: Radius.circular(30),
          //     topRight: Radius.circular(30),
          //   ),
          // ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Center(
                  //   child: Container(
                  //     width: 60,
                  //     height: 4,
                  //     margin: EdgeInsets.only(top: 20),
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(8),
                  //       color: const Color.fromRGBO(158, 158, 158, .4),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 30,
                  // ),
                  Row(
                    //avt với company name
                    children: [
                      SizedBox(
                        height: 70,
                        width: 280,
                        child: Row(
                          children: [
                            Container(
                              width: 55,
                              height: 55,
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(158, 158, 158, .3),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    widget.job.postedBy!.companyId!.urlAvt!,
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
                              child: Text(
                                Stringhelper.formatText(
                                    widget.job.postedBy!.companyId!.name!, 200),
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          SaveIcon(job: widget.job),
                          SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.zero),
                                backgroundColor: Colors.white,
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => Container(
                                  height: 60,
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Report(
                                                          job: widget.job,
                                                        )));
                                          },
                                          child: Row(children: [
                                            Icon(Icons.flag),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Báo cáo tin tuyển dụng",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: Icon(
                              Icons.more_horiz,
                              size: 30,
                              color: const Color.fromARGB(255, 28, 28, 28),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.job.title!,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextIcons(Icons.location_on_sharp,
                          "${widget.job.workLocation}"),
                      widget.workTime
                          ? TextIcons(
                              Icons.timelapse,
                              Stringhelper.formatText(
                                  "${widget.job.workingTime}", 200),
                            )
                          : Container(),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Description",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.job.description!,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Requirement",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.formatRequirement(widget.job.requirement!),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  statusApply,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Stringhelper {
  static String formatText(String title, int character) {
    // Viết hoa chữ cái đầu mỗi từ
    String capitalizedTitle = title
        .split(' ')
        .map((word) => word.isNotEmpty
            ? word[0].toUpperCase() + word.substring(1).toLowerCase()
            : '')
        .join(' ');

    return capitalizedTitle.length > character
        ? "${capitalizedTitle.substring(0, character)}..."
        : capitalizedTitle;
  }

  static String formatLocation(String location) {
    return location.contains(',')
        ? location
            .split(',')[0]
            .trim() // Lấy phần trước dấu ',' và loại bỏ khoảng trắng
        : location.trim(); // Nếu không có dấu ',', giữ nguyên
  }

  static String formatSalary(int? salary) {
    String salaryStr = salary.toString();
    List<String> parts = [];
    while (salaryStr.length > 3) {
      parts.insert(0, salaryStr.substring(salaryStr.length - 3));
      salaryStr = salaryStr.substring(0, salaryStr.length - 3);
    }
    parts.insert(0, salaryStr);
    return parts.join('.');
  }
}
