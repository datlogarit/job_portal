import 'package:flutter/material.dart';
import 'package:job_portal/models/job.dart';
import 'package:job_portal/screens/home/widgets/job_card.dart';

class JobList extends StatelessWidget {
  final List<Job> jobList = Job.generateJobs();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        height: 160,
        margin: EdgeInsets.symmetric(vertical: 28, horizontal: 28),
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => JobCard(jobList[index]),
            separatorBuilder: (_, index) => SizedBox(
                  width: 20,
                ),
            itemCount: jobList.length));
  }
}
