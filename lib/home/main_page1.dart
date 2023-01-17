import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:testappfirst/home/page_body1.dart';
import 'package:testappfirst/untils/colors.dart';
import 'package:testappfirst/widgets/big_taxt.dart';
import 'package:testappfirst/widgets/small_text.dart';
import 'package:testappfirst/untils/dimensions.dart';

import '../controllers/popular_product_contr.dart';
import '../controllers/recommended_product_contr.dart';


class MainFoodPage extends StatefulWidget {
  const  MainFoodPage ({Key? key}) : super(key: key);

  @override
  _MainFoodPageState createState() =>  _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }
  @override
  Widget build(BuildContext context) {
    //print("current height is "+MediaQuery.of(context).size.height.toString());
    return RefreshIndicator(
        onRefresh:_loadResource,
        child: Column(
      children: [
        //Відображення шапки
        Container(
          child: Container(

            margin: EdgeInsets.only(top: Dimensions.height45, bottom: Dimensions.height15),
            padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(text: "Ukraine", color: AppColors.mainColor, size: 25,),
                    Row(
                      children: [
                        SmallText(text: "Zhytomyr", color: Colors.black54,),
                        Icon(Icons.arrow_drop_down_rounded)
                      ],
                    )
                  ],
                ),
                Center(
                  child: Container(
                    width: Dimensions.height45,
                    height: Dimensions.height45,
                    child: Icon(Icons.search, color:Colors.white, size: Dimensions.iconSize28,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: AppColors.mainColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        //Відображення тіла головного вікна
        Expanded(child: SingleChildScrollView(
          child:  FoodPageBody(),
        ))
      ],
    ) );
  }
}
