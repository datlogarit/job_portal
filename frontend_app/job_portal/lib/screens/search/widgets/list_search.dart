import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_portal/models/job_model.dart';
import 'package:job_portal/providers/applicant_provider.dart';
import 'package:job_portal/providers/category_provider.dart';
import 'package:job_portal/providers/job_provider.dart';
// import 'package:job_portal/providers/user_provider.dart';
import 'package:job_portal/repositories/interaction_repository.dart';
import 'package:job_portal/screens/home/widgets/job_card.dart';
import 'package:job_portal/screens/home/widgets/detailpage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListSearch extends StatelessWidget {
  final interectionRepo = InteractionRepository();
  ListSearch({super.key});
  @override
  Widget build(BuildContext context) {
    final categoryProvider = context.watch<CategoryProvider>();
    final jobProvider = context.watch<JobProvider>();
    final userProvider = context.watch<ApplicantProvider>();
    List<Job> getFilterJob(List<Job> allJob) {
      return allJob
          .where((job) =>
              categoryProvider.idCategoryChoose == "Tất cả" ||
              job.categoryId!.name == (categoryProvider.idCategoryChoose))
          .toList();
    }

    print("UI - cateoryIdChoosed: ${categoryProvider.idCategoryChoose}");
    List<Job> jobFilted = getFilterJob(jobProvider.jobsBySearch);
    print("length of jobFilted: ${jobFilted.length}");
    if (jobProvider.isLoading) {
      return Center(child: CircularProgressIndicator()); // 🔄 Đang tải dữ liệu
    }
    Widget jobResult() {
      return jobFilted.isEmpty
          ? Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  SvgPicture.asset(
                    "assets/images/curiosity search-bro.svg",
                    height: 320,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "No job in this field",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )
                ],
              ),
            )
          : ListView.separated(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => GestureDetector(
                    onTap: () async {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => JobDetailPage(
                                job: jobFilted[index],
                              )));
                      //gửi thông tin ở đây
                      bool result = await interectionRepo.updateRead(
                          userProvider.applicant.id!, jobFilted[index].id!);
                      result
                          ? Fluttertoast.showToast(msg: "thanh cong")
                          : Fluttertoast.showToast(msg: "that bai");
                    },
                    //lấy danh sách job tìm kiếm ở đây. nếu có thì truyền vào cho job card
                    child: JobCard(
                      job: jobFilted[index],
                      timeJob: false,
                      salary: true,
                      companyNumChar: 80,
                      titleNumChar: 100,
                    ),
                  ),
              separatorBuilder: (_, index) => SizedBox(
                    height: 15,
                  ),
              itemCount: jobFilted.length);
    }

    return Container(
        height: 450,
        margin: EdgeInsets.symmetric(horizontal: 22),
        child: jobProvider.jobsBySearch.isEmpty
            ? Center(
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/images/Job hunt-cuate.svg",
                      height: 340,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Search job here",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )
                  ],
                ),
              )
            : jobResult());
  }
}
