import 'package:flutter/material.dart';
import 'package:job_portal/helper.dart';
import 'package:job_portal/providers/applicant_provider.dart';
import 'package:job_portal/providers/job_provider.dart';
import 'package:job_portal/providers/notification_provider.dart';
import 'package:job_portal/screens/notification/notification.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatefulWidget {
  @override
  _HomeAppBarState createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  Future<void> _refreshData() async {
    final userProvider = context.read<ApplicantProvider>();
    final jobProvider = context.read<JobProvider>();
    final notiProvider = context.read<NotificationProvider>();
    await jobProvider.getRecommendedJobs(
        userProvider.applicant.id!,
        userProvider.applicant.desiredPosition!,
        userProvider.applicant.field!.id!,
        userProvider.applicant.desiredLocation!);
    await notiProvider.countNotificationUnread(userProvider.applicant.id!);
  }

  @override
  void initState() {
    super.initState();
    final userProvider = context.read<ApplicantProvider>();
    final jobProvider = context.read<JobProvider>();
    final notiProvider = context.read<NotificationProvider>();
    jobProvider.getRecommendedJobs(
        userProvider.applicant.id!,
        userProvider.applicant.desiredPosition!,
        userProvider.applicant.field!.id!,
        userProvider.applicant.desiredLocation!);
    notiProvider.countNotificationUnread(userProvider.applicant.id!);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<ApplicantProvider>();
    final jobProvider = context.read<JobProvider>();
    final notiProvider = context.watch<NotificationProvider>();
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome home,",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 15),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    formatText(userProvider.applicant.userId!.name!, 25),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    // transform: Matrix4.rotationY(10),
                    padding: EdgeInsets.only(right: 1),
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CustomNotification()));
                          },
                          child: Icon(
                            Icons.notifications_none_outlined,
                            size: 32,
                            color: Colors.grey,
                          ),
                        ),
                        notiProvider.totalUnreadNoti == 0
                            ? Container()
                            : Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10)),
                                ))
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 18,
                  ),
                  Container(
                    width: 50, // radius * 2 + border (ví dụ: 25 * 2 + 4)
                    height: 50,

                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 1.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                          'http://10.0.2.2:8088/api/v1/user/images/${userProvider.applicant.userId!.urlAvatar}',
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
