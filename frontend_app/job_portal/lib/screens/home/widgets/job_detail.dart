import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/models/job_model.dart';
import 'package:job_portal/screens/application_page/application_page.dart';

import 'package:job_portal/screens/report/report.dart';
import 'package:job_portal/widgets/save_icon.dart';
import 'package:job_portal/widgets/text_icons.dart';

class JobDetail extends StatelessWidget {
  final Job job;
  final bool workTime;

  JobDetail({required this.job, this.workTime = true});

  String formatRequirement(String requirement) {
    return requirement
        .replaceAllMapped(RegExp(r"[●\•\-]"), (match) => "\n•")
        .trim();
  }

  @override
  Widget build(BuildContext context) {
    // final applicationProvider = context.read<InteractionProvider>();
    // TODO: implement build
    return Container(
        height: 580,
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 60,
                    height: 4,
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromRGBO(158, 158, 158, .4)),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  //avt với company name
                  children: [
                    SizedBox(
                      height: 70,
                      width: 280,
                      child: Row(
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(158, 158, 158, .3),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: job.postedBy!.companyId!.urlAvt!,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            // width: 220,
                            child: Text(
                              Stringhelper.formatText(
                                  job.postedBy!.companyId!.name!, 200),
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SaveIcon(job: job),
                        SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
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
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) => Report(
                                                        job: job,
                                                      )));
                                        },
                                        child: Text(
                                          "Report",
                                          style: TextStyle(fontSize: 20),
                                        ),
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
                  job.title!,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextIcons(Icons.location_on_sharp, "${job.workLocation}"),
                    workTime
                        ? TextIcons(Icons.timelapse,
                            Stringhelper.formatText("${job.workingTime}", 200))
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
                  job.description!,
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
                Text(formatRequirement(job.requirement!)),
                SizedBox(
                  height: 25,
                ),
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
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ApplicationPage(
                                job: job,
                              )));
                    },
                    child: Text(
                      "Ứng tuyển ngay",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
              ],
            ),
          ),
        ));
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
    // Giới hạn 15 ký tự, thêm "..." nếu quá dài
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
