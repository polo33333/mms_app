
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mms/modules/home_page.dart';
import 'package:mms/provider/contract_provider.dart';
import 'package:mms/provider/genneralInfo_provider.dart';
import 'package:mms/provider/householdBusiness_provider.dart';
import 'package:mms/provider/marketDetail_provider.dart';
import 'package:mms/provider/productGroup_provider.dart';
import 'package:mms/provider/region_provider.dart';
import 'package:provider/provider.dart';
import 'package:mms/provider/market_provider.dart';
import 'modules/auth/login_page.dart';
import 'configs/themes/app_colors.dart';
import 'modules/notification_page.dart';
import 'modules/setting_page.dart';
import 'modules/splashScreen_page.dart';
import 'provider/contract_2_provider.dart';
import 'provider/kiot_provider.dart';

void main() {

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: Container(
        color: Colors.red,
        alignment: Alignment.center,
        child: const Text(
          'Something went wrong!',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  };
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MarketProvider()),
        ChangeNotifierProvider(create: (_) => MarketDetailProvider()),
        ChangeNotifierProvider(create: (_) => ContractProvider()),
        ChangeNotifierProvider(create: (_) => HouseholdBusinessProvider()),
        ChangeNotifierProvider(create: (_) => KiotProvider()),
        ChangeNotifierProvider(create: (_) => RegionProvider()),
        ChangeNotifierProvider(create: (_) => ProductGroupProvider()),
        ChangeNotifierProvider(create: (_) => Contract_2_Provider()),
        ChangeNotifierProvider(create: (_) => GenneralInfoProvider()),


      ],
      child: MyApp(),
    ),
  );
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent,
  // ));
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIOverlays([
  //   SystemUiOverlay.bottom, //This line is used for showing the bottom bar
  // ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MMS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SourceSansPro',
        primaryColor: AppColors.blue_w500,
      ),
      routes: <String,WidgetBuilder>{
        "/home": (BuildContext context) => HomeScreen(),
        "/setting": (BuildContext context) => SettingPage(),
        "/notification": (BuildContext context) => NotificationPage(),
        // "/about": (BuildContext context) => AboutPage(),
        // "/account": (BuildContext context) => AccountPage(),
        // "/changePassword": (BuildContext context) => ChangePasswordPage(),
        "/login": (BuildContext context) => LoginPage(),
      },
      home: SplashScreen(),
    );
  }
}



