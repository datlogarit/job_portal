import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/helper.dart';
import 'package:job_portal/models/job_model.dart';

import 'package:job_portal/widgets/save_icon.dart';
import 'package:job_portal/widgets/text_icons.dart';

class JobCard extends StatelessWidget {
//những dữ liệu mà liên quan đến khi khởi tạo đối tượng mới để đây
  final Job job; //object
  final companyNumChar;
  final titleNumChar;
  final bool timeJob;
  final bool salary;
  const JobCard(
      {super.key,
      required this.job,
      this.timeJob = false,
      this.salary = false,
      required this.companyNumChar,
      required this.titleNumChar});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 290,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        border: Border.all(
          color: const Color.fromRGBO(158, 158, 158, .5), // Đường viền mờ
          width: .5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color.fromRGBO(158, 158, 158, .2)),
                      child: CachedNetworkImage(
                        imageUrl: job.postedBy!.companyId!.urlAvt!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/vietnamwork_avt.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                          formatText(
                              job.postedBy!.companyId!.name!, companyNumChar),
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                          softWrap: true),
                    )
                  ],
                ),
              ),
              SaveIcon(
                job: job,
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 55,
            child: Text(
              formatText(job.title!, titleNumChar),
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextIcons(
                  Icons.location_on_sharp, formatLocation(job.workLocation!)),
              timeJob
                  ? TextIcons(Icons.timelapse, job.workingTime!)
                  : Container(),
              salary
                  ? TextIcons(Icons.monetization_on_outlined,
                      formatSalary(job.maxSalary))
                  : Container(),
            ],
          )
        ],
      ),
    );
  }
}
