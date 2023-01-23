import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:testappfirst/controllers/cart_controller.dart';
import 'package:testappfirst/controllers/popular_product_contr.dart';
import 'package:testappfirst/home/main_page1.dart';
import 'package:testappfirst/pages/auth/sing_in_page.dart';
import 'package:testappfirst/pages/auth/sing_up_page.dart';
import 'package:testappfirst/pages/cart/cart_page.dart';
import 'package:testappfirst/pages/food/popular_details.dart';
import 'package:testappfirst/pages/food/recommended_food_details.dart';
import 'package:testappfirst/pages/splash/splash_page.dart';
import 'package:testappfirst/routes/route_helper.dart';
import 'package:testappfirst/untils/colors.dart';
import 'controllers/recommended_product_contr.dart';
import 'helper/dependencies.dart' as dep;
import 'home/page_body1.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}): super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_){
      return GetBuilder<RecommendedProductController>(builder: (_){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
            //home: SignInPage(),
          //home: SplashScreen(),
         initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
            theme: ThemeData(
            primaryColor: AppColors.mainColor,
            fontFamily: "Lato",
          ),
        );
      });
    });
  }
}

