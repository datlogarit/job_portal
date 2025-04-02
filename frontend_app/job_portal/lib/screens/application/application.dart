import 'package:flutter/material.dart';
import 'package:job_portal/providers/application_provider.dart';
import 'package:job_portal/providers/job_provider.dart';
import 'package:job_portal/screens/home/widgets/job_card.dart';
import 'package:job_portal/screens/home/widgets/job_detail.dart';
import 'package:provider/provider.dart';

class ApplicationPage extends StatefulWidget {
  final List<String> tagList = [
    'Đã ứng tuyển',
    'Đã lưu',
    'Đã xem',
    'Được chấp nhận',
    'Đã từ chối'
  ];
  ApplicationPage({super.key});

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  int selected = 0;
  @override
  void initState() {
    super.initState();
    context.read<ApplicationProvider>();
  }

  @override
  Widget build(BuildContext context) {
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
                Icons.close_rounded,
                size: 26,
                color: Colors.white,
              ),
            ),
            Text(
              "Việc của tôi",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(width: 16)
          ],
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
          )
        ],
      ),
    );
  }
}
