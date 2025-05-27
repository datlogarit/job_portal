import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_portal/models/job_model.dart';
import 'package:job_portal/providers/application_provider.dart';
import 'package:job_portal/providers/interaction_provider.dart';
import 'package:job_portal/providers/merged_interaction_provider.dart';
import 'package:job_portal/providers/user_provider.dart';
import 'package:job_portal/repositories/interaction_repository.dart';
import 'package:job_portal/screens/home/widgets/detailpage.dart';
import 'package:job_portal/screens/home/widgets/job_card.dart';
import 'package:job_portal/screens/home/widgets/job_detail2.dart';
import 'package:provider/provider.dart';

class JobInteractionPage extends StatefulWidget {
  final interactionRepo = InteractionRepository();
  final List<String> tagList = [
    'Applied',
    'Saved',
    'Read',
    'Accepted',
    'Rejected'
  ];
  JobInteractionPage({super.key});

  @override
  State<JobInteractionPage> createState() => _JobInteractionPageState();
}

class _JobInteractionPageState extends State<JobInteractionPage> {
  int selected = 0;
  List<Job?> jobFilted = [];
  //Gán lại giá trị cho chuỗi này mỗi khi thay đổi selected
  @override
  @override
  void initState() {
    super.initState();
    final userProvider = context.read<UserProvider>();
    final mergedIneractionProvider = context.read<MergedInteractionProvider>();

    mergedIneractionProvider.getAllInteraction(userProvider.user.id!).then((_) {
      setState(() {
        jobFilted = mergedIneractionProvider.allInteraction
            .where((application) => application.statusApply != null)
            .map((application) => application.jobId)
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mergedIneractionProvider = context.watch<MergedInteractionProvider>();
    final userProvider = context.watch<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, //ẩn nút back khi đi từ trang detail
        title: Text(
          "My job",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(67, 177, 183, .8),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 43,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) => GestureDetector(
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                          decoration: BoxDecoration(
                              color: selected == index
                                  ? Color.fromRGBO(67, 177, 183, .3)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: selected == index
                                    ? Color.fromRGBO(67, 177, 183, 1)
                                    : Color.fromRGBO(67, 177, 183, .3),
                              )),
                          child: Text(
                            widget.tagList[index],
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            selected = index;
                            print("selected = $selected");
                            if (selected == 0) {
                              jobFilted = mergedIneractionProvider
                                  .allInteraction
                                  .where((application) =>
                                      application.statusApply !=
                                      null) // lọc trước
                                  .map((application) =>
                                      application.jobId) // rồi mới lấy jobId
                                  .toList();
                            } else if (selected == 1) {
                              jobFilted = mergedIneractionProvider
                                  .allInteraction
                                  .where((application) =>
                                      application.isSave == 1) // lọc trước
                                  .map((application) =>
                                      application.jobId) // rồi mới lấy jobId
                                  .toList();
                            } else if (selected == 2) {
                              jobFilted = mergedIneractionProvider
                                  .allInteraction
                                  .where((application) =>
                                      application.isRead == 1) // lọc trước
                                  .map((application) =>
                                      application.jobId) // rồi mới lấy jobId
                                  .toList();
                            } else if (selected == 3) {
                              jobFilted = mergedIneractionProvider
                                  .allInteraction
                                  .where((application) =>
                                      application.statusApply ==
                                      "Approved") // lọc trước
                                  .map((application) =>
                                      application.jobId) // rồi mới lấy jobId
                                  .toList();
                            } else if (selected == 4) {
                              jobFilted = mergedIneractionProvider
                                  .allInteraction
                                  .where((application) =>
                                      application.statusApply ==
                                      "Rejected") // lọc trước
                                  .map((application) =>
                                      application.jobId) // rồi mới lấy jobId
                                  .toList();
                            }
                          });
                        },
                      ),
                  separatorBuilder: (_, index) => SizedBox(
                        width: 15,
                      ),
                  itemCount: widget.tagList.length),
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 1,
            color: const Color.fromRGBO(158, 158, 158, .5),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 520,
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => JobDetailPage(
                                  job: jobFilted[index]!,
                                )));
                        //gửi thông tin ở đây
                        bool result = await widget.interactionRepo.updateRead(
                            userProvider.user.id!, jobFilted[index]!.id!);
                        result
                            ? Fluttertoast.showToast(msg: "thanh cong")
                            : Fluttertoast.showToast(msg: "that bai");
                      },
                      //lấy danh sách job tìm kiếm ở đây. nếu có thì truyền vào cho job card
                      child: JobCard(
                        job: jobFilted[index]!,
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
          )
        ],
      ),
    );
  }
}
