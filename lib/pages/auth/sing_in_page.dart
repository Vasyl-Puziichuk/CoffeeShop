import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:testappfirst/pages/auth/sing_up_page.dart';
import 'package:testappfirst/untils/colors.dart';
import 'package:testappfirst/untils/dimensions.dart';
import 'package:testappfirst/widgets/big_taxt.dart';

import '../../widgets/app_text_field.dart';

class SingInPage extends StatelessWidget {
  const SingInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var passwordController=TextEditingController();
    var nameController=TextEditingController();
    var phoneController=TextEditingController();


    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: Dimensions.screenHeight*0.055,),
            //app logo
            Container(
              height: Dimensions.screenHeight*0.25,
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 80,
                  backgroundImage: AssetImage(
                      "assets/image/logo3.png"
                  ),
                ),
              ),
            ),
            //welcome
            Container(
              margin: EdgeInsets.only(left: Dimensions.width20),
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Вітаю!",
                  style: TextStyle(
                    fontSize: Dimensions.font20*3+Dimensions.font20/2,
                    fontWeight: FontWeight.bold
                  ),),
                  Text("Увійдіть у свій обліковий запис",
                    style: TextStyle(
                        fontSize: Dimensions.font20,
                       // fontWeight: FontWeight.bold
                      color: Colors.grey[500]
                    ),)

                ],
              ),
            ),
            SizedBox(height: Dimensions.height20,),
            //email
            AppTextField(
                textController: emailController,
                hintText: "Email...",
                icon: Icons.email),
            SizedBox(height: Dimensions.height20,),
            //пароль
            AppTextField(
                textController: passwordController,
                hintText: "Пароль",
                icon: Icons.password_sharp),

            SizedBox(height: Dimensions.height20,),
            //існуючий акаунт
            Row(
              children: [
                Expanded(child: Container()),
                RichText(
                    text: TextSpan(
                        text: "Увійдіть у свій обліковий запис",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20,
                        )
                    )
                ),
                SizedBox(width: Dimensions.width20,)
              ],
            ),
            SizedBox(height: Dimensions.screenHeight*0.05,),
            //sign in
            Container(
              width: Dimensions.screenWidth/2,
              height: Dimensions.screenHeight/12.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: AppColors.mainColor
              ),
              child: Center(
                child: BigText(
                  text: "Увійти",
                  size: Dimensions.font20+Dimensions.font20/2,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: Dimensions.screenHeight*0.05,),
            //реєстрація по соціальних мережах
            RichText(
                text: TextSpan(
                    text: "Не маєте облікового запису?",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font20,
                    ),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=()=>
                          Get.to(()=>SingUpPage(),
                          transition: Transition.fadeIn),
                    text: " Створити",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainColor,
                      fontSize: Dimensions.font20,
                    ))
                  ]
                )
            ),

          ],
        ),
      ),
    );
  }
}
