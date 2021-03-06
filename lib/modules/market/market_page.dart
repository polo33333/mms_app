import 'dart:ui';

import 'package:flutter/material.dart';
import '../../configs/themes/app_colors.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../helpers/apihelper.dart';
import '../../models/market.dart';
import '../../provider/market_provider.dart';
import 'marketDetail_page.dart';

class MarketPage extends StatefulWidget {
  @override
  _MarketPageState createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  _showSnackbar(String message, {Color bgColor}) {
    _globalKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: bgColor ?? Colors.red,
      ),
    );
  }

  _hideSnackbar() {
    _globalKey.currentState.hideCurrentSnackBar();
  }

  _getPosts({bool refresh = true}) async {
    var provider = Provider.of<MarketProvider>(context, listen: false);
    if (!provider.shouldRefresh) {
      _showSnackbar('That\'s it for now!');
      return;
    }
    if (refresh) _showSnackbar('Loading more...', bgColor: Colors.green);

    var postsResponse = await APIHelper.getAll();
    if (postsResponse.isSuccessful) {
      if (postsResponse.data.isNotEmpty) {
        if (refresh) {
          provider.mergeMarketList(postsResponse.data, notify: false);
        } else {
          provider.setMarketList(postsResponse.data, notify: false);
        }
        provider.setCurrentPage(provider.currentPage + 1);
      } else {
        provider.setShouldRefresh(false);
      }
    } else {
      _showSnackbar(postsResponse.message);
    }
    provider.setIsMarketlPageProcessing(false);
    _hideSnackbar();
  }

  @override
  void initState() {
    super.initState();
    _getPosts(refresh: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: AppColors.blue_w500,
        title: Text(
          'Danh s??ch ch???',
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
      body: Consumer<MarketProvider>(
        builder: (_, provider, __) => provider.isMarketPageProcessing
            ? Center(
                child: CircularProgressIndicator(),
              )
            : provider.marketListLength > 0
                ? ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (_, index) {
                      Market post = provider.getMarketByIndex(index);
                      // return ListTile(
                      //   title: Text((index + 1).toString() + '. ' + post.marketName),
                      //   onTap: (){
                      //     Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: MarketDetailPage()));
                      //   },
                      // );
                      return Card(
                          elevation: 3.0,
                          margin: new EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 6.0),
                          child: Container(
                              child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            // leading: Icon(
                            //   Icons.home_work_outlined,
                            //   color: Colors.green,
                            //   size: 30.0,
                            // ),
                            leading: CircleAvatar(
                              child: Text(
                                post.marketName[0],
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                              backgroundColor: Colors.green,
                            ),
                            title: Text(
                              post.marketName,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ), //element['group'] group name get
                            trailing: Icon(Icons.arrow_forward),
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: MarketDetailPage(
                                        marketId: post.marketID)),
                              );
                            },
                          )));
                    },
                    itemCount: provider.marketListLength,
                  )
                : Center(
                    child: Container(
                      width: 500,
                      height: 400,
                      color: Colors.transparent,
                      child: Image.asset('assets/images/no-data-found-1.png'),
                    ),
                  ),
      ),
    );
  }
}
