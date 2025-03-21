import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_portal/providers/job_provider.dart';
import 'package:provider/provider.dart';

class TestFetchData extends StatefulWidget {
  @override
  _TestFetchDataState createState() => _TestFetchDataState();
}

class _TestFetchDataState extends State<TestFetchData> {
  @override
  void initState() {
    super.initState();
    //Future.microtask giúp đảm bảo khởi chạy hàm khi widget được tạo
    Future.microtask(() => context.read<JobProvider>().getJobs());
    //context.read<JobProvider>().fetchJobs()); còn hàm này để đọc ngược lên ChangenotifierProvider gần nhất (ở đây là class main)
  }

  @override
  Widget build(BuildContext context) {
    final jobProvider = context.watch<JobProvider>();

    return Scaffold(
      appBar: AppBar(title: Text("Danh sách công việc")),
      body: jobProvider
              .isLoading //gọi đến hàm getter để lấy giá trị của isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemCount: jobProvider.jobs.length,
              itemBuilder: (context, index) {
                final job = jobProvider.jobs[index];
                return GestureDetector(
                  onTap: () {
                    Fluttertoast.showToast(
                      msg: "This is Center Short Toast",
                      // toastLength: Toast.LENGTH_SHORT,
                      // gravity: ToastGravity.CENTER,
                      // timeInSecForIosWeb: 1,
                      // backgroundColor: Colors.red,
                      // textColor: Colors.white,
                      // fontSize: 16.0,
                    );
                  },
                  child: ListTile(
                    title: Text("${job.title}"),
                    subtitle: Text("${job.position} - ${job.workLocation}"),
                    trailing: Text("${job.maxSalary} VND"),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  width: 200,
                  height: .5,
                  color: Colors.red,
                );
              },
            ),
    );
  }
}
