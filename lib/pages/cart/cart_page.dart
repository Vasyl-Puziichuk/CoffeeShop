import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testappfirst/controllers/popular_product_contr.dart';
import 'package:testappfirst/home/main_page1.dart';
import 'package:testappfirst/untils/app_constants.dart';
import 'package:testappfirst/untils/colors.dart';
import 'package:testappfirst/untils/dimensions.dart';
import 'package:testappfirst/widgets/big_taxt.dart';
import 'package:testappfirst/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/recommended_product_contr.dart';
import '../../routes/route_helper.dart';
import '../../widgets/app_icon.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: Dimensions.height20*3,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(icon:Icons.arrow_back,
                    iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize28,
                  ),
                  SizedBox(width: Dimensions.width20*5,),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(icon:Icons.home,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize28,
                    ),
                  ),
                  AppIcon(icon:Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize28,
                  )
                ],
              )),
          Positioned(
              top: Dimensions.height20*5,
              left: Dimensions.width20,
              right: Dimensions.width20,
              bottom: 0,
              child: Container(
                margin: EdgeInsets.only(top: Dimensions.height15),
                //color: Colors.red,
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(builder: (cartControlle){
                    var _cartList= cartControlle.getItems;
                    return ListView.builder(
                        itemCount: _cartList.length,
                        itemBuilder: (_, index){
                          return Container(
                            width: double.maxFinite,
                            height: Dimensions.height20*5,
                            child: Row(
                              children: [
                                //контейнер з картинками товарів
                                GestureDetector(
                                  onTap:(){
                                    var popularIndex=Get.find<PopularProductController>()
                                        .popularProductList
                                        .indexOf(_cartList[index].product!);
                                    if(popularIndex>=0){
                                      Get.toNamed(RouteHelper.getPopularFood(popularIndex));
                                    }
                                    else{
                                      var recommendedIndex=Get.find<RecommendedProductController>()
                                          .recommendedProductList
                                          .indexOf(_cartList[index].product!);
                                      Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex));
                                    }
                                    },
                                  child: Container(
                                    width: Dimensions.height20*5,
                                    height: Dimensions.height20*5,
                                    margin: EdgeInsets.only(bottom: Dimensions.height10),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image:NetworkImage(
                                              AppConstants.BASE_URL+AppConstants.UPLOAD_URL+cartControlle.getItems[index].img!
                                            )
                                        ),
                                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                                SizedBox(width: Dimensions.width10,),
                                Expanded(
                                    child: Container(
                                      height: Dimensions.height20*5,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          BigText(text: cartControlle.getItems[index].name!, color: Colors.black54,),
                                          SmallText(text: "Spicy"),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(text: '\₴ ${cartControlle.getItems[index].price.toString()}', color: Colors.redAccent),
                                              Container(
                                                padding: EdgeInsets.only(top: Dimensions.height10,
                                                    bottom: Dimensions.height10, left:Dimensions.width10,
                                                    right: Dimensions.width10),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                  color: Colors.white,
                                                ),
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                        onTap: (){
                                                          //popularProduct.setQuantity(false);
                                                          cartControlle.addItem(_cartList[index].product!, -1);
                                                        },
                                                        child: Icon(Icons.remove, color: AppColors.signColor,)),
                                                    SizedBox(width: Dimensions.width10/2,),
                                                    BigText(text: _cartList[index].quantity.toString()),//popularProduct.inCartItems.toString()),
                                                    SizedBox(width: Dimensions.width10/2,),
                                                    GestureDetector(
                                                        onTap: (){
                                                          //popularProduct.setQuantity(true);
                                                          cartControlle.addItem(_cartList[index].product!, 1);
                                                          print("tap tap");
                                                        },
                                                        child: Icon(Icons.add, color: AppColors.signColor,)),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          );

                        });
                  }),
                )
              ))
        ],
      ),
    );
  }
}
