class ProductGroup {
  int productGroupID;
  String productGroupCode;
  String productGroupName;
  int regionID;
  int fieldID;
  String note;
  int companyID;
  int tHCTNTONG;
  int tHCTNDHD;

  ProductGroup(
      {this.productGroupID,
        this.productGroupCode,
        this.productGroupName,
        this.regionID,
        this.fieldID,
        this.note,
        this.companyID,
        this.tHCTNTONG,
        this.tHCTNDHD});

  ProductGroup.fromJson(Map<String, dynamic> json) {
    productGroupID = json['ProductGroupID'];
    productGroupCode = json['ProductGroupCode'];
    productGroupName = json['ProductGroupName'];
    regionID = json['RegionID'];
    fieldID = json['FieldID'];
    note = json['Note'];
    companyID = json['CompanyID'];
    tHCTNTONG = json['THC_TN_TONG'];
    tHCTNDHD = json['THC_TN_DHD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProductGroupID'] = this.productGroupID;
    data['ProductGroupCode'] = this.productGroupCode;
    data['ProductGroupName'] = this.productGroupName;
    data['RegionID'] = this.regionID;
    data['FieldID'] = this.fieldID;
    data['Note'] = this.note;
    data['CompanyID'] = this.companyID;
    data['THC_TN_TONG'] = this.tHCTNTONG;
    data['THC_TN_DHD'] = this.tHCTNDHD;
    return data;
  }
}