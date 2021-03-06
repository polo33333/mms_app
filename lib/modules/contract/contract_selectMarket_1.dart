import 'package:flutter/material.dart';
import '../../configs/themes/app_colors.dart';
import '../../helpers/apihelper.dart';
import '../../models/market.dart';
import '../../modules/contract/contract_selectRegion.dart';
import '../../provider/market_provider.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';

class ContractSelectMarket_1Screen extends StatefulWidget {
  @override
  _ContractSelectMarket_1ScreenState createState() =>
      _ContractSelectMarket_1ScreenState();
}

class _ContractSelectMarket_1ScreenState
    extends State<ContractSelectMarket_1Screen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  ScrollController _scrollController = ScrollController();

  _getMarket({bool refresh = true}) async {
    var provider = Provider.of<MarketProvider>(context, listen: false);

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
      //_showSnackbar(postsResponse.message);
    }
    provider.setIsMarketlPageProcessing(false);
    //_hideSnackbar();
  }

  @override
  void initState() {
    super.initState();
    _getMarket(refresh: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: AppColors.blue_w500,
        title: Text(
          'Hợp đồng thương nhân - Chợ',
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
                      return Card(
                          elevation: 1.0,
                          margin: new EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 6.0),
                          child: Container(
                              child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
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
                            // subtitle: Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     LineData(
                            //         title: "Tổng ĐKD: ",
                            //         value: post.dKDTONG == null
                            //             ? '0'
                            //             : post.dKDTONG.toString()),
                            //     LineData(
                            //         title: "ĐKD ký HĐ: ",
                            //         value: post.dKDKYHD == null
                            //             ? '0'
                            //             : post.dKDKYHD.toString()),
                            //   ],
                            // ),
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: ContractSelectRegionScreen(
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
