import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:market_1/src/widgets/colorLoader.widget.dart';
// import 'package:pstms/src/repos/Auth.Repos.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final AuthRepos _auth = AuthRepos();
  final _formKey = GlobalKey<FormState>();
  String _name;
  String _password;
  bool _load = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent, //or set color with: Color(0xFF0000FF)
    ));
    Widget loadingIndicator = _load
        ? new Container(
            color: Colors.transparent,
            width: 70.0,
            height: 70.0,
            child: ColorLoader(
              radius: 15.0,
              dotRadius: 6.0,
            ),
          )
        : new Container();

    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: new AssetImage('assets/images/chobenthanh.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 5.0),
                        child: Image(
                            image: AssetImage('assets/logos/logo1.png'),
                            width: 80.0,
                            height: 50.0),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'QUẢN LÝ CHỢ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          'NHANH CHÓNG VÀ HIỆU QUẢ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 20, top: 10),
                        child: Text(
                          'Đăng nhập để tiếp tục sử dụng',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(.8),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: Container(
                          padding: EdgeInsets.all(20.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'Tên đăng nhập',
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                      fillColor: Colors.white,
                                      filled: true,
                                      prefixStyle:
                                          TextStyle(color: Colors.black),
                                      prefixIcon: Container(
                                        width: 35,
                                        child: Icon(
                                          Icons.account_circle,
                                          color: Colors.black,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 11,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6)))),
                                  keyboardType: TextInputType.text,
                                  validator: (val) {
                                    if (val.length == 0)
                                      return "Nhập tên đăng nhập";
                                    else
                                      return null;
                                  },
                                  onSaved: (val) => _name = val,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Mật khẩu',
                                    labelStyle: TextStyle(color: Colors.black),
                                    hintStyle: TextStyle(color: Colors.black),
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: Container(
                                      width: 35,
                                      child: Icon(
                                        Icons.security,
                                        color: Colors.black,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 11,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6))),
                                  ),
                                  obscureText: true,
                                  validator: (val) {
                                    if (val.length == 0)
                                      return "Nhập mật khẩu";
                                    else if (val.length < 6)
                                      return "Mật khẩu không hợp lệ";
                                    else
                                      return null;
                                  },
                                  onSaved: (val) => _password = val,
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 52,
                                    child: RaisedButton(
                                      onPressed: () {
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());
                                        _onLoginClick();
                                      },
                                      child: Text(
                                        'Đăng nhập',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      color: Color(0xff3277D8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        child: loadingIndicator,
                        alignment: FractionalOffset.center,
                      ),
                    ],
                  ),
                )),
          ),
        ));
  }

  void _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: MediaQuery.of(context).size.height / 10 * 2,
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.sentiment_very_dissatisfied,
                  color: Colors.red,
                  size: 60,
                ),
                Container(
                  padding: EdgeInsets.only(top: 8, bottom: 5),
                  child: Text(
                    'Đăng nhập không thành công!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
                Text(
                  'Xin vui lòng kiểm tra lại thông tin tài khoản',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        });
  }

  void _onLoginClick() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _load = true;
      });
      Navigator.pushReplacementNamed(context, '/home');
      // _auth.signIn(_name, _password).then((result) {
      //
      //   Timer(Duration(seconds: 2), () {
      //     if (result) {
      //       setState(() {
      //         _load = false;
      //       });
      //       Navigator.pushReplacementNamed(context, '/home');
      //     } else {
      //       setState(() {
      //         _load = false;
      //       });
      //       _showModalSheet();
      //     }
      //   });
      // }
    }
  }
}
