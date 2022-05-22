class MarketDetail {
  int marketID;
  String marketCode;
  String marketName;
  String marketNameNN;
  num area;
  int marketTypeID;
  String marketTypeName;
  int region;
  int sDKDTTK;
  String contactName;
  String mobile;
  String email;
  String phone;
  String website;
  String address;
  String note;
  String qSDDC;
  String qDCNC;
  String hTKDTC;
  String pTKD;
  String dVDTXDC;
  String qHCDPDVC;
  bool isActive;
  int companyID;
  String companyName;
  int qSDDKDNN;
  int qSDDKDCNTC;
  String contractStartDate;
  String contractEndDate;
  int sDKDDHD;
  int sDKDLK;
  int sDKDCT;
  int sDKDTNN;
  int sTNCGCNDKKD;
  int sTNCGCNATTP;
  int sTNCKSK;
  int tHCSDKDDCT;
  int tHCSDKDTNTTKD;
  int tHCSHTTDKD;
  int tHCSHTNKD;
  int tHCDKDTNHD;
  int tHCDKDNHD;
  int tHCTNDHD;
  int tHCTNTNHD;
  int tHCTNNHD;
  int tHCNGUOIPHUVIEC;
  int tHCTNCOGCN;
  int tHCTNLHDKKD;
  int tHCTNKCGCN;
  int gCNATTPDaCap;
  int gCNATTPChuaCap;
  int cKATTPDaCap;
  int cKATTPChuaCap;
  num dKDDIENTICHMIN;
  num dKDDIENTICHMAX;
  int sLNGANHHANGKD;

  MarketDetail(
      {this.marketID,
        this.marketCode,
        this.marketName,
        this.marketNameNN,
        this.area,
        this.marketTypeID,
        this.marketTypeName,
        this.region,
        this.sDKDTTK,
        this.contactName,
        this.mobile,
        this.email,
        this.phone,
        this.website,
        this.address,
        this.note,
        this.qSDDC,
        this.qDCNC,
        this.hTKDTC,
        this.pTKD,
        this.dVDTXDC,
        this.qHCDPDVC,
        this.isActive,
        this.companyID,
        this.companyName,
        this.qSDDKDNN,
        this.qSDDKDCNTC,
        this.contractStartDate,
        this.contractEndDate,
        this.sDKDDHD,
        this.sDKDLK,
        this.sDKDCT,
        this.sDKDTNN,
        this.sTNCGCNDKKD,
        this.sTNCGCNATTP,
        this.sTNCKSK,
        this.tHCSDKDDCT,
        this.tHCSDKDTNTTKD,
        this.tHCSHTTDKD,
        this.tHCSHTNKD,
        this.tHCDKDTNHD,
        this.tHCDKDNHD,
        this.tHCTNDHD,
        this.tHCTNTNHD,
        this.tHCTNNHD,
        this.tHCNGUOIPHUVIEC,
        this.tHCTNCOGCN,
        this.tHCTNLHDKKD,
        this.tHCTNKCGCN,
        this.gCNATTPDaCap,
        this.gCNATTPChuaCap,
        this.cKATTPDaCap,
        this.cKATTPChuaCap,
        this.dKDDIENTICHMIN,
        this.dKDDIENTICHMAX,
        this.sLNGANHHANGKD});

  MarketDetail.fromJson(Map<String, dynamic> json) {
    marketID = json['MarketID'];
    marketCode = json['MarketCode'];
    marketName = json['MarketName'];
    marketNameNN = json['MarketName_NN'];
    area = json['Area'];
    marketTypeID = json['MarketTypeID'];
    marketTypeName = json['MarketTypeName'];
    region = json['Region'];
    sDKDTTK = json['SDKDTTK'];
    contactName = json['ContactName'];
    mobile = json['Mobile'];
    email = json['Email'];
    phone = json['Phone'];
    website = json['Website'];
    address = json['Address'];
    note = json['Note'];
    qSDDC = json['QSDDC'];
    qDCNC = json['QDCNC'];
    hTKDTC = json['HTKDTC'];
    pTKD = json['PTKD'];
    dVDTXDC = json['DVDTXDC'];
    qHCDPDVC = json['QHCDPDVC'];
    isActive = json['isActive'];
    companyID = json['CompanyID'];
    companyName = json['CompanyName'];
    qSDDKDNN = json['QSDDKDNN'];
    qSDDKDCNTC = json['QSDDKDCNTC'];
    contractStartDate = json['Contract_StartDate'];
    contractEndDate = json['Contract_EndDate'];
    sDKDDHD = json['SDKDDHD'];
    sDKDLK = json['SDKDLK'];
    sDKDCT = json['SDKDCT'];
    sDKDTNN = json['SDKDTNN'];
    sTNCGCNDKKD = json['STNCGCNDKKD'];
    sTNCGCNATTP = json['STNCGCNATTP'];
    sTNCKSK = json['STNCKSK'];
    tHCSDKDDCT = json['THC_SDKDDCT'];
    tHCSDKDTNTTKD = json['THC_SDKDTNTTKD'];
    tHCSHTTDKD = json['THC_SHTTDKD'];
    tHCSHTNKD = json['THC_SHTNKD'];
    tHCDKDTNHD = json['THC_DKD_TNHD'];
    tHCDKDNHD = json['THC_DKD_NHD'];
    tHCTNDHD = json['THC_TN_DHD'];
    tHCTNTNHD = json['THC_TN_TNHD'];
    tHCTNNHD = json['THC_TN_NHD'];
    tHCNGUOIPHUVIEC = json['THC_NGUOIPHUVIEC'];
    tHCTNCOGCN = json['THC_TN_CO_GCN'];
    tHCTNLHDKKD = json['THC_TN_LHDKKD'];
    tHCTNKCGCN = json['THC_TN_KC_GCN'];
    gCNATTPDaCap = json['GCN_ATTP_DaCap'];
    gCNATTPChuaCap = json['GCN_ATTP_ChuaCap'];
    cKATTPDaCap = json['CK_ATTP_DaCap'];
    cKATTPChuaCap = json['CK_ATTP_ChuaCap'];
    dKDDIENTICHMIN = json['DKD_DIENTICH_MIN'];
    dKDDIENTICHMAX = json['DKD_DIENTICH_MAX'];
    sLNGANHHANGKD = json['SL_NGANH_HANG_KD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MarketID'] = this.marketID;
    data['MarketCode'] = this.marketCode;
    data['MarketName'] = this.marketName;
    data['MarketName_NN'] = this.marketNameNN;
    data['Area'] = this.area;
    data['MarketTypeID'] = this.marketTypeID;
    data['MarketTypeName'] = this.marketTypeName;
    data['Region'] = this.region;
    data['SDKDTTK'] = this.sDKDTTK;
    data['ContactName'] = this.contactName;
    data['Mobile'] = this.mobile;
    data['Email'] = this.email;
    data['Phone'] = this.phone;
    data['Website'] = this.website;
    data['Address'] = this.address;
    data['Note'] = this.note;
    data['QSDDC'] = this.qSDDC;
    data['QDCNC'] = this.qDCNC;
    data['HTKDTC'] = this.hTKDTC;
    data['PTKD'] = this.pTKD;
    data['DVDTXDC'] = this.dVDTXDC;
    data['QHCDPDVC'] = this.qHCDPDVC;
    data['isActive'] = this.isActive;
    data['CompanyID'] = this.companyID;
    data['CompanyName'] = this.companyName;
    data['QSDDKDNN'] = this.qSDDKDNN;
    data['QSDDKDCNTC'] = this.qSDDKDCNTC;
    data['Contract_StartDate'] = this.contractStartDate;
    data['Contract_EndDate'] = this.contractEndDate;
    data['SDKDDHD'] = this.sDKDDHD;
    data['SDKDLK'] = this.sDKDLK;
    data['SDKDCT'] = this.sDKDCT;
    data['SDKDTNN'] = this.sDKDTNN;
    data['STNCGCNDKKD'] = this.sTNCGCNDKKD;
    data['STNCGCNATTP'] = this.sTNCGCNATTP;
    data['STNCKSK'] = this.sTNCKSK;
    data['THC_SDKDDCT'] = this.tHCSDKDDCT;
    data['THC_SDKDTNTTKD'] = this.tHCSDKDTNTTKD;
    data['THC_SHTTDKD'] = this.tHCSHTTDKD;
    data['THC_SHTNKD'] = this.tHCSHTNKD;
    data['THC_DKD_TNHD'] = this.tHCDKDTNHD;
    data['THC_DKD_NHD'] = this.tHCDKDNHD;
    data['THC_TN_DHD'] = this.tHCTNDHD;
    data['THC_TN_TNHD'] = this.tHCTNTNHD;
    data['THC_TN_NHD'] = this.tHCTNNHD;
    data['THC_NGUOIPHUVIEC'] = this.tHCNGUOIPHUVIEC;
    data['THC_TN_CO_GCN'] = this.tHCTNCOGCN;
    data['THC_TN_LHDKKD'] = this.tHCTNLHDKKD;
    data['THC_TN_KC_GCN'] = this.tHCTNKCGCN;
    data['GCN_ATTP_DaCap'] = this.gCNATTPDaCap;
    data['GCN_ATTP_ChuaCap'] = this.gCNATTPChuaCap;
    data['CK_ATTP_DaCap'] = this.cKATTPDaCap;
    data['CK_ATTP_ChuaCap'] = this.cKATTPChuaCap;
    data['DKD_DIENTICH_MIN'] = this.dKDDIENTICHMIN;
    data['DKD_DIENTICH_MAX'] = this.dKDDIENTICHMAX;
    data['SL_NGANH_HANG_KD'] = this.sLNGANHHANGKD;
    return data;
  }
}