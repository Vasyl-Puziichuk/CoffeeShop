import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:testappfirst/base/show_custom_snack_bar.dart';
import 'package:testappfirst/untils/colors.dart';
import 'package:testappfirst/untils/dimensions.dart';
import 'package:testappfirst/widgets/big_taxt.dart';

import '../../widgets/app_text_field.dart';

class SingUpPage extends StatelessWidget {
  const SingUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var passwordController=TextEditingController();
    var nameController=TextEditingController();
    var phoneController=TextEditingController();
    var singUpImage=[
      "face.png",
      "goog.png",
      "twit.png",
    ];

    void _registration(){
      String name=nameController.text.trim();
      String phone=phoneController.text.trim();
      String email=emailController.text.trim();
      String password=passwordController.text.trim();

      if(name.isEmpty){
        showCustomSnackBar("Введіть своє ім'я", title: "Ім'я");
      }
      else if(phone.isEmpty){
        showCustomSnackBar("Введіть свій номер телефону", title: "Номер телефону");
      }
      else if(email.isEmpty){
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
        showCustomSnackBar("Все добре пройшло", title: "Чудово!");
      }
    }

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
            //ім'я
            AppTextField(
                textController: nameController,
                hintText: "Ім'я",
                icon: Icons.person),
            SizedBox(height: Dimensions.height20,),
            //телефон
            AppTextField(
                textController: phoneController,
                hintText: "Телефон",
                icon: Icons.phone_android_sharp),
            SizedBox(height: Dimensions.height20+Dimensions.height20,),
            //кнопка реєстрації
            GestureDetector(
              onTap: (){
                _registration();
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
                      text: "Доєднатися",
                    size: Dimensions.font20+Dimensions.font20/2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: Dimensions.height10,),
            //існуючий акаунт
            RichText(
                text: TextSpan(
                  recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                  text: "Вже маєте обліковий запис?",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font20,
                    )
                )
            ),
            SizedBox(height: Dimensions.screenHeight*0.035,),
            //реєстрація по соціальних мережах
            RichText(
                text: TextSpan(
                    text: "Зареєструйтесь одним із наведених нижче способів",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font16,
                    )
                )
            ),
            Wrap(
              children: List.generate(3, (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                    radius: Dimensions.radius30,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(
                    "assets/image/"+singUpImage[index]
                  ),
                ),
              )),
            )

          ],
        ),
      ),
    );


  }
}
