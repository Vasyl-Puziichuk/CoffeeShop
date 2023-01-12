import 'package:get/get.dart';
import 'package:testappfirst/home/main_page1.dart';
import 'package:testappfirst/pages/food/popular_details.dart';
class RouteHelper{
  static const String initial="/";
  static const String popularFood="/popular-food";

  static List<GetPage> routes=[
    GetPage(name: "/", page: ()=>MainFoodPage()),
    GetPage(name: popularFood, page: (){
      //print("popular food get called");
      return PopularFoodDetail();
    }),
  ];
}