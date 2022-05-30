import 'package:flutter/foundation.dart';
import '../models/marketDetail.dart';

class MarketDetailProvider extends ChangeNotifier {
  bool _isMarketPageProcessing = true;
  MarketDetail _market = null;
  bool _shouldRefresh = true;

  bool get shouldRefresh => _shouldRefresh;

  setShouldRefresh(bool value) => _shouldRefresh = value;

  bool get isMarketPageProcessing => _isMarketPageProcessing;

  setIsMarketlPageProcessing(bool value) {
    _isMarketPageProcessing = value;
    notifyListeners();
  }

  MarketDetail get market => _market;

  setMarket(MarketDetail data, {bool notify = true}) {
    _market = data;
    if (notify) notifyListeners();
  }

}