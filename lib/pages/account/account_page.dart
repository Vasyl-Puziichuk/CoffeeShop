import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:testappfirst/controllers/auth_controller.dart';
import 'package:testappfirst/controllers/cart_controller.dart';
import 'package:testappfirst/controllers/user_controller.dart';
import 'package:testappfirst/untils/colors.dart';
import 'package:testappfirst/widgets/app_icon.dart';
import 'package:testappfirst/widgets/big_taxt.dart';

import '../../base/custom_loader.dart';
import '../../routes/route_helper.dart';
import '../../untils/dimensions.dart';
import '../../widgets/account_widget.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();

    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title:   BigText(
            text: "Профіль", size: 24, color: Colors.white,
          ),
        ),


      body: GetBuilder<UserController>(builder: (userController){
        return _userLoggedIn?
        (userController.isLoading?Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: Dimensions.height20),
          child: Column(

            children: [
              //іконка профілю
              AppIcon(
                icon: Icons.person,
                backgroundColor: AppColors.mainColor,
                iconColor: Colors.white,
                iconSize: Dimensions.height45+Dimensions.height30,
                size: Dimensions.height15*10,
              ),
              SizedBox(height: Dimensions.height30,),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //ім'я
                      AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.person,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5,
                        ),
                        bigText: BigText(text: userController.userModel.name),
                      ),
                      SizedBox(height: Dimensions.height20,),
                      //телефон
                      AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.phone,
                          backgroundColor: AppColors.yellowColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5,
                        ),
                        bigText: BigText(text: userController.userModel.phone),
                      ),
                      SizedBox(height: Dimensions.height20,),
                      //пошта
                      AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.email,
                          backgroundColor: AppColors.yellowColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5,
                        ),
                        bigText: BigText(text: userController.userModel.email),
                      ),
                      SizedBox(height: Dimensions.height20,),
                      //адреса
                      AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.location_on,
                          backgroundColor: AppColors.yellowColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5,
                        ),
                        bigText: BigText(text: "Введіть свою адресу"),
                      ),
                      SizedBox(height: Dimensions.height20,),
                      //повідомлення
                      AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.message_outlined,
                          backgroundColor: Colors.redAccent,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5,
                        ),
                        bigText: BigText(text: "Повідомлення"),
                      ),
                      SizedBox(height: Dimensions.height20,),
                      //вихід
                      GestureDetector(
                        onTap: (){
                          if(Get.find<AuthController>().userLoggedIn()){
                            Get.find<AuthController>().clearSharedData();
                            Get.find<CartController>().clear();
                            Get.find<CartController>().clearCartHistory();
                            Get.offNamed(RouteHelper.getSignUpPage());
                          }
                          else{
                            print("you logged out");
                          }


                        },
                        child: AccountWidget(
                          appIcon: AppIcon(
                            icon: Icons.logout,
                            backgroundColor: Colors.redAccent,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5,
                          ),
                          bigText: BigText(text: "Вихід"),
                        ),
                      ),
                      SizedBox(height: Dimensions.height20,),

                    ],
                  ),
                ),
              )
            ],
          ),
        )
            :CustomLoader())
        //CustomLoader())
        :Container(

          child: Center(child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.maxFinite,
              height: Dimensions.height20*14,
              margin: EdgeInsets.only(left: Dimensions.width20,
                  right: Dimensions.width20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  image: DecorationImage(
                     //fit: BoxFit.cover,
                      image: AssetImage(
                          "assets/image/signin.png"
                      )
                  )
              ),
            ),
            SizedBox(height: Dimensions.height15,),
            GestureDetector(
              onTap: (){
                Get.toNamed(RouteHelper.getSignUpPage());
              },
              child: Container(

                width: double.maxFinite,
                height: Dimensions.height20*5,
                margin: EdgeInsets.only(left: Dimensions.width20,
                    right: Dimensions.width20),
                decoration: BoxDecoration(
                  color:  AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius20),

                ),
                child: Center(child: BigText(text:"Доєднатися", color: Colors.white,
                size: Dimensions.font26,)),
              ),
            )
          ],
        )),);
      }),
    );
  }
}
