import 'package:flutter/foundation.dart';
import '../models/contract_2.dart';

class Contract_2_Provider extends ChangeNotifier {
  bool _isContractPageProcessing = true;
  int _currentPage = 1;
  List<Contract_2> _contractList = [];
  List<Contract_2> _tempcontractList = [];
  bool _shouldRefresh = true;
  String _searchString = "";

  bool get shouldRefresh => _shouldRefresh;

  setShouldRefresh(bool value) => _shouldRefresh = value;

  int get currentPage => _currentPage;

  setCurrentPage(int page) {
    _currentPage = page;
  }

  bool get isContractPageProcessing => _isContractPageProcessing;



  setIsContractProcessing(bool value) {
    _isContractPageProcessing = value;
    notifyListeners();
  }

  List<Contract_2> get contractList => _contractList;

  setContractList(List<Contract_2> list, {bool notify = true}) {
    _contractList = list;
    _tempcontractList = _contractList;
    if (notify) notifyListeners();
  }

  mergeContractList(List<Contract_2> list, {bool notify = true}) {
    _contractList.addAll(list);
    if (notify) notifyListeners();
  }

  addContract(Contract_2 contract, {bool notify = true}) {
    _contractList.add(contract);
    if (notify) notifyListeners();
  }

  changeSearchString(String searchString) {
    _searchString = searchString;
    _contractList= _tempcontractList.where((dog) => dog.contractNo.contains(_searchString)).toList();
    notifyListeners();
  }

  Contract_2 getContractByIndex(int index) => _contractList[index];

  int get contractListLength => _contractList.length;
}