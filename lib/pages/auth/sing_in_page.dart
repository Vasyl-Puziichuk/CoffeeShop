import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:testappfirst/pages/auth/sing_up_page.dart';
import 'package:testappfirst/untils/colors.dart';
import 'package:testappfirst/untils/dimensions.dart';
import 'package:testappfirst/widgets/big_taxt.dart';

import '../../base/custom_loader.dart';
import '../../base/show_custom_snack_bar.dart';
import '../../controllers/auth_controller.dart';
import '../../models/signup_body_model.dart';
import '../../routes/route_helper.dart';
import '../../widgets/app_text_field.dart';

class SingInPage extends StatelessWidget {
  const SingInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var passwordController=TextEditingController();
    void _login(AuthController authController){
      String email=emailController.text.trim();
      String password=passwordController.text.trim();

      if(email.isEmpty){
        showCustomSnackBar("Введіть свою електрону пошту", title: "Електрона пошта");
      }
      else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Введіть дійсну електрону пошту", title: "Дійсна електрона пошта");
      }
      else if(password.isEmpty){
        showCustomSnackBar("Введіть свій пароль", title: "Пароль");
      }
      else if(password.length<6){
        showCustomSnackBar("Пароль має бути більше шести символів", title: "Пароль");
      }
      else{

        //showCustomSnackBar("Все добре пройшло", title: "Чудово");
        authController.login(email, password).then((status){
          if(status.isSuccess){
            Get.toNamed(RouteHelper.getInitial());
            //print("Success login");
          }
          else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }


    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading?SingleChildScrollView(
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
                icon: Icons.password_sharp,
                isObscure: true,),

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
              GestureDetector(
                onTap: (){
                  _login(authController);
                },
                child: Container(
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
        )
            :CustomLoader();
      }),
    );
  }
}
