import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SaveIcon extends StatefulWidget {
  const SaveIcon({super.key});

  @override
  State<SaveIcon> createState() => _SaveIconState();
}

class _SaveIconState extends State<SaveIcon> {
  bool save = false;
  void toggleSave() {
    setState(() {
      save = !save;
    });

    Fluttertoast.showToast(
      msg: save ? "Lưu tin thành công" : "Đã bỏ lưu tin",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Theme.of(context).primaryColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        save ? Icons.bookmark : Icons.bookmark_outline,
        color: Theme.of(context).primaryColor,
        size: 32,
      ),
      onTap: () {
        toggleSave();
      },
    );
  }
}
