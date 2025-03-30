import 'package:flutter/material.dart';
import 'package:job_portal/models/noti_user_model.dart';

class TagListNotification extends StatefulWidget {
  Function(String) bindingValue;

  @override
  TagListNotification({super.key, required this.bindingValue});
  @override
  State<StatefulWidget> createState() {
    return _TagListNotificationState();
  }
}

class _TagListNotificationState extends State<TagListNotification> {
  final List<String> tagList = [
    'Tất cả',
    'Sắp hết hạn',
    'Thay đổi trạng thái ',
    'Phản hồi báo cáo',
    'Thông báo chung',
  ];
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 43,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => GestureDetector(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
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
                    tagList[index],
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                onTap: () {
                  setState(() {
                    selected = index;
                    if (selected == 0) {
                      String selectedCategory = tagList[selected];
                      widget.bindingValue(selectedCategory);
                    }
                    if (selected == 1) {
                      String selectedCategory = 'expired';
                      widget.bindingValue(selectedCategory);
                    }
                    if (selected == 2) {
                      String selectedCategory = 'status change';
                      widget.bindingValue(selectedCategory);
                    }
                    if (selected == 3) {
                      String selectedCategory = 'respon report';
                      widget.bindingValue(selectedCategory);
                    }
                    if (selected == 4) {
                      String selectedCategory = 'general notice';
                      widget.bindingValue(selectedCategory);
                    }
                    //bắn lên cho class cha (notificationCustom)
                  });
                },
              ),
          separatorBuilder: (_, index) => SizedBox(
                width: 15,
              ),
          itemCount: tagList.length),
    );
  }
}
