import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testappfirst/untils/colors.dart';
import 'package:testappfirst/untils/dimensions.dart';

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
                  AppIcon(icon:Icons.home,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize28,
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

              ))
        ],
      ),
    );
  }
}
