import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:testappfirst/controllers/cart_controller.dart';
import 'package:testappfirst/untils/app_constants.dart';
import 'package:testappfirst/untils/dimensions.dart';
import 'package:testappfirst/widgets/app_icon.dart';
import 'package:testappfirst/widgets/big_taxt.dart';
import 'package:testappfirst/widgets/small_text.dart';

import '../../untils/colors.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList=Get.find<CartController>()
        .getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder=Map();

    for(int i=0; i<getCartHistoryList.length; i++)
    {
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time)){
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value)=>++value);
      }
      else{
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!,()=>1);
      }
    }

    List<int> cartOrderTimeToList(){
      return cartItemsPerOrder.entries.map((e)=>e.value).toList();
      //return cartItemsPerOrder.entries.map((e){
      // return e.value;

      //}).toList();
    }

    List<int> itemsPerOrder=cartOrderTimeToList();
    //print(orderTimes);
    var listCounter=0;
    return Scaffold(

      body: Column(
        children: [
          Container(
            height: Dimensions.height10*10,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimensions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: "Історія Замовлень", color: Colors.white),
                AppIcon(icon: Icons.shopping_cart_outlined,
                  iconColor: AppColors.mainColor,
                  backgroundColor: AppColors.yellowColor,
                )
              ],
            ),
          ),
          Expanded(
              child:
              Container(
                margin: EdgeInsets.only(
                top: Dimensions.height20,
                left: Dimensions.width20,
                right: Dimensions.width20
                ),
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView(
                    children: [
                      for(int i=0; i<itemsPerOrder.length; i++)
                        Container(
                          height: Dimensions.height30*4,
                          margin: EdgeInsets.only(bottom: Dimensions.height20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ((){
                                DateTime parseDate=DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCounter].time!);
                                var inputDate=DateTime.parse(parseDate.toString());
                                var outputFormat=DateFormat("dd/MM/yyyy HH:mm");
                                var outputDate=outputFormat.format(inputDate);
                                return BigText(text: outputDate,);
                              }()),
                              SizedBox(height: Dimensions.height10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                    direction: Axis.horizontal,
                                    children: List.generate(itemsPerOrder[i], (index){
                                      if(listCounter<getCartHistoryList.length){
                                        listCounter++;
                                      }
                                      return index<=2?Container(
                                        height: Dimensions.height20*4.25,
                                        width: Dimensions.height20*4.25,
                                        margin: EdgeInsets.only(right: Dimensions.width10/2),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimensions.radius15/2),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  AppConstants.BASE_URL+AppConstants.UPLOAD_URL+getCartHistoryList[listCounter-1].img!,
                                                )
                                            )
                                        ),
                                      ):Container();
                                    }),
                                  ),
                                  Container(

                                    height: Dimensions.height20*4,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SmallText(text: "Total", color: AppColors.titleColor,),
                                        BigText(
                                          text: itemsPerOrder[i].toString()+" Items",
                                          color: AppColors.titleColor,),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: Dimensions.width10,
                                          vertical: Dimensions.height10/2),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                                            border: Border.all(width: 1, color: AppColors.mainColor),

                                          ),
                                          child: SmallText(text: "one more", color: AppColors.mainColor,),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )

                    ],
                  ),)
          ))
        ],
      ),
    );
  }
}
