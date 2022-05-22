import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../helpers/kiot_helper.dart';
import '../../models/kiot.dart';
import '../../provider/kiot_provider.dart';
import 'kiotDetail.dart';

class KiotListPage extends StatefulWidget {
  int regionId;
  KiotListPage({this.regionId});
  @override
  _KiotListPageState createState() => _KiotListPageState();
}

class _KiotListPageState extends State<KiotListPage> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  ScrollController _scrollController = ScrollController();

  _getPosts({bool refresh = true}) async {
    var provider = Provider.of<KiotProvider>(context, listen: false);
    var postsResponse = await KiotHelper.getByRegionId(widget.regionId);
    provider.setIsKiotPageProcessing(true);
    if (postsResponse.isSuccessful) {
      if (postsResponse.data.isNotEmpty || postsResponse.data.length == 0) {
        provider.setKiotList(postsResponse.data, notify: false);
        provider.setCurrentPage(provider.currentPage + 1);
      } else {
        provider.setShouldRefresh(false);
      }
    } else {
      //_showSnackbar(postsResponse.message);
    }
    await Future.delayed(Duration(seconds: 1));
    provider.setIsKiotPageProcessing(false);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getPosts(refresh: false);
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
          'Điểm kinh doanh - Danh sách',
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
                  Provider.of<KiotProvider>(context, listen: false)
                      .changeSearchString(value),
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xFF000000).withOpacity(0.5),
                  ),
                  hintText: "Nhập tên điểm kinh doanh để tìm kiếm...",
                  border: InputBorder.none),
            ),
          ),
        ),
      ),
      SliverFillRemaining(
        child: Consumer<KiotProvider>(
          builder: (_, provider, __) => provider.isKiotPageProcessing
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : provider.kiotListLength > 0
                  ? SingleChildScrollView(
                      padding: const EdgeInsets.all(5),
                      child: Column(children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          controller: _scrollController,
                          itemBuilder: (_, index) {
                            Kiot post = provider.getKiotByIndex(index);
                            return Card(
                                elevation: 3.0,
                                margin: new EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 6.0),
                                child: Container(
                                    child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  leading: Icon(
                                    Icons.place,
                                    color: Colors.green,
                                    size: 30.0,
                                  ),
                                  title: Text(
                                    post.kiotName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                  subtitle: Text(
                                    "Chợ: " + post.marketName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ), //element['group'] group name get
                                  trailing: Icon(Icons.arrow_forward),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: KiotDetailPage(kiot: post)),
                                    );
                                  },
                                )));
                          },
                          itemCount: provider.kiotListLength,
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
