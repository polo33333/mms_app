class AppConfig {
  //static final _baseUrl = 'http://103.226.248.147:90/api/v1';
  static final _baseUrl = 'http://103.226.248.147:89/api/v1';
  //static final _baseUrl = 'http://localhost:52751/api/v1';
  static final marketGetAll = _baseUrl + '/market/getAll';
  static final marketGetById = _baseUrl + '/market/getById/';
  static final contractGetByMarketId = _baseUrl + '/Contract/GetByMarketId/';
  static final kiotForRentGetAll = _baseUrl + '/KiotForRent/getAll';
  static final kiotForRentGetByMarketId = _baseUrl + '/KiotForRent/GetByMarketId/';
  static final kiotForRentGetByRegionId = _baseUrl + '/KiotForRent/GetByRegionId/';

  static final householdBusinessGetall = _baseUrl + '/householdBusiness/getAll';
  static final getByRegionIdAndMarketId = _baseUrl + '/householdBusiness/GetByRegionIdAndMarketId/';
  static final kiotGetall = _baseUrl + '/kiot/getAll';
  static final regionGetByMarketId  = _baseUrl + '/region/getbymarketid/';
  static final kiotGetByRegionId  = _baseUrl + '/kiot/GetByRegionId/';
  static final productGroupGetByMarketId  = _baseUrl + '/ProductGroup/GetByMarketId/';
  static final nodata = 'Dữ liệu trống';

  static final URL_CREATEFCM = _baseUrl + "/FCM/SaveToken";
  static final URL_SIGNIN = _baseUrl + "/Auth/SignIn";
  static final URL_VERIFY = _baseUrl + "/Auth/Verify";
  static final URL_CHANGEPASSWORD = _baseUrl + "/Auth/ChangePassword";
  static final URL_GETINFOEMPLOYEE = _baseUrl + "/Auth/GetInfoEmployee/?token=";
  static final URL_GETNOTIFICATION = _baseUrl + "/Notification/GetNotification/?token=";
  static final URL_REMOVENOTIFICATION = _baseUrl + "/Notification/REMOVENotification/?id=";
  static final URL_SIGNOUT = _baseUrl + "/Auth/SignOut/?token=";
  static final URL_GETGENNERALINFO = _baseUrl + "/Genneral/GetInfo";
  //key
  static final FCM_token = 'FCM_TOKEN';
  static final login = 'NO';
}
