import 'dart:async';

import 'package:flutter/material.dart';
import '../../modules/contract/contractDetail_1.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';
import '../../helpers/region_helper.dart';
import '../../models/region.dart';
import '../../provider/region_provider.dart';

class ContractSelectRegionScreen extends StatefulWidget {
  int marketId;
  ContractSelectRegionScreen({this.marketId});

  @override
  _ContractSelectRegionScreenState createState() =>
      _ContractSelectRegionScreenState();
}

class _ContractSelectRegionScreenState
    extends State<ContractSelectRegionScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  _getRegion({bool refresh = true}) async {
    var provider = Provider.of<RegionProvider>(context, listen: false);
    var postsResponse = await RegionHelper.getByMarketId(widget.marketId);
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
      _getRegion(refresh: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: true,
            centerTitle: true,
            title: Text(
              'Hợp đồng thương nhân - Khu vực',
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
                      Provider.of<RegionProvider>(context, listen: false)
                          .changeSearchString(value),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xFF000000).withOpacity(0.5),
                      ),
                      hintText: "Nhập tên khu vực để tìm kiếm...",
                      border: InputBorder.none),
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            child: Consumer<RegionProvider>(
              builder: (_, provider, __) => provider.isProcessing
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : provider.regionListLength > 0
                  ? SingleChildScrollView(
                  padding: const EdgeInsets.all(5),
                  child: Column(children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (_, index) {
                        Region _data = provider.getByIndex(index);
                        return Card(
                            elevation: 1.0,
                            margin: new EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 6.0),
                            child: Container(
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  leading: Icon(
                                    Icons.add_business_outlined,
                                    color: Colors.green,
                                    size: 30.0,
                                  ),
                                  title: Text(
                                    _data.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ), //element['group'] group name get
                                  trailing: Icon(Icons.arrow_forward),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      LineData(
                                          title: "Tổng ĐKD: ",
                                          value: _data.dKDTONG == null
                                              ? '0'
                                              : _data.dKDTONG.toString()),
                                      LineData(
                                          title: "ĐKD ký HĐ: ",
                                          value: _data.dKDKYHD == null
                                              ? '0'
                                              : _data.dKDKYHD.toString()),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                          type:
                                          PageTransitionType.rightToLeft,
                                          child: ContractDetail_1Screen(
                                              regionId: _data.masterID)),
                                    );
                                  },
                                )));
                      },
                      itemCount: provider.regionListLength,
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
