import 'package:flutter/foundation.dart';
import '../models/GenneralInfo.dart';

class GenneralInfoProvider extends ChangeNotifier {
  bool _isPageProcessing = true;
  int _currentPage = 1;
  GenneralInfo _genneralInfo = null;
  GenneralInfo _tempgenneralInfo = null;
  bool _shouldRefresh = true;
  bool get shouldRefresh => _shouldRefresh;

  setShouldRefresh(bool value) => _shouldRefresh = value;
  int get currentPage => _currentPage;
  setCurrentPage(int page) {
    _currentPage = page;
  }

  bool get isPageProcessing => _isPageProcessing;
  setIsProcessing(bool value) {
    _isPageProcessing = value;
    notifyListeners();
  }

  GenneralInfo get genneralInfo => _genneralInfo;
  setGenneralInfo(GenneralInfo data, {bool notify = true}) {
    _genneralInfo = data;
    _tempgenneralInfo = _genneralInfo;
    if (notify) notifyListeners();
  }
}
