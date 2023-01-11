import 'package:testappfirst/data/api/api_client.dart';
import 'package:testappfirst/data/api/api_client.dart';
import 'package:get/get.dart';

import '../controllers/popular_product_contr.dart';
import '../data/repository/popular_product_repo.dart';

Future<void> init()async{
  //api client
  Get.lazyPut(()=>ApiClient(appBaseUrl: "https://github.com/Vasyl-Puziichuk"));

  //repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));

  //controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo:
                                                          Get.find()));


}