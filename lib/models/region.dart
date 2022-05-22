class Region {
  int masterID;
  int masterType;
  String name;
  String code;
  int marketID;
  String note;
  int companyID;
  int dKDTONG;
  int sDKDDHD;
  int dKDKYHD;

  Region(
      {this.masterID,
        this.masterType,
        this.name,
        this.code,
        this.marketID,
        this.note,
        this.companyID,
        this.dKDTONG,
        this.sDKDDHD,
      this.dKDKYHD});

  Region.fromJson(Map<String, dynamic> json) {
    masterID = json['MasterID'];
    masterType = json['MasterType'];
    name = json['Name'];
    code = json['Code'];
    marketID = json['MarketID'];
    note = json['Note'];
    companyID = json['CompanyID'];
    dKDTONG = json['DKD_TONG'];
    sDKDDHD = json['SDKDDHD'];
    dKDKYHD = json['DKD_KY_HD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MasterID'] = this.masterID;
    data['MasterType'] = this.masterType;
    data['Name'] = this.name;
    data['Code'] = this.code;
    data['MarketID'] = this.marketID;
    data['Note'] = this.note;
    data['CompanyID'] = this.companyID;
    data['DKD_TONG'] = this.dKDTONG;
    data['SDKDDHD'] = this.sDKDDHD;
    data['DKD_KY_HD'] = this.dKDKYHD;
    return data;
  }
}