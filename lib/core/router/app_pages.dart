import 'package:booksea/ui/pages/profile/collection/collection_controller.dart';
import 'package:booksea/ui/pages/profile/collection/collection_view.dart';
import 'package:booksea/ui/pages/profile/mypublish/mypublish_controller.dart';
import 'package:booksea/ui/pages/profile/mypublish/mypublish_view.dart';
import 'package:booksea/ui/pages/profile/setting/settingPage/resetPwd.dart';
import 'package:booksea/ui/pages/profile/setting/settingPage/seller_setting.dart';
import 'package:get/get.dart';

import 'package:booksea/ui/pages/profile/follows/follows_view.dart';
import 'package:booksea/ui/pages/qrscan/QRController.dart';
import 'package:booksea/ui/pages/qrscan/qr_code_scan.dart';
import 'package:booksea/ui/pages/category/cateSearch/catesearch_binding.dart';
import 'package:booksea/ui/pages/category/cateSearch/catesearch_view.dart';
import 'package:booksea/ui/pages/publish/publish_binding.dart';
import 'package:booksea/ui/pages/publish/publish_view.dart';
import 'package:booksea/ui/pages/seller/seller_binding.dart';
import 'package:booksea/ui/pages/seller/seller_view.dart';
import 'package:booksea/ui/pages/commodity/commodity_binding.dart';
import 'package:booksea/ui/pages/commodity/commodity_view.dart';
import 'package:booksea/ui/pages/book/book_binding.dart';
import 'package:booksea/ui/pages/book/book_view.dart';
import 'package:booksea/ui/pages/home/home_view.dart';
import 'package:booksea/ui/pages/home/search/search_binding.dart';
import 'package:booksea/ui/pages/home/search/search_view.dart';
import 'package:booksea/ui/pages/login/login_binding.dart';
import 'package:booksea/ui/pages/login/login_view.dart';
import 'package:booksea/ui/pages/profile/profile_view.dart';
import 'package:booksea/ui/pages/main/main.dart';
import 'package:booksea/ui/pages/splash/splash_view.dart';
import 'package:booksea/ui/pages/profile/setting/setting_binding.dart';
import 'package:booksea/ui/pages/profile/setting/setting_view.dart';
import 'package:booksea/ui/pages/profile/orderManage/order_binding.dart';
import 'package:booksea/ui/pages/profile/orderManage/order_view.dart';
import 'package:booksea/ui/pages/login/register/register_binding.dart';
import 'package:booksea/ui/pages/login/register/register_view.dart';
import 'package:booksea/ui/pages/category/category_view.dart';
import 'package:booksea/ui/pages/home/booklist/booklist_binding.dart';
import 'package:booksea/ui/pages/home/booklist/booklist_view.dart';
import 'package:booksea/ui/pages/home/booklist/listdetail/list_detail_binding.dart';
import 'package:booksea/ui/pages/home/booklist/listdetail/list_detail_view.dart';
import 'package:booksea/ui/pages/cart/cart_view.dart';
import 'package:booksea/ui/pages/profile/follows/follows_controller.dart';
import 'package:booksea/ui/pages/profile/sellOrderManage/sell_order_controller.dart';
import 'package:booksea/ui/pages/profile/sellOrderManage/sell_order_view.dart';
import 'package:booksea/ui/pages/profile/setting/settingPage/account_setting.dart';
import 'package:booksea/ui/pages/profile/setting/settingPage/user_info.dart';

abstract class AppPages {
  static const SPLASH = "/splash";
  static const INITIAL_ROUTE = "/";
  static const HOME = "/home";
  static const PROFILE = "/profile";
  static const CATEGORY = "/category";
  static const LOGIN = "/login";
  static const REGISTER = "/register";
  static const CART = "/cart";
  static const SETTING = "/setting";
  static const ALLORDER = "/allorder";
  static const SELLORDER = "/sellorder";
  static const SEARCH = "/search";
  static const BOOKLIST = "/booklist";
  static const LISTDETAIL = "/listdetail";
  static const BOOK = "/bookInfo";
  static const COMMODITY = "/commodity";
  static const CATESEARCH = "/cateSearch";
  static const SELLER = "/seller";
  static const PUBLISH = "/publish";
  static const MAIN = "/MAIN";
  static const QRSCAN = "/scan";
  static const FOLLOWS = "/follows";
  static const ACCOUNTSET = "/accountset";
  static const EDITUSERINFO = "/editUserInfo";
  static const COLLECTION = "/collection";
  static const MYPUBLISH = "/myPublish";
  static const SELLERSET = '/sellerset';
  static const RESETPWD = '/resetpwd';

