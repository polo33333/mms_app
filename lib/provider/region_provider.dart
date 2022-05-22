import 'package:flutter/foundation.dart';
import '../models/region.dart';

class RegionProvider extends ChangeNotifier {
  bool _isProcessing = true;
  int _currentPage = 1;
  List<Region> _regionList = [];
  bool _shouldRefresh = true;
  List<Region> _tempRegionList = [];
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

  List<Region> get regionList => _regionList;

  setList(List<Region> list, {bool notify = true}) {
    _regionList = list;
    _tempRegionList = _regionList;
    if (notify) notifyListeners();
  }

  mergeList(List<Region> list, {bool notify = true}) {
    _regionList.addAll(list);
    if (notify) notifyListeners();
  }

  add(Region region, {bool notify = true}) {
    _regionList.add(region);
    if (notify) notifyListeners();
  }

  changeSearchString(String searchString) {
    _searchString = searchString;
    _regionList =
        _tempRegionList.where((r) => r.name.toLowerCase().contains(_searchString.toLowerCase())).toList();
    notifyListeners();
  }

  Region getByIndex(int index) => _regionList[index];
  int get regionListLength => _regionList.length;
}
