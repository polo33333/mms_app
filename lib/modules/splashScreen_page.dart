import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mms/configs/themes/app_colors.dart';
import 'package:mms/helpers/apihelper.dart';
import 'package:mms/provider/genneralInfo_provider.dart';
import '../widgets/colorLoader.dart';

import '../helpers/Auth_helper.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  final String router;
  SplashScreen({Key key, @required this.router}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthRepos _auth = new AuthRepos();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _getGenneralInfo() async {
    var provider = Provider.of<GenneralInfoProvider>(context, listen: false);
    var postsResponse = await APIHelper.getGenneralInfo();
    if (postsResponse.isSuccessful) {
      if (postsResponse.data != null) {
        provider.setGenneralInfo(postsResponse.data, notify: false);
      } else {
        //provider.setShouldRefresh(false);
      }
    } else {
      //_showSnackbar(postsResponse.message);
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _auth.checkIsAuthenticated().then((result) {
        //print("sp" + result.toString());
        if (result == true) {
          _getGenneralInfo();
          if (widget.router != null) {
            Timer(Duration(milliseconds: 2500), () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  widget.router, (Route<dynamic> route) => false);
            });
          } else {

            Timer(Duration(seconds: 2), () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/home', (Route<dynamic> route) => false);
            });

          }
        } else
          Timer(Duration(seconds: 2), () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/login', (Route<dynamic> route) => false);
          });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.white,
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            ColorLoader(
              radius: 30.0,
              dotRadius: 8.0,
            ),
          ]),
        ),
      ),
    );
  }
}