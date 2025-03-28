import 'package:flutter/material.dart';
import 'package:job_portal/providers/user_provider.dart';
import 'package:provider/provider.dart';

class RadioList extends StatefulWidget {
  final TextEditingController //dùng quản lý văn bản nhập vào, lấy nội dung
      controller; //các biến cố định, không thay đổi trong vòng đời
  RadioList(this.controller);
  @override
  _RadioListState createState() => _RadioListState();
}

class _RadioListState extends State<RadioList> {
  final TextEditingController //dùng quản lý văn bản nhập vào, lấy nội dung
      _controller = TextEditingController();
  String _selectedValue =
      'Việc làm có dấu hiệu lừa đảo'; //các biến quản lý trạng thái của wiget, hiển thị UI
  bool visibleTextField = false;
  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RadioListTile(
          title: Text("Việc làm có dấu hiệu lừa đảo"),
          activeColor: Theme.of(context).primaryColor,
          value: 'Việc làm có dấu hiệu lừa đảo', //là giá trị của lựa chọn
          groupValue: _selectedValue, // biến kiểm tra radio nào đang được chọn
          onChanged: (value) {
            //onChanged sẽ lấy giá trị value bên trên
            setState(
              () {
                visibleTextField = false;
                _selectedValue = value!;
                widget.controller.text = _selectedValue;
              },
            );
          },
          contentPadding: EdgeInsets.zero,
          visualDensity: VisualDensity(
              horizontal: -4,
              vertical: -4), // Giảm khoảng cách giữa các RadioListTile
        ),
        RadioListTile(
          title: Text("Thông tin không chính xác"),
          activeColor: Theme.of(context).primaryColor,
          value: 'Thông tin không chính xác',
          groupValue: _selectedValue,
          onChanged: (value) {
            setState(
              () {
                visibleTextField = false;
                _selectedValue = value!;
                widget.controller.text = _selectedValue;
              },
            );
          },
          contentPadding: EdgeInsets.zero,
          visualDensity: VisualDensity(
              horizontal: -4,
              vertical: -4), // Giảm khoảng cách giữa các RadioListTile
        ),
        RadioListTile(
          title: Text("Lý do khác"),
          value: "Lý do khác",
          groupValue: _selectedValue,
          activeColor: Theme.of(context).primaryColor,
          contentPadding: EdgeInsets.zero,
          visualDensity: VisualDensity(horizontal: -4, vertical: -4),
          onChanged: (value) {
            setState(
              () {
                visibleTextField = true;
                _selectedValue = value!;
                // widget.controller.text = _selectedValue;
              },
            );
          },
        ),
        /* khi nhấn vào radio này sẽ hiển thị ra textfield,
         lấy dữ liệu từ textfield thu được gán vào cho _selectedValue, 
         sau đó gán dữ liệu này cho controller để đẩy vào wiget bên trên*/
        visibleTextField
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: TextField(
                  textInputAction: TextInputAction.done,
                  controller: _controller,
                  onChanged: (value) {
                    setState(() {
                      print(_controller.text);
                      widget.controller.text = _controller.text;
                    });
                  },
                  minLines: 4, // Tăng số dòng tối thiểu (chiều cao tăng)
                  maxLines: 4, // Giới hạn số dòng tối đa
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 1),
                    ),
                    // hintText: "Nhập lý do khác của bạn",
                    hintText: "Nhập lý do khác của bạn",
                    hintStyle: TextStyle(
                        color: const Color.fromRGBO(158, 158, 158, .9),
                        fontSize: 15),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
