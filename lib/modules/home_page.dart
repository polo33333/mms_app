import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import '../provider/genneralInfo_provider.dart';
import 'contract/contract_selectType.dart';
import 'householdBusiness/householdBusiness_selectMarket.dart';
import 'kiot/kiot_selectMarket.dart';
import 'market/market_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

final List<String> imgList = [
  'assets/images/cho-ben-thanh-1.jpg',
  'assets/images/cho-1.jpg',
  'assets/images/cho-2.jpg',
  'assets/images/cho-3.jpg',
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        // child: Text(
                        //   'No. ${imgList.indexOf(item)} image',
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 20.0,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  _getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var _userName = prefs.getString('USERNAME') ?? '';
    return _userName;
  }

  @override
  void initState() {
    super.initState();

    //_userName = _getUserName();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent, //or set color with: Color(0xFF0000FF)
    ));
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight = MediaQuery.of(context).size.height;
    //final double bottomHeight = 50;
    final double bodyHeight = screenHeight - statusBarHeight - 120;
    final double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: AppBar(
          backgroundColor: Colors.blue,
          title: Container(
              padding: EdgeInsets.all(5),
              child: Row(children: [
                Container(
                  child: Container(
                    width: 60,
                    height: 60,
                    color: Colors.transparent,
                    child: Image.asset('assets/images/img.png'),
                  ),
                  // CircleAvatar(
                  //   backgroundColor: Colors.blueAccent,
                  //   radius: 25.0,
                  //   child: Icon(
                  //     Icons.account_circle,
                  //     color: Colors.white,
                  //     size: 50,
                  //   ),
                  // ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Container(
                      //   child: Text(
                      //     "Xin chào",
                      //     style: TextStyle(
                      //       color: Colors.white.withOpacity(0.9),
                      //       fontWeight: FontWeight.w500,
                      //       fontSize: 14,
                      //     ),
                      //   ),
                      // ),
                      FutureBuilder<dynamic>(
                          future: _getUserName(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData)
                              return Container(
                                child: Text(
                                  "Welcome, " + snapshot.data,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                              );

                            return Container(
                              child: Text(
                                "Welcome",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ),
                            );
                          }),
                      // Container(
                      //   child: Text(''
                      //       ,
                      //     style: TextStyle(
                      //         color: Colors.white,
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 18),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ])),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
              child: CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 1,
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: false,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                ),
                items: imageSliders,
              ),
            ),
            Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: Text(
                  'Tổng quan',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                )),
            Consumer<GenneralInfoProvider>(
              builder: (_, provider, __) => Container(
                  margin: EdgeInsets.fromLTRB(15.0, 5, 15, 5),
                  height: 70.0,
                  child: new ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                          width: 120.0,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: EdgeInsets.fromLTRB(5.0, 0, 5, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                provider.genneralInfo == null
                                    ? '0'
                                    : provider.genneralInfo.marketNo.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                              ),
                              Text(
                                'Chợ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ],
                          )),
                      Container(
                          width: 120.0,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: EdgeInsets.fromLTRB(5.0, 0, 5, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                provider.genneralInfo == null
                                    ? '0'
                                    : provider.genneralInfo.kiotNo.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                              ),
                              Text(
                                'ĐKD',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ],
                          )),
                      Container(
                          width: 120.0,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: EdgeInsets.fromLTRB(5.0, 0, 5, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                provider.genneralInfo == null
                                    ? '0'
                                    : provider.genneralInfo.householdBusinessNo
                                        .toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                              ),
                              Text(
                                'Thương nhân',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ],
                          )),
                    ],
                  )),
            ),
            Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.fromLTRB(15, 5, 15, 0),
                child: Text(
                  'Danh mục',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                )),
            Container(
              color: Colors.white,
              height: bodyHeight / 5 * 3,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 1.0),
                margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio:
                      (2 * widthScreen + 60) / (1 * bodyHeight + 10),
                  padding: EdgeInsets.all(3),
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    makeDashboardItem("Thông tin chung", Icons.info_outline,
                        Colors.blue, MarketPage()),
                    makeDashboardItem("Điểm kinh doanh", Icons.place,
                        Colors.green, KiotSelectMarketScreen()),
                    makeDashboardItem("Thương nhân", Icons.person_outline,
                        Colors.red, HouseholdBusinessSelectMarketScreen()),
                    makeDashboardItem("Hợp đồng", Icons.assignment_rounded,
                        Colors.cyan, ContractSelectTypeScreen()),
                    // makeDashboardItem(
                    //     "Cài đặt", Icons.settings, Colors.blueGrey, SettingPage()),
                    // makeDashboardItem(
                    //     "Comming soon", Icons.add, Colors.indigo,null),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          //backgroundColor: Colors.white,
          elevation: 1,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              title: Text(
                "Trang chủ",
                style: TextStyle(
                  //fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.notifications,size: 30),
            //   title: Text("Thông báo"),
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings, size: 30),
              title: Text(
                "Cài đặt",
                style: TextStyle(
                  //fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            //_selectedIndex = index;
            switch (index) {
              case 0:
                {
                  if (_selectedIndex != 0)
                    Navigator.pushNamed(context, "/home");
                  break;
                }
              // case 1:
              //   Navigator.pushNamed(context, "/notification");
              //   break;
              case 1:
                Navigator.pushNamed(context, "/setting");
                break;
            }
          }),
    );
  }

  Widget makeDashboardItem(
      String title, IconData icon, Color colorBox, Widget router) {
    return Container(
      margin: EdgeInsets.all(8),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            color: colorBox,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.transparent,
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(),
              Container(
                //color: Colors.green,
                width: double.infinity,
                height: 40,
                padding: const EdgeInsets.all(8),
                child: Icon(
                  icon,
                  size: 50.0,
                  color: Colors.white,
                ),
              ),
              Container(
                //color: Colors.green,
                alignment: Alignment.center,
                width: double.infinity,
                height: 30,
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              )
            ],
          ),
        ),
        onTap: () {
          if (router != null)
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft, child: router));
        },
      ),
    );
  }
}
