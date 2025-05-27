import 'package:flutter/material.dart';
import 'package:job_portal/helper.dart';
import 'package:job_portal/models/noti_user_model.dart';
import 'package:job_portal/providers/notification_provider.dart';
import 'package:job_portal/providers/user_provider.dart';
import 'package:job_portal/screens/notification/widget/tag_category_notification.dart';
import 'package:provider/provider.dart';

class CustomNotification extends StatefulWidget {
  const CustomNotification({super.key});
  @override
  State<CustomNotification> createState() => _CustomNotificationState();
}

class _CustomNotificationState extends State<CustomNotification> {
  String choosedCategory = 'All';
  @override
  void initState() {
    final userProvider = context.read<UserProvider>();
    super.initState();
    getNotificationByUser(userProvider.user.id!);
  }

  void getNotificationByUser(int id) async {
    await context.read<NotificationProvider>().getNotificationByUser(id);
  }

  void updateCategory(String category) {
    setState(() {
      choosedCategory = category;
    });
  }

  List<NotiUser> getFilteredNotifications(List<NotiUser> notiUser) {
    return notiUser.where((noti) {
      return choosedCategory == "All" ||
          noti.idNoti!.categoryNotification == choosedCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<NotiUser> allNotification =
        context.watch<NotificationProvider>().notiByUser;
    List<NotiUser> fiteredNotification =
        getFilteredNotifications(allNotification);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  color: Colors.black,
                ),
              ),
              Text(
                "Notification",
                style: TextStyle(
                  // fontFamily: "Roboto",
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  for (var notification in allNotification) {
                    context.read<NotificationProvider>().updateReadNotification(
                        notification.id!.idUser!, notification.id!.idNoti!);
                  }
                },
                //update tất cả các thông báo thành isRead == 1;

                child: Icon(
                  Icons.download_done_rounded,
                  size: 26,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: Colors.white),
      body: Column(
        children: [
          SizedBox(
            height: 4,
          ),
          Container(
            width: double.maxFinite,
            height: 1,
            color: const Color.fromRGBO(158, 158, 158, .4),
          ),
          SizedBox(
            height: 15,
          ),
          TagListNotification(
            bindingValue: updateCategory,
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            // height: 190,
            child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () async {
                        context
                            .read<NotificationProvider>()
                            .updateReadNotification(
                                allNotification[index].id!.idUser!,
                                allNotification[index].id!.idNoti!);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Container(
                            color: fiteredNotification[index].isRead == 0
                                ? Color.fromRGBO(179, 229, 252, .4)
                                : const Color.fromRGBO(158, 158, 158, .05),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    height: 65,
                                    width: 65,
                                    image: AssetImage(
                                        "assets/images/vietnamwork_avt.png"),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        // mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${fiteredNotification[index].idNoti!.title}", //${widget.fiteredNotification[index]["title"]}
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "${fiteredNotification[index].idNoti!.content}", //${widget.fiteredNotification[index]["content"]}
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(children: [
                                            Text(
                                              convertDate(
                                                  "${fiteredNotification[index].idNoti!.createdAt}"), //${widget.fiteredNotification[index]["content"]}
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              height: 8,
                                              width: 8,
                                              decoration: BoxDecoration(
                                                color: Colors.grey,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              capitalizeFirstLetter(
                                                  "${fiteredNotification[index].idNoti!.categoryNotification}"), //${widget.fiteredNotification[index]["content"]}
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ]),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                separatorBuilder: (_, index) => SizedBox(
                      height: 4,
                    ),
                itemCount: fiteredNotification.length),
          )
        ],
      ),
    );
  }
}
