import 'package:testappfirst/data/api/api_client.dart';
import 'package:get/get.dart';

import '../controllers/popular_product_contr.dart';
import '../controllers/recommended_product_contr.dart';
import '../data/repository/popular_product_repo.dart';
import '../../untils/app_constants.dart';
import '../data/repository/recommended_product_repo.dart';

Future<void> init()async{
  //api client
  Get.lazyPut(()=>ApiClient(appBaseUrl: AppConstants.BASE_URL));
  //"http://mvs.bslmeiyu.com";

  //repos
  Get.lazyPut(()=>PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(()=>RecommendedProductRepo(apiClient: Get.find()));

  //controllers
  Get.lazyPut(()=>PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(()=>RecommendedProductController(recommendedProductRepo: Get.find()));


}