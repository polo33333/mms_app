import 'package:flutter/foundation.dart';

import '../models/market.dart';

class MarketProvider extends ChangeNotifier {
  bool _isMarketPageProcessing = true;
  int _currentPage = 1;
  List<Market> _marketList = [];
  bool _shouldRefresh = true;
  int _currentItemSelect = 0;

  bool get shouldRefresh => _shouldRefresh;

  setShouldRefresh(bool value) => _shouldRefresh = value;

  int get currentPage => _currentPage;

  setCurrentPage(int page) {
    _currentPage = page;
  }

  bool get isMarketPageProcessing => _isMarketPageProcessing;

  setIsMarketlPageProcessing(bool value) {
    _isMarketPageProcessing = value;
    notifyListeners();
  }

  List<Market> get marketList => _marketList;

  setMarketList(List<Market> list, {bool notify = true}) {
    _marketList = list;
    if (notify) notifyListeners();
  }

  mergeMarketList(List<Market> list, {bool notify = true}) {
    _marketList.addAll(list);
    if (notify) notifyListeners();
  }

  addMarket(Market market, {bool notify = true}) {
    _marketList.add(market);
    if (notify) notifyListeners();
  }

  Market getMarketByIndex(int index) => _marketList[index];

  int get marketListLength => _marketList.length;
}