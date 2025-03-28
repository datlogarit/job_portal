import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/models/job_model.dart';

import 'package:job_portal/widgets/save_icon.dart';
import 'package:job_portal/widgets/text_icons.dart';

class JobCard extends StatelessWidget {
//những dữ liệu mà liên quan đến khi khởi tạo đối tượng mới để đây
  final Job job; //object

  final bool timeJob;
  final bool salary;
  const JobCard({required this.job, this.timeJob = false, this.salary = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
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
                      imageUrl: job.postedBy!.companyId!.urlAvt!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    Stringhelper.formatText(job.postedBy!.companyId!.name!, 14),
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  )
                ],
              ),
              SaveIcon(
                job: job,
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            Stringhelper.formatText(job.title!, 50),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextIcons(Icons.location_on_sharp,
                  Stringhelper.formatLocation(job.workLocation!)),
              timeJob
                  ? TextIcons(Icons.timelapse, job.workingTime!)
                  : Container(),
              salary
                  ? TextIcons(Icons.monetization_on_outlined,
                      Stringhelper.formatSalary(job.maxSalary))
                  : Container(),
            ],
          )
        ],
      ),
    );
  }
}

class Stringhelper {
  static String formatText(String title, int character) {
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

  static String formatLocation(String location) {
    return location.contains(',')
        ? location
            .split(',')[0]
            .trim() // Lấy phần trước dấu ',' và loại bỏ khoảng trắng
        : location.trim(); // Nếu không có dấu ',', giữ nguyên
  }

  static String formatSalary(int? salary) {
    String salaryStr = salary.toString();
    List<String> parts = [];
    while (salaryStr.length > 3) {
      parts.insert(0, salaryStr.substring(salaryStr.length - 3));
      salaryStr = salaryStr.substring(0, salaryStr.length - 3);
    }
    parts.insert(0, salaryStr);
    return parts.join('.');
  }
}
