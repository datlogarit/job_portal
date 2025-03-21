import 'package:flutter/material.dart';
// import 'package:job_portal/models/job.dart';
import 'package:job_portal/providers/job_provider.dart';
import 'package:job_portal/screens/home/widgets/job_card.dart';
import 'package:job_portal/screens/home/widgets/job_detail.dart';
import 'package:provider/provider.dart';

class ListSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.microtask(() => context.read<JobProvider>().getJobs());

    // TODO: implement build
    return Consumer<JobProvider>(builder: (context, jobProvider, child) {
      if (jobProvider.isLoading) {
        return Center(
            child: CircularProgressIndicator()); // 🔄 Đang tải dữ liệu
      }
      if (jobProvider.jobs.isEmpty) {
        return Center(child: Text("Không có công việc nào.")); // ⚠ Không có job
      }
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
                      builder: (context) =>
                          JobDetail(job: jobProvider.jobs[index]),
                    )
                  },
                  child: JobCard(
                    job: jobProvider.jobs[index],
                    timeJob: false,
                    salary: true,
                  ),
                ),
            separatorBuilder: (_, index) => SizedBox(
                  height: 15,
                ),
            itemCount: jobProvider.jobs.length),
      );
    });
  }
}
