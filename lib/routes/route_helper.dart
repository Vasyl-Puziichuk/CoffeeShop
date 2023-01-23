import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:testappfirst/home/main_page1.dart';
import 'package:testappfirst/pages/food/popular_details.dart';

import '../home/home_page.dart';
import '../pages/address/add_address_page.dart';
import '../pages/address/pick_address_map.dart';
import '../pages/auth/sing_in_page.dart';
import '../pages/auth/sing_up_page.dart';
import '../pages/cart/cart_page.dart';
import '../pages/food/recommended_food_details.dart';
import '../pages/splash/splash_page.dart';
class RouteHelper{
  static const String splashPage="/splash-page";
  static const String initial="/";
  static const String popularFood="/popular-food";
  static const String recommendedFood="/recommended-food";
  static const String cartPage="/cart-page";
  static const String signIn="/sign-in";

  static const String addAddress="/add-address";
  static const String pickAddressMap="/pick-address";

  static String getSplashPage()=>'$splashPage';
  static String getInitial()=>'$initial';
  static String getPopularFood(int pageId, String page)=>'$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page)=>'$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage()=>'$cartPage';
  static String getSignInPage()=>'$signIn';
  static String getAddressPage()=>'$addAddress';
  static String getPickAddressPage()=>'$pickAddressMap';

  static List<GetPage> routes=[
    GetPage(name: pickAddressMap, page: (){
      PickAddressMap _pickAddress= Get.arguments;
      return _pickAddress;
    }),
    GetPage(name: splashPage, page: ()=>SplashScreen()),
    GetPage(name: initial, page: (){
      return HomePage();
    }, transition: Transition.fade),

    GetPage(name: signIn, page: (){
      return SignInPage();
    }, transition: Transition.fade),

    GetPage(name: popularFood, page: (){
      var pageId=Get.parameters['pageId'];
      var page=Get.parameters["page"];
      return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
    },
        transition: Transition.fadeIn
    ),

    GetPage(name: recommendedFood, page: (){
      var pageId=Get.parameters['pageId'];
      var page=Get.parameters["page"];
      return RecommendedFoodDetail(pageId: int.parse(pageId!), page: page!);
    },
        transition: Transition.fadeIn
    ),

    GetPage(name: cartPage, page: (){
      return CartPage();
    },
    transition: Transition.fadeIn),

    GetPage(name: addAddress, page:(){
      return AddAddressPage();
    })
  ];
}
