import 'package:get/get.dart';
import 'package:testappfirst/base/show_custom_snack_bar.dart';
import 'package:testappfirst/routes/route_helper.dart';

class ApiChecker {
  static void checkApi(Response response){
    if(response.statusCode==401){
      Get.offNamed(RouteHelper.getSignInPage());

    }
    else{
      showCustomSnackBar(response.statusText!);
    }
  }
}