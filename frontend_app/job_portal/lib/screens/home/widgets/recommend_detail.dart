import 'package:flutter/material.dart';
import 'package:job_portal/providers/applicant_provider.dart';
import 'package:job_portal/providers/job_provider.dart';
import 'package:job_portal/screens/home/widgets/detailpage.dart';
import 'package:job_portal/screens/home/widgets/job_card.dart';
import 'package:provider/provider.dart';

class RecommendDetail extends StatefulWidget {
  const RecommendDetail({super.key});

  @override
  State<RecommendDetail> createState() => _RecommendDetailState();
}

class _RecommendDetailState extends State<RecommendDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final jobProvider = context.read<JobProvider>();
      final userProvider = context.read<ApplicantProvider>();
      await jobProvider.getRecommendedJobsSplit(
        userProvider.applicant.id!,
        userProvider.applicant.desiredPosition!,
        userProvider.applicant.field!.id!,
        userProvider.applicant.desiredLocation!,
      );
      setState(() {
        isLoading = false;
      });
    });
  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    final jobProvider = context.watch<JobProvider>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, //ẩn nút back khi đi từ trang detail
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back,
                size: 26,
                color: Colors.white,
              ),
            ),
            Text(
              "Recommended for you",
              style: TextStyle(
                // fontFamily: "Roboto",
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(width: 20)
          ],
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(67, 177, 183, .8),
      ),
      // body:
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "May be interested",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    // color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "(${jobProvider.recommendedJobsSplit.numJobContentBased})",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    // color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => JobDetailPage(
                      job: jobProvider.recommendedJobsSplit.jobListCb![index],
                    ),
                  ));
                },
                child: JobCard(
                  job: jobProvider.recommendedJobsSplit.jobListCb![index],
                  companyNumChar: 30,
                  titleNumChar: 30,
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(height: 15),
              itemCount: jobProvider.recommendedJobsSplit.numJobContentBased!,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 38),
              height: 1,
              width: double.infinity,
              color: Theme.of(context).primaryColor,
            ),
            Row(
              children: [
                Text(
                  "Other people also like",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    // color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "(${jobProvider.recommendedJobsSplit.numJobCollaborativeFiltering})",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    // color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            ListView.separated(
              shrinkWrap: true, //listview tự động chiếm không gian vừa đủ
              physics:
                  NeverScrollableScrollPhysics(), //tắt khả năng cuộn của listview
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => JobDetailPage(
                      job: jobProvider.recommendedJobsSplit.jobsListCf![index],
                    ),
                  ));
                },
                child: JobCard(
                  job: jobProvider.recommendedJobsSplit.jobsListCf![index],
                  companyNumChar: 30,
                  titleNumChar: 30,
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(height: 15),
              itemCount: jobProvider
                  .recommendedJobsSplit.numJobCollaborativeFiltering!,
            ),
          ],
        ),
      ),
    );
  }
}
