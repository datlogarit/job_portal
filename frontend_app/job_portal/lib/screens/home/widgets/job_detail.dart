import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/models/job_model.dart';
import 'package:job_portal/screens/report/report.dart';
import 'package:job_portal/widgets/text_icons.dart';

class JobDetail extends StatelessWidget {
  final Job job;
  final bool workTime;
  // final Application application;
  JobDetail({required this.job, this.workTime = true});

  String formatRequirement(String requirement) {
    return requirement
        .replaceAllMapped(RegExp(r"[●\•\-]"), (match) => "\n•")
        .trim();
  }

  @override
  Widget build(BuildContext context) {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 90,
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
                              imageUrl: "${job.postedBy!.companyId!.urlAvt}",
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: double.maxFinite,
                            child: Center(
                              child: Text(
                                "${job.postedBy!.companyId!.name}",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          true ? Icons.bookmark : Icons.bookmark_outline,
                          color: true
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                          size: 32,
                        ),
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
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Report()));
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
                  "${job.title}",
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
                        ? TextIcons(Icons.timelapse, "${job.workingTime}")
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
                  "${job.description}",
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
                Text(formatRequirement("${job.requirement}")),
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
                    onPressed: () {},
                    child: Text(
                      "Apply now",
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
