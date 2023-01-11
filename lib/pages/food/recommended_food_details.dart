import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../untils/colors.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_taxt.dart';
import 'package:testappfirst/untils/dimensions.dart';
import '../../widgets/exandable_text_widgets.dart';

class RecommendedFoodDetail extends StatelessWidget {
  const RecommendedFoodDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.clear),
                AppIcon(icon: Icons.shopping_cart_checkout_outlined)
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(

                child: Center(
                    child: BigText(size: Dimensions.font26,
                        text: "Mr. Expresso")),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5,bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),
                  )
                ),
              ),

            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                  "assets/image/coffeeshop1.jpg",
                  width: double.maxFinite,
                  fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  child: ExpandableTextWidget(text:
                      "Процес приготування еспресо називається екстракцією та передбачає вивільнення під впливом поданої під тиском гарячої води твердих розчинних та нерозчинних речовин, а також летких ароматичних сполук. Перші формують щільність, смак і міцність отриманого напою, а другі своєю чергою надають йому характерний аромат."
                          "Насправді відсутні якісь узагальнені стандарти приготування еспресо. Проте в широкому сенсі діапазон змінних при приготуванні еспресо коливається в рамках наступних значень:"
                          "vdfgbdfohodifjoidfvifdnviundfo iubdiuvnuhdfbviudbuvnduyvbuidbvyuhduvbdyuvbuydbvudbyuvdibv8idnvudbiu"
                          "Важливим моментом приготування смачного еспресо є правильний темпінг кавової таблетки, яка формується в портофільтрі. Завдання бариста полягає в тому, щоб затемпінгована кавова таблетка  dgvdffdgdfdsfsdf fgdfg dgdg fdgdf fdgbdf"
                          "Процес приготування еспресо називається екстракцією та передбачає вивільнення під впливом поданої під тиском гарячої води твердих розчинних та нерозчинних речовин, а також летких ароматичних сполук. Перші формують щільність, смак і міцність отриманого напою, а другі своєю чергою надають йому характерний аромат."
                          "Насправді відсутні якісь узагальнені стандарти приготування еспресо. Проте в широкому сенсі діапазон змінних при приготуванні еспресо коливається в рамках наступних значень:"
                          "vdfgbdfohodifjoidfvifdnviundfo iubdiuvnuhdfbviudbuvnduyvbuidbvyuhduvbdyuvbuydbvudbyuvdibv8idnvudbiu"
                          "Важливим моментом приготування смачного еспресо є правильний темпінг кавової таблетки, яка формується в портофільтрі. Завдання бариста полягає в тому, щоб затемпінгована кавова таблетка  dgvdffdgdfdsfsdf fgdfg dgdg fdgdf fdgbdf"
                          "Процес приготування еспресо називається екстракцією та передбачає вивільнення під впливом поданої під тиском гарячої води твердих розчинних та нерозчинних речовин, а також летких ароматичних сполук. Перші формують щільність, смак і міцність отриманого напою, а другі своєю чергою надають йому характерний аромат."
                          "Насправді відсутні якісь узагальнені стандарти приготування еспресо. Проте в широкому сенсі діапазон змінних при приготуванні еспресо коливається в рамках наступних значень:"
                          "vdfgbdfohodifjoidfvifdnviundfo iubdiuvnuhdfbviudbuvnduyvbuidbvyuhduvbdyuvbuydbvudbyuvdibv8idnvudbiu"
                          "Важливим моментом приготування смачного еспресо є правильний темпінг кавової таблетки, яка формується в портофільтрі. Завдання бариста полягає в тому, щоб затемпінгована кавова таблетка  dgvdffdgdfdsfsdf fgdfg dgdg fdgdf fdgbdf"
                          "Процес приготування еспресо називається екстракцією та передбачає вивільнення під впливом поданої під тиском гарячої води твердих розчинних та нерозчинних речовин, а також летких ароматичних сполук. Перші формують щільність, смак і міцність отриманого напою, а другі своєю чергою надають йому характерний аромат."
                          "Насправді відсутні якісь узагальнені стандарти приготування еспресо. Проте в широкому сенсі діапазон змінних при приготуванні еспресо коливається в рамках наступних значень:"
                          "vdfgbdfohodifjoidfvifdnviundfo iubdiuvnuhdfbviudbuvnduyvbuidbvyuhduvbdyuvbuydbvudbyuvdibv8idnvudbiu"
                          "Важливим моментом приготування смачного еспресо є правильний темпінг кавової таблетки, яка формується в портофільтрі. Завдання бариста полягає в тому, щоб затемпінгована кавова таблетка  dgvdffdgdfdsfsdf fgdfg dgdg fdgdf fdgbdf"

                  ),
                  margin: EdgeInsets.only(left: Dimensions.width20,
                      right: Dimensions.width20),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: Dimensions.width20*2.5,
              right: Dimensions.width20*2.5,
              top: Dimensions.height10,
              bottom: Dimensions.height10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                    iconSize: Dimensions.iconSize28,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    icon: Icons.remove),

                AppIcon(
                    iconSize: Dimensions.iconSize28,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    icon: Icons.add),
              ],
            ),
          )
        ],
      ),
    );
  }
}