  static final pages = [
    GetPage(
      name: SPLASH,
      page: () => SplashPage(),
    ),
    GetPage(
      name: INITIAL_ROUTE,
      page: () => MainPage(),
      transition: Transition.fade,
      transitionDuration: Duration(milliseconds: 500)
    ),

    GetPage(
      name: MAIN,
      page: () => MainPage(),
    ),
   //?????????
    GetPage(
        name: QRSCAN,
        page: () => QRScanView(),
        binding: BindingsBuilder(() {
          Get.lazyPut<QRController>(() => QRController());
        }),
        transition: Transition.cupertino
    ),

    //??????
    GetPage(
      name: HOME,
      page: () => HomeView(),
    ),
    //?????????
    GetPage(
      name: SEARCH,
      binding: SearchBinding(),
      page: () => SearchView(),
      transition: Transition.cupertino
    ),
    //?????????
    GetPage(
        name: BOOKLIST,
        binding: BookListBinding(),
        page: () => BookListView(),
        transition: Transition.cupertino
    ),
    GetPage(
        name: BOOKLIST,
        binding: BookListBinding(),
        page: () => BookListView(),
        transition: Transition.cupertino
    ),
    GetPage(
        name: LISTDETAIL,
        binding: ListDetailBinding(),
        page: () => ListDetailView(),
        transition: Transition.cupertino
    ),

    // ???????????????
    GetPage(
        name: BOOK,
        binding: BookBinding(),
        page: () => BookView(),
        transition: Transition.cupertino
    ),
    // ???????????????
    GetPage(
        name: COMMODITY,
        binding: CommodityBinding(),
        page: () => CommodityView(),
        transition: Transition.cupertino
    ),

    //??????
    GetPage(
        name: CATEGORY,
        page: () => CategoryView(),
    ),
    //????????????
    GetPage(
      name: CATESEARCH,
      binding: CateSearchBinding(),
      page: () => CateSearchView(),
      transition: Transition.cupertino
    ),

    //?????????
    GetPage(
      name: CART,
      page: () => CartView(),
    ),

    //????????????
    GetPage(
        name: SELLER,
        binding: SellerBinding(),
        page: () => SellerView(),
        transition: Transition.cupertino
    ),


    //????????????
    GetPage(
      name: LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
      transition: Transition.cupertino
    ),
    //??????
    GetPage(
      name: REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding()
    ),
   //????????????
    GetPage(
      name: PROFILE,
      page: () => ProfileView(),
    ),
    //??????
    GetPage(
      name: SETTING,
      page: () => SettingView(),
      binding: SettingBinding(),
      transition: Transition.cupertino
    ),
    //????????????
    GetPage(
        name: ALLORDER,
        page: () => OrderView(),
        binding: OrderBinding(),
        transition: Transition.cupertino
    ),
    //????????????
    GetPage(
        name: SELLORDER,
        binding: BindingsBuilder(() {
          Get.lazyPut<SellOrderController>(() => SellOrderController());
        }),
        page: () => SellOrderView(),
        transition: Transition.cupertino
    ),
    //????????????
    GetPage(
        name: PUBLISH,
        page: () => PublishView(),
        binding: PublishBinding(),
        transition: Transition.cupertino
    ),
    //????????????
    GetPage(
        name: FOLLOWS,
        page: () => FollowsView(),
        binding: BindingsBuilder(() {
          Get.lazyPut<FollowsController>(() => FollowsController());
        }),
        transition: Transition.cupertino
    ),
    //????????????
    GetPage(
        name: COLLECTION,
        page: () => CollectionView(),
        binding: BindingsBuilder(() {
          Get.lazyPut<CollectionController>(() => CollectionController());
        }),
        transition: Transition.cupertino
    ),
    //????????????
    GetPage(
        name: MYPUBLISH,
        page: () => MyPublishView(),
        binding: BindingsBuilder(() {
          Get.lazyPut<MyPublishController>(() => MyPublishController());
        }),
        transition: Transition.cupertino
    ),
    //????????????
    GetPage(
        name: ACCOUNTSET,
        page: () => AccountSetView(),
        binding: BindingsBuilder(() {
          Get.lazyPut<AccountSetController>(() => AccountSetController());
        }),
        transition: Transition.cupertino
    ),
    //??????????????????
    GetPage(
        name: EDITUSERINFO,
        page: () => UserInfoView(),
        binding: BindingsBuilder(() {
          Get.lazyPut<UserInfoController>(() => UserInfoController());
        }),
        transition: Transition.cupertino
    ),
    //??????????????????
    GetPage(
        name: SELLERSET,
        page: () => SellerSetView(),
        binding: BindingsBuilder(() {
          Get.put<SellerSetController>(SellerSetController());
        }),
        transition: Transition.cupertino
    ),
    //????????????
    GetPage(
        name: RESETPWD,
        page: () => ResetPwdView(),
        binding: BindingsBuilder(() {
          Get.put<ResetPwdController>(ResetPwdController());
        }),
        transition: Transition.cupertino
    ),

  ];

  static void routingCallBack(Routing route) {

  }
}



