import 'package:testappfirst/data/api/api_client.dart';
import 'package:get/get.dart';

import '../../untils/app_constants.dart';


class RecommendedProductRepo extends GetxService{
  final ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient,});

  Future<Response> getRecommendedProductList() async{
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
    //api/v1/products/popular
  }
}