import 'package:flutter/material.dart';
import 'package:job_portal/models/job.dart';

class JobCard extends StatelessWidget {
  final Job job; //object
  const JobCard(this.job);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 280,
      // height: 270,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromRGBO(244, 67, 54, .1),
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
                    width: 40,
                    height: 40,
                    padding: EdgeInsets.all(2),
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
                size: 35,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            job.titleJob,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
