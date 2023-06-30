import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://developmentalphawizz.com/coupan-trading/app/v1/api/";
  static const String baseUrl1 = "https://developmentalphawizz.com/dr_booking/user/app/v1/api/";
  static const String imageUrl = "https://developmentalphawizz.com/dr_booking/";


  static const String register_user = baseUrl+'register_user';
  static const String login = baseUrl+'login';
  static const String get_coupans = baseUrl+'get_coupans';
  static const String get_coupans_detail = baseUrl+'get_graph_data';

  static const String getBooking = baseUrl+'bookings';
  static const String sendOTP = baseUrl+'v_send_otp';
  static const String getupdateUser = baseUrl+'update_user';
  static const String verifyOtp = baseUrl+'v_verify_otp';
  static const String getSlider = baseUrl + 'get_slider_images';
  static const String getPharmaSlider = baseUrl + 'get_slider';
  static const String getUserProfile = baseUrl+'user_profile';
  static const String getEvents = baseUrl+'get_events';
    static const String getWebinar = baseUrl+'get_webinar';
  static const String getNewType = baseUrl+'get_news_type';
  static const String getfaq = baseUrl+'getfaq';

  static const String privacy = baseUrl+'privacy';
  static const String termsAndCondition = baseUrl+'terms';

  static const String selectCategory = baseUrl+'select_category';
  static const String getCounting = baseUrl+'get_counting';
  static const String getEditorial = baseUrl+'get_editorial';
  static const String addDoctorNews = baseUrl+'add_doctor_news';
  static const String addDoctorAwreness = baseUrl+'add_awareness';
  static const String addDoctorWebiner = baseUrl+'add_doctor_webinar';
  static const String addDoctorEditorial = baseUrl+'add_doctor_editorial';
  static const String addDoctorEvent = baseUrl+'add_doctor_event';
  static const String getAwareness = baseUrl+'get_awareness';
  static const String getSettings = baseUrl+'get_settings';
  static const String getPharmaCategory = baseUrl+'select_category';
  static const String getPharmaProductsCategory = baseUrl+'pharma_category';
  static const String getPharmaProductsCategoryNew = baseUrl+'get_categories_product';
  static const String getPharmaProducts = baseUrl+'get_products';
  static const String getUserCart = baseUrl+'get_user_cart';
  static const String getPlaceOrderApi = baseUrl+'place_order';
  static const String getRemoveCartApi = baseUrl+'remove_from_cart';
  static const String getManageCartApi = baseUrl+'manage_cart';

  static const String pricing = baseUrl+"pricing";
  static const String contactus = baseUrl+"contactus";

  static const String refund = baseUrl+"refund";
  static const String govern = baseUrl+"govern";

  static const String gethelp = baseUrl+"gethelp";
  static const String getstarted = baseUrl+"getstarted";
  static const String socialmedia = baseUrl+"socialmedia";


  static const String aboutus = baseUrl+"aboutus";
  static const String addDoctorWebinar = baseUrl+'add_doctor_webinar';
  static const String addNewWishListApi = baseUrl+'add_news_wishlist';
  static const String getNewsWishListApi = baseUrl+'get_news_wishlist';
  static const String getRemoveWishListApi = baseUrl+'remove_wishlist';
  static const String addProductApi = baseUrl+'add_products';
  static const String getHistoryApi = baseUrl+'get_user_history';
  static const String getHistoryDeleteApi = baseUrl+'delete_data';
  static const String getCompaniesApi = baseUrl+'get_companies';
  static const String getCompaniesDropApi = baseUrl+'get_company';
  static const String getStateApi = baseUrl1+'get_states';
  static const String getCityApi = baseUrl1+'get_cities';
  static const String getPlaceApi = baseUrl1+'get_places';
  static const String getSubsriptionApi = baseUrl+'get_plans';
    static const String getPlanPurchasApi = baseUrl+'plan_purchase_success';
    static const String getCheckSubscriptionApi = baseUrl+'check_subscription';
    static const String getUploadBannerApi = baseUrl+'upload_banner';
}
