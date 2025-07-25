import 'package:flutter/material.dart';
import 'package:job_portal/providers/job_provider.dart';
import 'package:job_portal/providers/applicant_provider.dart';
import 'package:job_portal/repositories/interaction_repository.dart';
import 'package:job_portal/screens/home/widgets/job_card.dart';
import 'package:job_portal/screens/home/widgets/detailpage.dart';
import 'package:provider/provider.dart';

class JobList extends StatelessWidget {
  final interactionRepo = InteractionRepository();
// jobRepo.markJobAsRead("123", "456");

  @override
  Widget build(BuildContext context) {
    final jobProvider = context.watch<JobProvider>();
    final user = context.watch<ApplicantProvider>();
    if (jobProvider.isLoadingRcmJob) {
      return Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (jobProvider.recommendedJobs.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Center(
            child: Text(
          "There are no jobs to display.",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )),
      ); // Không có job
    }

    return Container(
      // height: 175,
      height: 190,
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () async {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => JobDetailPage(
                      job: jobProvider.recommendedJobs[index],
                    )));
            //gửi thông tin ở đây
            bool result = await interactionRepo.updateRead(
                user.applicant.userId!.id!,
                jobProvider.recommendedJobs[index].id!);
            // result
            //     ? Fluttertoast.showToast(msg: "thanh cong")
            //     : Fluttertoast.showToast(msg: "that bai");
          },
          child: JobCard(
            job: jobProvider.recommendedJobs[index],
            timeJob: false,
            salary: true,
            companyNumChar: 32,
            titleNumChar: 50,
          ),
        ),
        separatorBuilder: (_, index) => SizedBox(width: 20),
        itemCount: jobProvider.recommendedJobs.length,
      ),
    );
    //   },
    // );
  }
}
