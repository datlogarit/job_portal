import 'package:flutter/material.dart';
import 'package:job_portal/models/job_model.dart';
import 'package:job_portal/providers/category_provider.dart';
import 'package:job_portal/providers/job_provider.dart';
import 'package:job_portal/screens/home/widgets/job_card.dart';
import 'package:job_portal/screens/home/widgets/job_detail.dart';
import 'package:provider/provider.dart';

class ListSearch extends StatelessWidget {
  const ListSearch({super.key});
  @override
  Widget build(BuildContext context) {
    final categoryProvider = context.watch<CategoryProvider>();
    final jobProvider = context.watch<JobProvider>();

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
    if (jobProvider.jobsBySearch.isEmpty) {
      //nếu k có cv nào
      return Container(
        height: 450,
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
                  //lấy danh sách job tìm kiếm ở đây. nếu có thì truyền vào cho job card
                  child: JobCard(
                    job: jobProvider.jobs[index],
                    timeJob: false,
                    salary: true,
                    companyNumChar: 80,
                    titleNumChar: 200,
                  ),
                ),
            separatorBuilder: (_, index) => SizedBox(
                  height: 15,
                ),
            itemCount: jobProvider.jobs.length),
      );
    }
    return Container(
      height: 460,
      margin: EdgeInsets.symmetric(horizontal: 22),
      child: ListView.separated(
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () => {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => JobDetail(job: jobFilted[index]),
                  )
                },
                //lấy danh sách job tìm kiếm ở đây. nếu có thì truyền vào cho job card
                child: JobCard(
                  job: jobFilted[index],
                  timeJob: false,
                  salary: true,
                  companyNumChar: 80,
                  titleNumChar: 200,
                ),
              ),
          separatorBuilder: (_, index) => SizedBox(
                height: 15,
              ),
          itemCount: jobFilted.length),
    );
  }
}

// class _ListSearchState extends State<ListSearch> {

// }
