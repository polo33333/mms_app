import 'dart:io';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Text('MMS',
              style: TextStyle(
                height: 2,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            Text('Chào mừng bạn đã đến với MMS',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            Spacer(),
            Image.asset(
              'assets/images/splash_1.png',
              height: 270,
              width: 280,
            ),
            Spacer(),
            Text('Quản lý chợ - Kinh tế',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                )),
            SizedBox(
              height: 16,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Text(
                  "Hỗ trợ quản lý - tra cứu thông tin tổng quát của chợ, hợp đồng, điểm kinh doanh, thương nhân...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 2,
                    fontSize: 14,
                  )),
            ),
            Spacer(),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        child: InkWell(
          onTap: () => {
          Navigator.of(context).pushNamedAndRemoveUntil(
          '/selectdistrict', (Route<dynamic> route) => false)
          },
          child: Container(
            height: Platform.isIOS ? 70 : 68,
            color: Colors.blue,
            alignment: Alignment.center,
            child: Text(
              "BẮT ĐẦU",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
