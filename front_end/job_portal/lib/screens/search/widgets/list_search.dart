import 'package:flutter/material.dart';
import 'package:job_portal/models/job.dart';
import 'package:job_portal/screens/home/widgets/job_card.dart';
import 'package:job_portal/screens/home/widgets/job_detail.dart';

class ListSearch extends StatelessWidget {
  final List<Job> jobList = Job.generateJobs();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 480,
      margin: EdgeInsets.symmetric(horizontal: 22),
      child: ListView.separated(
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () => {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => JobDetail(jobList[index]))
                },
                child: JobCard(
                  jobList[index],
                  timeJob: true,
                ),
              ),
          separatorBuilder: (_, index) => SizedBox(
                height: 15,
              ),
          itemCount: jobList.length),
    );
  }
}
