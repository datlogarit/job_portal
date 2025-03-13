import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TestJson extends StatefulWidget {
  const TestJson({super.key});

  @override
  State<TestJson> createState() => _TestJsonState();
}

class _TestJsonState extends State<TestJson> {
  Dio dio = Dio();
  var jsonList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  void getdata() async {
    try {
      Response response = await dio.get("http://10.0.2.2:8088/api/v1/category");
      // print(respon.data);
      if (response.statusCode == 200) {
        setState(() {
          this.jsonList = response.data as List;
        });
      } else
        print(response.statusCode);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.grey,
            child: ListTile(
              title: Text(jsonList[index]['name']),
            ),
          );
        },
        itemCount: jsonList == null ? 0 : jsonList.length,
      ),
    );
  }
}
