import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/models/job_model.dart';
import 'package:job_portal/widgets/save_icon.dart';
import 'package:job_portal/widgets/text_icons.dart';

class JobCard extends StatelessWidget {
  String formatText(String title, int character) {
    // Viết hoa chữ cái đầu mỗi từ
    String capitalizedTitle = title
        .split(' ')
        .map((word) => word.isNotEmpty
            ? word[0].toUpperCase() + word.substring(1).toLowerCase()
            : '')
        .join(' ');

    // Giới hạn 15 ký tự, thêm "..." nếu quá dài
    return capitalizedTitle.length > character
        ? "${capitalizedTitle.substring(0, character)}..."
        : capitalizedTitle;
  }

  String formatLocation(String location) {
    return location.contains(',')
        ? location
            .split(',')[0]
            .trim() // Lấy phần trước dấu ',' và loại bỏ khoảng trắng
        : location.trim(); // Nếu không có dấu ',', giữ nguyên
  }

  String formatSalary(int? salary) {
    String salaryStr = salary.toString();
    List<String> parts = [];

    while (salaryStr.length > 3) {
      parts.insert(0, salaryStr.substring(salaryStr.length - 3));
      salaryStr = salaryStr.substring(0, salaryStr.length - 3);
    }

    parts.insert(0, salaryStr);
    return parts.join('.');
  }

  final Job job; //object
  final bool timeJob;
  final bool salary;
  const JobCard({required this.job, this.timeJob = false, this.salary = false});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 280,

      // height: 270,
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        border: Border.all(
          color: const Color.fromRGBO(158, 158, 158, .5), // Đường viền mờ
          width: .5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromRGBO(158, 158, 158, .2)),
                    child:
                        //  Image(image: AssetImage(job.url)),
                        CachedNetworkImage(
                      imageUrl: "${job.postedBy!.companyId!.urlAvt}",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    formatText("${job.postedBy!.companyId!.name}", 16),
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  )
                ],
              ),
              // Icon(
              //   // job.saved
              //   true ? Icons.bookmark : Icons.bookmark_border_outlined,
              //   color:
              //       // job.saved
              //       true ? Color(0xFF43B1B7) : Colors.grey,
              //   size: 33,

              // ),
              SaveIcon()
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            formatText("${job.title}", 50),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextIcons(Icons.location_on_sharp,
                  formatLocation("${job.workLocation}")),

              // SizedBox(
              //   width: 10,
              // ),

              timeJob
                  ? TextIcons(Icons.timelapse, "${job.workingTime}")
                  : Container(),
              salary
                  ? TextIcons(Icons.monetization_on_outlined,
                      formatSalary(job.maxSalary))
                  : Container(),
            ],
          )
        ],
      ),
    );
  }
}
