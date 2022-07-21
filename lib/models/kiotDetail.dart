class KiotDetail {
  int kiotHBID;
  int kiotID;
  int kiotForRentID;
  String rentCode;
  int householdBusinessID;
  String nKDFullName;
  String nKDIDNo;
  String nKDEmail;
  String nKDPhone;
  String nKDAddress;
  String nKDTaxCode;
  String nKDLicenseNo;
  String nKDLicenseDate;
  String nKDContractNo;
  String nKDContractTypeName;
  String nKDFormName;

  KiotDetail(
      {this.kiotHBID,
        this.kiotID,
        this.kiotForRentID,
        this.rentCode,
        this.householdBusinessID,
        this.nKDFullName,
        this.nKDIDNo,
        this.nKDEmail,
        this.nKDPhone,
        this.nKDAddress,
        this.nKDTaxCode,
        this.nKDLicenseNo,
        this.nKDLicenseDate,
        this.nKDContractNo,
        this.nKDContractTypeName,
        this.nKDFormName});

  KiotDetail.fromJson(Map<String, dynamic> json) {
    kiotHBID = json['Kiot_HBID'];
    kiotID = json['KiotID'];
    kiotForRentID = json['KiotForRentID'];
    rentCode = json['RentCode'];
    householdBusinessID = json['HouseholdBusinessID'];
    nKDFullName = json['NKD_FullName'];
    nKDIDNo = json['NKD_IDNo'];
    nKDEmail = json['NKD_Email'];
    nKDPhone = json['NKD_Phone'];
    nKDAddress = json['NKD_Address'];
    nKDTaxCode = json['NKD_TaxCode'];
    nKDLicenseNo = json['NKD_LicenseNo'];
    nKDLicenseDate = json['NKD_LicenseDate'];
    nKDContractNo = json['NKD_ContractNo'];
    nKDContractTypeName = json['NKD_ContractTypeName'];
    nKDFormName = json['NKD_FormName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Kiot_HBID'] = this.kiotHBID;
    data['KiotID'] = this.kiotID;
    data['KiotForRentID'] = this.kiotForRentID;
    data['RentCode'] = this.rentCode;
    data['HouseholdBusinessID'] = this.householdBusinessID;
    data['NKD_FullName'] = this.nKDFullName;
    data['NKD_IDNo'] = this.nKDIDNo;
    data['NKD_Email'] = this.nKDEmail;
    data['NKD_Phone'] = this.nKDPhone;
    data['NKD_Address'] = this.nKDAddress;
    data['NKD_TaxCode'] = this.nKDTaxCode;
    data['NKD_LicenseNo'] = this.nKDLicenseNo;
    data['NKD_LicenseDate'] = this.nKDLicenseDate;
    data['NKD_ContractNo'] = this.nKDContractNo;
    data['NKD_ContractTypeName'] = this.nKDContractTypeName;
    data['NKD_FormName'] = this.nKDFormName;
    return data;
  }
}