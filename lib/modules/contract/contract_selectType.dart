import 'package:flutter/material.dart';
import '../../configs/themes/app_colors.dart';
import '../../modules/contract/contract_selectMarket_1.dart';
import '../../modules/contract/contract_selectMarket_2.dart';
import 'package:page_transition/page_transition.dart';

class ContractSelectTypeScreen extends StatefulWidget {
  @override
  _ContractSelectTypeScreenState createState() =>
      _ContractSelectTypeScreenState();
}

class _ContractSelectTypeScreenState extends State<ContractSelectTypeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: AppColors.blue_w500,
          title: Text(
            'Hợp đồng',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              fontFamily: "Calibre-Semibold",
              letterSpacing: 1.0,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[],
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
              SizedBox(
                height: 15,
              ),
          Card(
              elevation: 3.0,
              margin: new EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
              child: Container(
                  child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                leading: Icon(
                  Icons.assignment_rounded,
                  color: Colors.green,
                  size: 30.0,
                ),
                title: Text(
                  "Hợp đồng thương nhân",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ), //element['group'] group name get
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child:
                        ContractSelectMarket_1Screen()),
                  );
                },
              ))),
          Card(
              elevation: 3.0,
              margin: new EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
              child: Container(
                  child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                leading: Icon(
                  Icons.assignment_rounded,
                  color: Colors.green,
                  size: 30.0,
                ),
                title: Text(
                  "Hợp đồng thầu chợ",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ), //element['group'] group name get
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child:
                        ContractSelectMarket_2Screen()),
                  );
                },
              )))
        ])));
  }
}

class LineData extends StatelessWidget {
  LineData({this.title, this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: <TextSpan>[
      TextSpan(
          text: title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w300,
          )),
      TextSpan(
          text: value,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w300,
          )),
    ]));
  }
}
