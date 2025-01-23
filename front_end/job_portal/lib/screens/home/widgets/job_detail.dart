import 'package:flutter/material.dart';
import 'package:job_portal/models/job.dart';
import 'package:job_portal/widgets/text_icons.dart';

class JobDetail extends StatelessWidget {
  final Job job;
  final bool workTime;
  JobDetail(this.job, {this.workTime = true});
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
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 45,
                          height: 45,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(158, 158, 158, .3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset(job.url),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          job.companyName,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          job.saved ? Icons.bookmark : Icons.bookmark_outline,
                          color: job.saved
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                          size: 32,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Icon(
                          Icons.more_horiz,
                          size: 30,
                          color: const Color.fromARGB(255, 28, 28, 28),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  job.titleJob,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextIcons(Icons.location_on_sharp, job.location),
                    workTime
                        ? TextIcons(Icons.timelapse, job.typeWork)
                        : Container(),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Requerement",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                ...job.requirement.map((e) => Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 5,
                            width: 5,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 320),
                              child: Text(
                                e,
                                style: TextStyle(
                                  wordSpacing: 2.5,
                                  height: 1.5,
                                ),
                              )),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 25,
                ),
                Container(
                  height: 50,
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
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
