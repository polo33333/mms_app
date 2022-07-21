import 'package:flutter/foundation.dart';
import '../models/kiotDetail.dart';

class KiotDetailProvider extends ChangeNotifier {
  bool _isProcessing = true;
  int _currentPage = 1;
  List<KiotDetail> _kiotDetailList = [];
  bool _shouldRefresh = true;
  List<KiotDetail> _tempKiotDetailList = [];
  String _searchString = "";

  bool get shouldRefresh => _shouldRefresh;

  setShouldRefresh(bool value) => _shouldRefresh = value;

  int get currentPage => _currentPage;

  setCurrentPage(int page) {
    _currentPage = page;
  }

  bool get isProcessing => _isProcessing;

  setIsProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  List<KiotDetail> get kiotDetailList => _kiotDetailList;

  setList(List<KiotDetail> list, {bool notify = true}) {
    _kiotDetailList = list;
    _tempKiotDetailList = _kiotDetailList;
    if (notify) notifyListeners();
  }

  mergeList(List<KiotDetail> list, {bool notify = true}) {
    _kiotDetailList.addAll(list);
    if (notify) notifyListeners();
  }

  add(KiotDetail region, {bool notify = true}) {
    _kiotDetailList.add(region);
    if (notify) notifyListeners();
  }


  KiotDetail getByIndex(int index) => _kiotDetailList[index];
  int get kiotDetailListLength => _kiotDetailList.length;
}
