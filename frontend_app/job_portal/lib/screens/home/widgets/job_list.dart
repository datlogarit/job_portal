import 'package:flutter/material.dart';
import 'package:job_portal/providers/job_provider.dart';
import 'package:job_portal/screens/home/widgets/job_card.dart';
import 'package:job_portal/screens/home/widgets/job_detail.dart';
import 'package:provider/provider.dart';

class JobList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final jobProvider = context.watch<JobProvider>();

    if (jobProvider.jobs.isEmpty) {
      return Center(child: Text("Không có công việc nào.")); // ⚠ Không có job
    }
    if (jobProvider.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Container(
      height: 170,
      // height: 180,
      margin: EdgeInsets.symmetric(vertical: 28, horizontal: 28),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            showModalBottomSheet(
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              context: context,
              builder: (context) => JobDetail(job: jobProvider.jobs[index]),
            );
          },
          child: JobCard(
            job: jobProvider.jobs[index],
            timeJob: false,
            salary: true,
            companyNumChar: 14,
            titleNumChar: 50,
          ),
        ),
        separatorBuilder: (_, index) => SizedBox(width: 20),
        itemCount: jobProvider.jobs.length,
      ),
    );
    //   },
    // );
  }
}
