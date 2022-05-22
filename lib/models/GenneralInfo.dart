class GenneralInfo {
  int marketNo;
  int kiotNo;
  int householdBusinessNo;

  GenneralInfo({this.marketNo, this.kiotNo, this.householdBusinessNo});

  GenneralInfo.fromJson(Map<String, dynamic> json) {
    marketNo = json['marketNo'];
    kiotNo = json['kiotNo'];
    householdBusinessNo = json['householdBusinessNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['marketNo'] = this.marketNo;
    data['kiotNo'] = this.kiotNo;
    data['householdBusinessNo'] = this.householdBusinessNo;
    return data;
  }
}