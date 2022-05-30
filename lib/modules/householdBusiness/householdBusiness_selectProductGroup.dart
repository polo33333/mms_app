import 'dart:async';

import 'package:flutter/material.dart';
import '../../helpers/productGroup_helper.dart';
import '../../models/productGroup.dart';
import '../../provider/productGroup_provider.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';
import 'householdBusinessList.dart';

class HouseholdBusinessSelectProductGroupScreen extends StatefulWidget {
  int marketId;
  HouseholdBusinessSelectProductGroupScreen({this.marketId});

  @override
  _HouseholdBusinessSelectProductGroupScreenState createState() =>
      _HouseholdBusinessSelectProductGroupScreenState();
}

class _HouseholdBusinessSelectProductGroupScreenState
    extends State<HouseholdBusinessSelectProductGroupScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  _getProductGroup({bool refresh = true}) async {
    var provider = Provider.of<ProductGroupProvider>(context, listen: false);
    var postsResponse = await ProductGroupHelper.getByMarketId(widget.marketId);
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
    //_getProductGroup(refresh: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getProductGroup(refresh: false);
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
          'Thương nhân - Ngành hàng',
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
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: TextField(
              cursorColor: Color(0xFF000000),
              onChanged: (value) =>
                  Provider.of<ProductGroupProvider>(context, listen: false)
                      .changeSearchString(value),
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xFF000000).withOpacity(0.5),
                  ),
                  hintText: "Nhập tên ngành hàng để tìm kiếm...",
                  border: InputBorder.none),
            ),
          ),
        ),
      ),
      SliverFillRemaining(
        child: Consumer<ProductGroupProvider>(
          builder: (_, provider, __) => provider.isProcessing
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : provider.productGroupListLength > 0
                  ? SingleChildScrollView(
                      padding: const EdgeInsets.all(5),
                      child: Column(children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (_, index) {
                            ProductGroup _data = provider.getByIndex(index);
                            return Card(
                                elevation: 3.0,
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
                                    _data.productGroupName,
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
                                          title: "Tổng thương nhân: ",
                                          value: _data.tHCTNTONG == null
                                              ? '0'
                                              : _data.tHCTNTONG.toString()),
                                      LineData(
                                          title: "Thương nhân đang hoạt động: ",
                                          value: _data.tHCTNDHD == null
                                              ? '0'
                                              : _data.tHCTNDHD.toString()),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: HouseholdBusinessListScreen(
                                            regionId: _data.regionID,
                                            marketId: widget.marketId,
                                          )),
                                    );
                                  },
                                )));
                          },
                          itemCount: provider.productGroupListLength,
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
