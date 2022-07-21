import 'package:flutter/material.dart';
import '../../models/kiotDetail.dart';
import '../../helpers/kiot_helper.dart';
import 'package:provider/provider.dart';
import '../../configs/themes/app_colors.dart';
import 'package:intl/intl.dart';

import '../../provider/kiotDetail_provider.dart';

class KiotDetailPage extends StatefulWidget {
  var kiot;
  KiotDetailPage({this.kiot});

  @override
  _KiotDetailPageState createState() => _KiotDetailPageState();
}

class _KiotDetailPageState extends State<KiotDetailPage> {
  _getDetail({bool refresh = true}) async {
    var provider = Provider.of<KiotDetailProvider>(context, listen: false);
    var postsResponse = await KiotHelper.getDetailById(widget.kiot.kiotID);
    provider.setIsProcessing(true);
    if (postsResponse.isSuccessful) {
      if (postsResponse.data.isNotEmpty || postsResponse.data.length == 0) {
        if (refresh) {
          provider.mergeList(postsResponse.data, notify: false);
        } else {
          provider.setList(postsResponse.data, notify: false);
        }
      } else {
        provider.setIsProcessing(true);
        // provider.setShouldRefresh(false);
      }
    } else {
      //_showSnackbar(postsResponse.message);
    }
    await Future.delayed(Duration(seconds: 1));
    provider.setIsProcessing(false);
    // _hideSnackbar();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getDetail(refresh: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final f = new DateFormat('dd-MM-yyyy');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: AppColors.blue_w500,
        title: Text(
          'Điểm kinh doanh - Chi tiết',
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
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              alignment: Alignment.centerLeft,
              child: Text(
                widget.kiot.kiotName == null ? "" : widget.kiot.kiotName,
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
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                margin:
                    new EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.0),
                child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        subtitle: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              LineData(
                                  title: "Mã ĐKD: ",
                                  value: widget.kiot.kiotCode == null
                                      ? ""
                                      : widget.kiot.kiotCode),
                              SizedBox(
                                width: double.infinity,
                                height: 5,
                              ),
                              LineData(
                                  title: "Diện tích: ",
                                  value: widget.kiot.area == null
                                      ? ""
                                      : widget.kiot.area.toString()),
                              SizedBox(
                                width: double.infinity,
                                height: 5,
                              ),
                              LineData(
                                  title: "Khu vực/vị trí : ",
                                  value: widget.kiot.regionName == null
                                      ? ""
                                      : widget.kiot.regionName),
                              SizedBox(
                                width: double.infinity,
                                height: 5,
                              ),
                              LineData(
                                  title: "Ngành hàng: ",
                                  value: widget.kiot.productGroupName == null
                                      ? ""
                                      : widget.kiot.productGroupName),
                              SizedBox(
                                width: double.infinity,
                                height: 5,
                              ),
                              LineData(
                                  title: "Loại ĐKD: ",
                                  value: widget.kiot.kiotTypeName == null
                                      ? ""
                                      : widget.kiot.kiotTypeName),
                              SizedBox(
                                width: double.infinity,
                                height: 5,
                              ),
                              LineData(
                                  title: "Làm kho: ",
                                  value: widget.kiot.isStore == null
                                      ? ""
                                      : widget.kiot.isStore == true
                                          ? "Có"
                                          : "Không"),
                              SizedBox(
                                width: double.infinity,
                                height: 5,
                              ),
                              LineData(
                                  title: "Tình trạng: ",
                                  value: widget.kiot.statusName == null
                                      ? ""
                                      : widget.kiot.statusName),
                            ])))),
            Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.fromLTRB(15, 5.0, 15, 5.0),
              alignment: Alignment.centerLeft,
              decoration: new BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Text(
                "Quyền sử dụng",
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
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                margin:
                    new EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.0),
                child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        subtitle: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              LineData(
                                  title: "Số GCN QSD ĐKD/GCN: ",
                                  value: widget.kiot.qSDLicenseNo == null
                                      ? ""
                                      : widget.kiot.qSDLicenseNo.toString()),
                              SizedBox(
                                width: double.infinity,
                                height: 5,
                              ),
                              LineData(
                                title: "Ngày cấp: ",
                                value: widget.kiot.qSDLicenseDate == null
                                    ? ""
                                    : f
                                        .format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                int.parse(widget
                                                    .kiot.qSDLicenseDate
                                                    .replaceAll(
                                                        RegExp('[^0-9]'), ''))))
                                        .toString(),
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 5,
                              ),
                              LineData(
                                  title: "Họ và tên: ",
                                  value: widget.kiot.qSDFullName == null
                                      ? ""
                                      : widget.kiot.qSDFullName),
                              SizedBox(
                                width: double.infinity,
                                height: 5,
                              ),
                              LineData(
                                  title: "CMND/CCCD: ",
                                  value: widget.kiot.qSDIDNo == null
                                      ? ""
                                      : widget.kiot.qSDIDNo.toString()),
                              SizedBox(
                                width: double.infinity,
                                height: 5,
                              ),
                              LineData(
                                  title: "Điện thoại: ",
                                  value: widget.kiot.qSDPhone == null
                                      ? ""
                                      : widget.kiot.qSDPhone),
                              SizedBox(
                                width: double.infinity,
                                height: 5,
                              ),
                              LineData(
                                  title: "Địa chỉ: ",
                                  value: widget.kiot.qSDAddress == null
                                      ? ""
                                      : widget.kiot.qSDAddress),
                            ])))),
            Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.fromLTRB(15, 5.0, 15, 5.0),
              alignment: Alignment.centerLeft,
              decoration: new BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Text(
                "Người kinh doanh",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Consumer<KiotDetailProvider>(
              builder: (_, provider, __) => provider.isProcessing
                  ? Container()
                  : provider.kiotDetailListLength > 0
                      ? SingleChildScrollView(
                          padding: const EdgeInsets.all(5),
                          child: Column(children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (_, index) {
                                KiotDetail post = provider.getByIndex(index);
                                return Card(
                                    elevation: 8.0,
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.grey, width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    margin: new EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 2.0),
                                    child: Container(
                                        decoration:
                                            BoxDecoration(color: Colors.white),
                                        child: ListTile(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 20.0,
                                                    vertical: 10.0),
                                            subtitle: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  LineData(
                                                      title: "Họ và tên: ",
                                                      value: post.nKDFullName ==
                                                              null
                                                          ? ""
                                                          : post.nKDFullName
                                                              .toString()),
                                                  SizedBox(
                                                    width: double.infinity,
                                                    height: 5,
                                                  ),
                                                  LineData(
                                                      title: "CMND/CCCD: ",
                                                      value:
                                                          post.nKDIDNo == null
                                                              ? ""
                                                              : post.nKDIDNo
                                                                  .toString()),
                                                  SizedBox(
                                                    width: double.infinity,
                                                    height: 5,
                                                  ),
                                                  LineData(
                                                      title: "Điện thoại: ",
                                                      value:
                                                          post.nKDPhone == null
                                                              ? ""
                                                              : post.nKDPhone),
                                                  SizedBox(
                                                    width: double.infinity,
                                                    height: 5,
                                                  ),
                                                  LineData(
                                                      title: "Địa chỉ: ",
                                                      value: post.nKDAddress ==
                                                              null
                                                          ? ""
                                                          : post.nKDAddress
                                                              .toString()),
                                                  SizedBox(
                                                    width: double.infinity,
                                                    height: 5,
                                                  ),
                                                  LineData(
                                                      title: "Mã số thuế: ",
                                                      value: post.nKDTaxCode ==
                                                              null
                                                          ? ""
                                                          : post.nKDTaxCode
                                                              .toString()),
                                                  SizedBox(
                                                    width: double.infinity,
                                                    height: 5,
                                                  ),
                                                  LineData(
                                                      title: "Số GCN ĐKKD: ",
                                                      value:
                                                          post.nKDLicenseNo ==
                                                                  null
                                                              ? ""
                                                              : post
                                                                  .nKDLicenseNo
                                                                  .toString()),
                                                ]))));
                              },
                              itemCount: provider.kiotDetailListLength,
                            )
                          ]))
                      : Container(),
            ),
            SizedBox(
              width: double.infinity,
              height: 5,
            ),
          ],
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
