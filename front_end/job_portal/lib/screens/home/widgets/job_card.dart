import 'package:flutter/material.dart';
import 'package:job_portal/models/job.dart';
import 'package:job_portal/widgets/text_icons.dart';

class JobCard extends StatelessWidget {
  final Job job; //object
  final bool timeJob;
  const JobCard(this.job, {this.timeJob = false});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 280,
      // height: 270,
      padding: EdgeInsets.all(20),
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
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromRGBO(158, 158, 158, .2)),
                    child: Image(image: AssetImage(job.url)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    job.companyName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  )
                ],
              ),
              Icon(
                job.saved ? Icons.bookmark : Icons.bookmark_border_outlined,
                color: job.saved ? Color(0xFF43B1B7) : Colors.grey,
                size: 33,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            job.titleJob,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextIcons(Icons.location_on_sharp, job.location),
              timeJob ? TextIcons(Icons.timelapse, job.typeWork) : Container(),
            ],
          )
        ],
      ),
    );
  }
}
