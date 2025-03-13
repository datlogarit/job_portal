import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:job_portal/providers/cateory_provider.dart';
import 'package:job_portal/screens/home/home.dart';
import 'package:job_portal/screens/start/login/login.dart';
import 'package:job_portal/screens/search/search.dart';
import 'package:job_portal/test_fetch_data.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CategoryProvider()
            ..getListCategory(), //..cascade notation (ký hiệu xếp tầng), dùng để khởi tạo nay phương thức khi class được gọi
        )
      ],
      child: MaterialApp(
        title: 'Job Portal App',
        theme: ThemeData(
          fontFamily: 'montserrat',
          primaryColor: Color(0xFF43B1B7),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Color(0xFFFED408),
          ),
        ),
        home: Login(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
