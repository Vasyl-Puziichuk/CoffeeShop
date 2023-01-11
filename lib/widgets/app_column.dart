import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testappfirst/widgets/small_text.dart';

import '../untils/colors.dart';
import '../untils/dimensions.dart';
import 'big_taxt.dart';
import 'icon&text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key,
  required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(text: text, size: Dimensions.font26,),
          //коментарі
          SizedBox(height: Dimensions.height10,),
          Row(
            children: [
              Wrap(
                  children: List.generate(5, (index) {
                    return Icon(Icons.star,
                      color: AppColors.mainColor, size: 15,);})
              ),
              SizedBox(width: 10, ),
              SmallText(text: "4.5"),
              SizedBox(width: 10,),
              SmallText(text: "914"),
              SizedBox(width: 10,),
              SmallText(text: "comments")
            ],
          ),
          //локація
          SizedBox(height: Dimensions.height20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconAndTextWidget(icon: Icons.circle_sharp,
                  text: "Normal",
                  iconColor: AppColors.iconColor1),
              IconAndTextWidget(icon: Icons.location_on,
                  text: "2 km",
                  iconColor: AppColors.mainColor),
              IconAndTextWidget(icon: Icons.access_time_rounded,
                  text: "24 min",
                  iconColor: AppColors.iconColor2)
            ],
          )
        ],
      );
  }
}
