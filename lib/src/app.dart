
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:market_1/src/views/home.page.dart';
import 'dart:io' show Platform;

import 'package:market_1/src/views/login.page.dart';
import 'package:market_1/src/views/notification,page.dart';
import 'package:market_1/src/views/setting.page.dart';
import 'package:market_1/src/views/splashScreen.page.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {


  @override
  Future initState()  {
    super.initState();

  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MARKET',
      theme: ThemeData(primaryColor: Colors.blue, backgroundColor: Colors.white),
      routes: <String,WidgetBuilder>{
        // "/testAssignment_latest": (BuildContext context) => TestAssignmentLatestPage(),
        // "/testAssignment_history": (BuildContext context) => TestAssignmentHistoryPage(),
        // "/taTestCompany_detail": (BuildContext context) => TATestCompanyPage(),
        "/home": (BuildContext context) => HomePage(),
        "/setting": (BuildContext context) => SettingPage(),
        "/notification": (BuildContext context) => NotificationPage(),
        // "/about": (BuildContext context) => AboutPage(),
        // "/account": (BuildContext context) => AccountPage(),
        // "/changePassword": (BuildContext context) => ChangePasswordPage(),
        "/login": (BuildContext context) => LoginPage(),


      },
      home: SplashScreen( router: null,),
      //home: HomePage(),
    );
  }

}

class Message {
  final String title;
  final String body;

  const Message({
    @required this.title,
    @required this.body,
  });
}