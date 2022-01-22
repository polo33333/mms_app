import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:market_1/src/views/address_search.page.dart';
import 'package:market_1/src/views/businessman_search.page.dart';
import 'package:market_1/src/views/contract_search.page.dart';
import 'package:market_1/src/views/general_search.page.dart';
import 'package:market_1/src/views/notification,page.dart';
import 'package:market_1/src/views/setting.page.dart';
import 'package:page_transition/page_transition.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;



  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.green, //or set color with: Color(0xFF0000FF)
    ));
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight = MediaQuery.of(context).size.height;
    //final double bottomHeight = 50;
    final double bodyHeight =
        screenHeight - statusBarHeight - 120;
    final double widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
            backgroundColor:  Colors.green,
            automaticallyImplyLeading: false,
            title: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 5),
              child: Column(
                children: <Widget>[
                  Text(
                    'MARKET',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Hệ thống quản lý chợ',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )),
      ),
      body: Column(children: <Widget>[
        Container(
          color: Colors.white,
          height: bodyHeight,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 1.0),
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: (2*widthScreen+10)/(2*bodyHeight),
              padding: EdgeInsets.all(3),
              children: <Widget>[
                makeDashboardItem(
                    "Tra cứu thông tin chung chợ", Icons.info_outline, Colors.pink, GeneralPage()),
                makeDashboardItem(
                    "Tra cứu điểm kinh doanh", Icons.place, Colors.green, AddressPage()),
                makeDashboardItem(
                    "Tra cứu thương nhân", Icons.person_outline, Colors.red, BusinessManPage()),
                makeDashboardItem(
                    "Tra cứu hợp đồng", Icons.contact_page, Colors.deepPurple, ContractPage()),
                // makeDashboardItem(
                //     "Cài đặt", Icons.settings, Colors.blueGrey, SettingPage()),
                // makeDashboardItem(
                //     "Comming soon", Icons.add, Colors.indigo,null),
              ],
            ),
          ),
        ),


      ]),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Trang chủ"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text("Thông báo"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text("Cài đặt"),
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, "/home");
              break;
            case 1:
              Navigator.pushNamed(context, "/notification");
              break;
            case 2:
              Navigator.pushNamed(context, "/setting");
              break;
          }
        }
      )

    );

  }

  Card makeDashboardItem(
      String title, IconData icon, Color colorBox, Widget router) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double bodyHeight =  screenHeight - statusBarHeight - 60;
    return Card(
        elevation: 1.0,
        margin: new EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: colorBox,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: new InkWell(
            onTap: () {
              if(router !=null)
                Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: router));

            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: (1/10)*bodyHeight ),
                Center(
                    child: Icon(
                      icon,
                      size: 40.0,
                      color: Colors.white,
                    )),
                SizedBox(height:(1/25)*bodyHeight),
                new Center(
                  child: new Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 1.0, 10.0, 1.0),
                    child: new Text(title,
                      style: new TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w700)),
                ),
            ),
          ]),
        )
    )
    );
  }
}