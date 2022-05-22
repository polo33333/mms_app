import 'package:flutter/material.dart';
import 'package:mms/configs/themes/app_colors.dart';
import 'package:provider/provider.dart';
import '../../configs/app_config.dart';
import '../../helpers/apihelper.dart';
import '../../provider/marketDetail_provider.dart';
import 'package:intl/intl.dart';

class MarketDetailPage extends StatefulWidget {
  var marketId;
  MarketDetailPage({this.marketId});

  @override
  _MarketDetailState createState() => _MarketDetailState();
}

class _MarketDetailState extends State<MarketDetailPage> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  _getMarketDetail({bool refresh = true}) async {
    var provider = Provider.of<MarketDetailProvider>(context, listen: false);
    provider.setIsMarketlPageProcessing(true);
    var postsResponse = await APIHelper.getById(widget.marketId);
    if (postsResponse.isSuccessful) {
      if (postsResponse.data != null) {
        provider.setMarket(postsResponse.data, notify: false);
      } else {
        provider.setShouldRefresh(false);
      }
    } else {
      //_showSnackbar(postsResponse.message);
    }
    await Future.delayed(Duration(seconds: 1));
    provider.setIsMarketlPageProcessing(false);
    //_hideSnackbar();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getMarketDetail(refresh: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final f = new DateFormat('dd-MM-yyyy');
    // var data = Provider.of<MarketDetailProvider>(context, listen: false).market;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: AppColors.blue_w500,
        title: Text(
          'Chi tiết chợ',
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
      body: Consumer<MarketDetailProvider>(
        builder: (_, provider, __) => provider.isMarketPageProcessing
            ? Center(
                child: CircularProgressIndicator(),
              )
            : provider.market != null
                ? SingleChildScrollView(
                    child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          provider.market == null
                              ? ""
                              : provider.market.marketName,
                          style: TextStyle(
                              color: AppColors.kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        margin: EdgeInsets.fromLTRB(15, 5.0, 15, 5.0),
                        alignment: Alignment.centerLeft,
                        decoration: new BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Text(
                          "Thông tin chung",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Card(
                          elevation: 8.0,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.grey, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          margin: new EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 2.0),
                          child: Container(
                              decoration: BoxDecoration(color: Colors.white),
                              child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 10.0),
                                  subtitle: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        LineData(
                                            title: "Quyền sử dụng đất chợ: ",
                                            value: provider.market.qSDDC == null
                                                ? ""
                                                : provider.market.qSDDC),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 5,
                                        ),
                                        LineData(
                                            title: "Địa chỉ: ",
                                            value:
                                                provider.market.address == null
                                                    ? ""
                                                    : provider.market.address),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 5,
                                        ),
                                        LineData(
                                            title: "Hạng chợ: ",
                                            value: provider.market
                                                        .marketTypeName ==
                                                    null
                                                ? ""
                                                : provider
                                                    .market.marketTypeName),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 5,
                                        ),
                                        LineData(
                                            title: "Quyết định công nhận chợ: ",
                                            value: provider.market.qDCNC == null
                                                ? ""
                                                : provider.market.qDCNC),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 5,
                                        ),
                                        LineData(
                                            title: "Diện tích: ",
                                            value: provider.market.area == null
                                                ? ""
                                                : provider.market.area
                                                    .toString()),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 5,
                                        ),
                                        LineData(
                                            title:
                                                "Hình thức kinh doanh tại chợ: ",
                                            value:
                                                provider.market.hTKDTC == null
                                                    ? ""
                                                    : provider.market.hTKDTC),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 5,
                                        ),
                                        LineData(
                                            title: "Phương thức kinh doanh: ",
                                            value: provider.market.pTKD == null
                                                ? ""
                                                : provider.market.pTKD),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 5,
                                        ),
                                        LineData(
                                            title:
                                                "Tổng khu vực: ",
                                            value:
                                                provider.market.region == null
                                                    ? ""
                                                    : provider.market.region
                                                        .toString()),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 5,
                                        ),
                                        LineData(
                                            title:
                                                "Điểm kinh doanh (theo thiết kế): ",
                                            value:
                                                provider.market.sDKDTTK == null
                                                    ? ""
                                                    : provider.market.sDKDTTK
                                                        .toString()),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 5,
                                        ),
                                        LineData2(
                                            title1:
                                                "Diện tích điểm kinh doanh nhỏ nhất: ",
                                            title2: " m2/điểm",
                                            value: provider.market
                                                        .dKDDIENTICHMIN ==
                                                    null
                                                ? ""
                                                : provider.market.dKDDIENTICHMIN
                                                    .toString()),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 5,
                                        ),
                                        LineData2(
                                            title1:
                                                "Diện tích điểm kinh doanh lớn nhất: ",
                                            title2: " m2/điểm",
                                            value: provider.market
                                                        .dKDDIENTICHMAX ==
                                                    null
                                                ? ""
                                                : provider.market.dKDDIENTICHMAX
                                                    .toString()),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 5,
                                        ),
                                        LineData(
                                            title:
                                                "Quyền sử dụng ĐKD nhà nước: ",
                                            value: provider.market.qSDDKDNN ==
                                                    null
                                                ? ""
                                                : provider.market.qSDDKDNN +
                                                            provider.market
                                                                .qSDDKDCNTC ==
                                                        0
                                                    ? "0%"
                                                    : (100 *
                                                                provider.market
                                                                    .qSDDKDNN /
                                                                (provider.market
                                                                        .qSDDKDNN +
                                                                    provider
                                                                        .market
                                                                        .qSDDKDCNTC))
                                                            .toStringAsFixed(
                                                                2) +
                                                        "%"),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 5,
                                        ),
                                        LineData(
                                            title:
                                                "Quyền sử dụng ĐKD cá nhân/tổ chức: ",
                                            value: provider.market.qSDDKDCNTC ==
                                                    null
                                                ? ""
                                                : provider.market.qSDDKDNN +
                                                            provider.market
                                                                .qSDDKDCNTC ==
                                                        0
                                                    ? "0%"
                                                    : (100 *
                                                                provider.market
                                                                    .qSDDKDCNTC /
                                                                (provider.market
                                                                        .qSDDKDNN +
                                                                    provider
                                                                        .market
                                                                        .qSDDKDCNTC))
                                                            .toStringAsFixed(
                                                                2) +
                                                        "%"),
                                      ])))),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        margin: EdgeInsets.fromLTRB(15, 5.0, 15, 5.0),
                        alignment: Alignment.centerLeft,
                        decoration: new BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Text(
                          "Thông tin chi tiết",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Card(
                          elevation: 8.0,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.grey, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          margin: new EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 2.0),
                          child: Container(
                              decoration: BoxDecoration(color: Colors.white),
                              child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  subtitle: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        LineData(
                                            title: "Số ĐKD đang hoạt động: ",
                                            value:
                                                provider.market.sDKDDHD == null
                                                    ? ""
                                                    : provider.market.sDKDDHD
                                                        .toString()),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 5,
                                        ),
                                        LineData(
                                            title: "Số ĐKD làm kho: ",
                                            value:
                                                provider.market.sDKDLK == null
                                                    ? ""
                                                    : provider.market.sDKDLK
                                                        .toString()),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 5,
                                        ),
                                        LineData(
                                            title: "Số ĐKD còn trống: ",
                                            value:
                                                provider.market.sDKDCT == null
                                                    ? ""
                                                    : provider.market.sDKDCT
                                                        .toString()),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 5,
                                        ),
                                        LineData(
                                            title:
                                                "Số lượng ngành hàng kinh doanh: ",
                                            value: provider
                                                        .market.sLNGANHHANGKD ==
                                                    null
                                                ? ""
                                                : provider.market.sLNGANHHANGKD
                                                    .toString()),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 5,
                                        ),
                                        LineData(
                                            title: "Số TN có GCN ĐKKD: ",
                                            value: provider
                                                        .market.sTNCGCNDKKD ==
                                                    null
                                                ? ""
                                                : provider.market.sTNCGCNDKKD
                                                    .toString()),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 5,
                                        ),
                                        LineData(
                                            title: "Số TN có GCN ATTP: ",
                                            value: provider
                                                        .market.sTNCGCNATTP ==
                                                    null
                                                ? ""
                                                : provider.market.sTNCGCNATTP
                                                    .toString()),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 5,
                                        ),
                                        LineData(
                                            title: "Số TN có KSK: ",
                                            value:
                                                provider.market.sTNCKSK == null
                                                    ? ""
                                                    : provider.market.sTNCKSK
                                                        .toString()),
                                      ])))),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        margin: EdgeInsets.fromLTRB(15, 5.0, 15, 5.0),
                        alignment: Alignment.centerLeft,
                        decoration: new BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Text(
                          "Đơn vị đầu tư xây chợ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Card(
                          elevation: 8.0,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.grey, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          margin: new EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 2.0),
                          child: Container(
                              decoration: BoxDecoration(color: Colors.white),
                              child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  subtitle: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        LineData(
                                            title: "Đơn vị quản lý chợ: ",
                                            value: provider
                                                        .market.companyName ==
                                                    null
                                                ? ""
                                                : provider.market.companyName),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 5,
                                        ),
                                        RichText(
                                            text: TextSpan(children: <TextSpan>[
                                          TextSpan(
                                              text: "Thời hạn gói thầu: ",
                                              style: TextStyle(
                                                color: AppColors.kPrimaryColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              )),
                                          TextSpan(
                                              text: provider.market
                                                          .contractStartDate ==
                                                      null
                                                  ? ''
                                                  : f.format(DateTime.fromMillisecondsSinceEpoch(int.parse(provider.market.contractStartDate.replaceAll(RegExp('[^0-9]'), '')))) +
                                                      ' - ' +
                                                      (provider.market.contractEndDate == null
                                                          ? ''
                                                          : f.format(DateTime.fromMillisecondsSinceEpoch(
                                                              int.parse(provider
                                                                  .market
                                                                  .contractEndDate
                                                                  .replaceAll(
                                                                      RegExp('[^0-9]'),
                                                                      ''))))),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              )),
                                        ])),
                                      ])))),
                      // Container(
                      //   padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
                      //   alignment: Alignment.centerLeft,
                      //   child: RichText(
                      //       text: TextSpan(children: <TextSpan>[
                      //     TextSpan(
                      //         text: "Quy hoạch của địa phương đối với chợ: ",
                      //         style: TextStyle(
                      //           color: Colors.black.withOpacity(0.5),
                      //           fontSize: 16,
                      //           fontWeight: FontWeight.w400,
                      //         )),
                      //     TextSpan(
                      //         text: provider.market.qHCDPDVC == null
                      //             ? ''
                      //             : provider.market.qHCDPDVC,
                      //         style: TextStyle(
                      //           color: Colors.black,
                      //           fontSize: 16,
                      //           fontWeight: FontWeight.w400,
                      //         )),
                      //   ])),
                      // ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        margin: EdgeInsets.fromLTRB(15, 5.0, 15, 5.0),
                        alignment: Alignment.centerLeft,
                        decoration: new BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Text(
                          "Quy hoạch của địa phương đối với chợ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      provider.market.qHCDPDVC == null
                          ? SizedBox(width: double.infinity, height: 5)
                          : provider.market.qHCDPDVC == ''
                              ? SizedBox(width: double.infinity, height: 5)
                              : Card(
                                  elevation: 8.0,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.grey, width: 1),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  margin: new EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 2.0),
                                  child: Container(
                                      decoration:
                                          BoxDecoration(color: Colors.white),
                                      child: ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 10.0),
                                          subtitle: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                LineData(
                                                    title: "",
                                                    value: provider.market
                                                                .qHCDPDVC ==
                                                            null
                                                        ? ""
                                                        : provider
                                                            .market.qHCDPDVC),
                                                SizedBox(
                                                  width: double.infinity,
                                                  height: 5,
                                                ),
                                              ])))),
                      SizedBox(
                        width: double.infinity,
                        height: 5,
                      ),
                    ],
                  ))
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
            color: AppColors.kPrimaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          )),
      TextSpan(
          text: value,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          )),
    ]));
  }
}

class LineData2 extends StatelessWidget {
  LineData2({this.title1, this.title2, this.value});
  final String title1, title2;
  final String value;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: <TextSpan>[
      TextSpan(
          text: title1,
          style: TextStyle(
            color: AppColors.kPrimaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          )),
      TextSpan(
          text: value,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          )),
      TextSpan(
          text: title2,
          style: TextStyle(
            color: AppColors.kPrimaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          )),
    ]));
  }
}
