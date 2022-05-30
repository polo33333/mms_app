import '../models/district.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfig {

  //static final _baseUrl = 'http://103.226.248.147:90/api/v1';
  //static final _baseUrl = 'http://103.226.248.147:89/api/v1';
  //static final _baseUrl = 'http://localhost:52751/api/v1';
  static final marketGetAll =   '/market/getAll';
  static final marketGetById = '/market/getById/';
  static final contractGetByMarketId =  '/Contract/GetByMarketId/';
  static final kiotForRentGetAll =  '/KiotForRent/getAll';
  static final kiotForRentGetByMarketId =  '/KiotForRent/GetByMarketId/';
  static final kiotForRentGetByRegionId = '/KiotForRent/GetByRegionId/';

  static final householdBusinessGetall =  '/householdBusiness/getAll';
  static final getByRegionIdAndMarketId = '/householdBusiness/GetByRegionIdAndMarketId/';
  static final kiotGetall =  '/kiot/getAll';
  static final regionGetByMarketId  =  '/region/getbymarketid/';
  static final kiotGetByRegionId  =  '/kiot/GetByRegionId/';
  static final productGroupGetByMarketId  =  '/ProductGroup/GetByMarketId/';
  static final nodata = 'Dữ liệu trống';

  static final URL_CREATEFCM =   "/FCM/SaveToken";
  static final URL_SIGNIN =  "/Auth/SignIn";
  static final URL_VERIFY =  "/Auth/Verify";
  static final URL_CHANGEPASSWORD =  "/Auth/ChangePassword";
  static final URL_GETINFOEMPLOYEE =  "/Auth/GetInfoEmployee/?token=";
  static final URL_GETNOTIFICATION = "/Notification/GetNotification/?token=";
  static final URL_REMOVENOTIFICATION =  "/Notification/REMOVENotification/?id=";
  static final URL_SIGNOUT =  "/Auth/SignOut/?token=";
  static final URL_GETGENNERALINFO =  "/Genneral/GetInfo";

  //key
  static final FCM_token = 'FCM_TOKEN';
  static final districtId = 'DISTRICTID';
  static final login = 'NO';

  static List<District> generalDistrictList (){
    List<District> _districtList = [];
    _districtList.add(District(id: 1, name: 'Quận Phú Nhuận', isSelected: true, url: "http://103.226.248.147:89/api/v1"));
    _districtList.add(District(id: 2, name: 'Quận Bình Thạnh', isSelected: false,  url: "http://103.226.248.147:90/api/v1"));
    return  _districtList;
  }

  static  setDistrictList () {
    return  generalDistrictList();
  }


  static  choseApiHost() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int districtId = prefs.getInt(AppConfig.districtId) ?? 0;
    List<District> _districtList = generalDistrictList();
    for(int i = 0; i< _districtList.length; i++){
      if( _districtList[i].id == districtId)
        return _districtList[i].url;
    }
  }
}
