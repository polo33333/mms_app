import 'package:flutter/material.dart';
import '../../configs/themes/app_colors.dart';
import 'package:provider/provider.dart';
import '../../helpers/contracthelper.dart';
import '../../models/contract.dart';
import '../../provider/contract_provider.dart';
import 'package:intl/intl.dart';

class ContractDetail_1Screen extends StatefulWidget {
  int regionId;
  ContractDetail_1Screen({this.regionId});
  @override
  _ContractDetail_1ScreenState createState() => _ContractDetail_1ScreenState();
}

class _ContractDetail_1ScreenState extends State<ContractDetail_1Screen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  ScrollController _scrollController = ScrollController();

  _getContracts({bool refresh = true}) async {
    var provider = Provider.of<ContractProvider>(context, listen: false);
    var postsResponse = await ContractHelper.getByRegionId(widget.regionId);
    provider.setIsContractProcessing(true);
    if (postsResponse.isSuccessful) {
      if (postsResponse.data.isNotEmpty || postsResponse.data.length == 0) {
        if (refresh) {
          provider.mergeContractList(postsResponse.data, notify: false);
        } else {
          provider.setContractList(postsResponse.data, notify: false);
        }
        provider.setCurrentPage(provider.currentPage + 1);
      } else {
        provider.setShouldRefresh(false);
      }
    } else {
      //_showSnackbar(postsResponse.message);
    }
    await Future.delayed(Duration(seconds: 1));
    provider.setIsContractProcessing(false);
    //_hideSnackbar();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getContracts(refresh: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final f = new DateFormat('dd-MM-yyyy');
    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverAppBar(
        floating: true,
        pinned: true,
        snap: true,
        centerTitle: true,
        title: Text(
          'Hợp đồng thương nhân',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            fontFamily: "Calibre-Semibold",
            letterSpacing: 1.0,
          ),
        ),
        actions: <Widget>[],
        bottom: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)),
            child: TextField(
              cursorColor: Color(0xFF000000),
              onChanged: (value) =>
                  Provider.of<ContractProvider>(context, listen: false)
                      .changeSearchString(value),
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xFF000000).withOpacity(0.5),
                  ),
                  hintText: "Nhập mã hợp đồng để tìm kiếm...",
                  border: InputBorder.none),
            ),
          ),
        ),
      ),
      SliverFillRemaining(
        child: Consumer<ContractProvider>(
          builder: (_, provider, __) => provider.isContractPageProcessing
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : provider.contractListLength > 0
                  ? SingleChildScrollView(
                      padding: const EdgeInsets.all(5),
                      child: Column(children: [
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          controller: _scrollController,
                          itemBuilder: (_, index) {
                            Contract post = provider.getContractByIndex(index);
                            return Card(
                                elevation: 3.0,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.grey, width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                margin: new EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 5.0),
                                child: Container(
                                    child: ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 10.0),
                                        // leading: Icon(
                                        //   Icons.note_add_sharp,
                                        //   color: Colors.green,
                                        //   size: 30.0,
                                        // ),
                                        title: LineData(
                                            title: "Số hợp đồng: ",
                                            value: post.rentCode),
                                        subtitle: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              width: double.infinity,
                                              height: 5,
                                            ),
                                            LineData(
                                                title: "Chợ: ",
                                                value: post.marketName),
                                            SizedBox(
                                              width: double.infinity,
                                              height: 5,
                                            ),
                                            LineData(
                                                title: "Thương nhân: ",
                                                value:
                                                    post.householdBusinessName),
                                            SizedBox(
                                              width: double.infinity,
                                              height: 5,
                                            ),
                                            LineData(
                                                title: "Ngành hàng: ",
                                                value: post.productGroupName),
                                            SizedBox(
                                              width: double.infinity,
                                              height: 5,
                                            ),
                                            LineData(
                                                title: "ĐKD: ",
                                                value: post.kiotName),
                                            SizedBox(
                                              width: double.infinity,
                                              height: 5,
                                            ),
                                            LineData(
                                                title: "Khu vực: ",
                                                value: post.regionName),
                                            SizedBox(
                                              width: double.infinity,
                                              height: 5,
                                            ),
                                            LineData(
                                                title:
                                                    "Thời hạn (số tháng thuê): ",
                                                value: post.qty.toString()),
                                            SizedBox(
                                              width: double.infinity,
                                              height: 5,
                                            ),
                                            RichText(
                                                text: TextSpan(children: <
                                                    TextSpan>[
                                              TextSpan(
                                                  text: "Ngày bắt đầu: ",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  )),
                                              TextSpan(
                                                  text: f.format(DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                          int.parse(post
                                                              .startDate
                                                              .replaceAll(
                                                                  RegExp(
                                                                      '[^0-9]'),
                                                                  '')))),
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.kPrimaryColor,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                            ])),
                                            SizedBox(
                                              width: double.infinity,
                                              height: 5,
                                            ),
                                            RichText(
                                                text: TextSpan(children: <
                                                    TextSpan>[
                                              TextSpan(
                                                  text: "Ngày hết hạn: ",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  )),
                                              TextSpan(
                                                  text: f.format(DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                          int.parse(post.endDate
                                                              .replaceAll(
                                                                  RegExp(
                                                                      '[^0-9]'),
                                                                  '')))),
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.kPrimaryColor,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                            ])),
                                          ],
                                        ))));
                          },
                          itemCount: provider.contractListLength,
                        )
                      ]))
                  : Center(
                      child: Container(
                        width: 500,
                        height: 400,
                        color: Colors.transparent,
                        child: Image.asset('assets/images/no-data-found-1.png'),
                      ),
                    ),
        ),
      ),
    ]));
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
            fontWeight: FontWeight.w500,
          )),
      TextSpan(
          text: value,
          style: TextStyle(
            color: AppColors.kPrimaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          )),
    ]));
  }
}
