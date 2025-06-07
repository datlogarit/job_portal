import 'package:flutter/material.dart';
import 'package:job_portal/providers/applicant_provider.dart';
import 'package:job_portal/providers/job_provider.dart';
import 'package:job_portal/repositories/interaction_repository.dart';
import 'package:job_portal/screens/home/widgets/detailpage.dart';
import 'package:job_portal/screens/home/widgets/job_card.dart';
import 'package:provider/provider.dart';

class ContentBasedJob extends StatelessWidget {
  ContentBasedJob({super.key});
  final interactionRepo = InteractionRepository();

  @override
  Widget build(BuildContext context) {
    final jobProvider = context.read<JobProvider>();
    final user = context.read<ApplicantProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 18),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          decoration: BoxDecoration(
              color: Color.fromRGBO(67, 177, 183, .3),
              borderRadius: BorderRadius.circular(10), //18
              border: Border.all(color: Color.fromRGBO(67, 177, 183, 1))),
          child: Text(
            "You may also like",
            style: TextStyle(fontSize: 17),
          ),
        ),
        Container(
          // // height: 175,
          // height: 450,
          // height: double.maxFinite,
          margin: EdgeInsets.symmetric(vertical: 28, horizontal: 20),
          child: ListView.separated(
            shrinkWrap: true, // ✅ fix lỗi layout khi không biết chiều cao
            physics:
                NeverScrollableScrollPhysics(), // tránh conflict cuộn nếu cần
            scrollDirection: Axis.vertical,
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
            separatorBuilder: (_, index) => SizedBox(height: 15),
            itemCount: jobProvider.recommendedJobs.length,
          ),
        )
      ],
    );
  }
}
