import 'dart:async';
import 'package:flutter/material.dart';
import '../../helpers/apihelper.dart';
import '../../provider/genneralInfo_provider.dart';
import '../../widgets/flash_message_screen.dart';
import '../../widgets/colorLoader.dart';
import '../../helpers/Auth_helper.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginPage> {
  final AuthRepos _auth = AuthRepos();
  final _formKey = GlobalKey<FormState>();
  String _name;
  String _password;
  bool _load = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.height;
    //double viewInset = MediaQuery.of(context).viewInsets.bottom;
    double defaultLoginSize = size.height - (size.height * 0.2);
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
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                child: IconButton(
                  onPressed: () => {
                    Navigator.pop(context)
                  },
                  icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.blue,),
                )),
            Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  width: size.width,
                  height: defaultLoginSize,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        width: 280,
                        height: 220,
                        color: Colors.transparent,
                        child: Image.asset(
                          'assets/images/login.png',
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Đăng nhập hệ thống',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18, color: Colors.blue),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(15,5,15,0),
                                  child: Text(
                                    "Tên tài khoản",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.black.withOpacity(0.6)
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.blueAccent,
                                    width: 1,
                                  ),
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.supervised_user_circle,
                                      color: Color(0xff1093e4),
                                    ),
                                    hintText: 'Nhập tên tài khoản',
                                    hintStyle: TextStyle(fontSize: 14.0, color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                  onSaved: (val) => _name = val,
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(15,5,15,0),
                                  child: Text(
                                    "Mật khẩu",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.black.withOpacity(0.6)
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.blueAccent,
                                    width: 1,
                                  ),
                                ),
                                child: TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.lock,
                                      color: Color(0xff1093e4),
                                    ),
                                    hintText: 'Nhập mật khẩu',
                                    hintStyle: TextStyle(fontSize: 14.0, color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                  onSaved: (val) => _password = val,
                                ),
                              ),
                            ],
                          )),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.all(10),
                        width: double.infinity,
                        child: SizedBox(
                          height: 45,
                          child: TextButton(
                              child: Text(
                                "ĐĂNG NHẬP",
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              onPressed: () {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                _onLoginClick();
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blueAccent),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Align(
              child: loadingIndicator,
              alignment: FractionalOffset.bottomCenter,
            ),
          ],
        ),
      ),
    );
  }

  void _showModalSheet() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: FlashMessageScreen(
          "Oh no!", "Đăng nhập không thành công, Vui lòng kiểm tra lại!"),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }

  void _getGenneralInfo() async {
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

  void _onLoginClick() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _load = true;
      });
      //print(_name + _password);
      _auth.signIn(_name, _password).then((result) {
        _getGenneralInfo();
        Timer(Duration(seconds: 2), () {
          if (result) {
            setState(() {
              _load = false;
            });
            Navigator.pushNamedAndRemoveUntil(context, '/home',(Route<dynamic> route) => false);
          } else {
            setState(() {
              _load = false;
            });

            _showModalSheet();
          }
        });
      });
    }
  }
}
