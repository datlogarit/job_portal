import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:job_portal/providers/application_provider.dart';
import 'package:job_portal/providers/interaction_provider.dart';
import 'package:job_portal/providers/category_provider.dart';
import 'package:job_portal/providers/job_provider.dart';
import 'package:job_portal/providers/notification_provider.dart';
import 'package:job_portal/providers/user_provider.dart';
import 'package:job_portal/screens/start/login/login.dart';
import 'package:job_portal/test_diaglog_pretty.dart';
import 'package:job_portal/test_progess_tracker.dart';
import 'package:progress_tracker/progress_tracker.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // 🛠️ Khởi tạo Flutter bindings
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //hàm trả về 1 cây widget
    //khi state thay đổi thì sẽ gọi lại hàm build để vẽ lại giao diện
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          //giúp wiget lắng nghe sự thay đổi của dữ liệu
          create: (_) => JobProvider(), //tạo ra 1 instance của JobProvider
          // ..fetchJobs(), //..cascade notation (ký hiệu xếp tầng), dùng để khởi tạo nay phương thức khi class được gọi
        ),
        ChangeNotifierProvider(
            create: (_) => CategoryProvider()), //ở đây các instance là duy nhất
        ChangeNotifierProvider(create: (_) => InteractionProvider()),
        ChangeNotifierProvider(create: (_) => ApplicationProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider())
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
        home: TestProgessTracker(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
