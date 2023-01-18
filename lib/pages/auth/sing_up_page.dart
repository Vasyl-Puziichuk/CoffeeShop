import 'package:flutter/material.dart';
import 'package:testappfirst/untils/colors.dart';
import 'package:testappfirst/untils/dimensions.dart';

import '../../widgets/app_text_field.dart';

class SingUpPage extends StatelessWidget {
  const SingUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var passwordController=TextEditingController();
    var nameController=TextEditingController();
    var phoneController=TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
          SizedBox(height: Dimensions.height30,),
          //пароль
          AppTextField(
              textController: passwordController,
              hintText: "Пароль",
              icon: Icons.password_sharp),
          SizedBox(height: Dimensions.height30,),
          //ім'я
          AppTextField(
              textController: nameController,
              hintText: "Ім'я",
              icon: Icons.person),
          SizedBox(height: Dimensions.height30,),
          //телефон
          AppTextField(
              textController: phoneController,
              hintText: "Телефон",
              icon: Icons.phone_android_sharp),
          SizedBox(height: Dimensions.height30,),
        ],
      ),
    );
  }
}
