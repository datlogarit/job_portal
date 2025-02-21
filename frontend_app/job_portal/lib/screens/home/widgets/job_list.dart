import 'package:flutter/material.dart';
import 'package:job_portal/models/job.dart';
import 'package:job_portal/screens/home/widgets/job_card.dart';
import 'package:job_portal/screens/home/widgets/job_detail.dart';

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
                    timeJob: false,
                  ),
                ),
            separatorBuilder: (_, index) => SizedBox(
                  width: 20,
                ),
            itemCount: jobList.length));
  }
}
