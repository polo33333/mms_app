import 'package:flutter/foundation.dart';
import '../models/productGroup.dart';

class ProductGroupProvider extends ChangeNotifier {
  bool _isProcessing = true;
  int _currentPage = 1;
  List<ProductGroup> _productGroupList = [];
  bool _shouldRefresh = true;
  List<ProductGroup> _tempProductGroupList = [];
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

  List<ProductGroup> get productGroupList => _productGroupList;

  setList(List<ProductGroup> list, {bool notify = true}) {
    _productGroupList = list;
    _tempProductGroupList = _productGroupList;
    if (notify) notifyListeners();
  }

  mergeList(List<ProductGroup> list, {bool notify = true}) {
    _productGroupList.addAll(list);
    if (notify) notifyListeners();
  }

  add(ProductGroup productGroup, {bool notify = true}) {
    _productGroupList.add(productGroup);
    if (notify) notifyListeners();
  }

  changeSearchString(String searchString) {
    _searchString = searchString;
    _productGroupList = _tempProductGroupList
        .where((r) => r.productGroupName.toLowerCase().contains(_searchString.toLowerCase()))
        .toList();
    notifyListeners();
  }

  ProductGroup getByIndex(int index) => _productGroupList[index];
  int get productGroupListLength => _productGroupList.length;
}
