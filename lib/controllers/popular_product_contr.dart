import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testappfirst/controllers/cart_controller.dart';
import 'package:testappfirst/data/repository/popular_product_repo.dart';
import 'package:testappfirst/untils/app_constants.dart';

import '../models/popular_products_model.dart';
import '../untils/colors.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList=[];
  List<dynamic>  get popularProductList =>_popularProductList;
  late CartController _cart;

  bool _isLoaded =false;
  bool  get isLoaded=>_isLoaded;

  int _quantity=0;
  int get quantity=>_quantity;
  //{return _quantity;}
  int _inCartItems=0;
  int get inCartItems=>_inCartItems+_quantity;

  Future<void> getPopularProductList()async {
    Response response = await popularProductRepo.getPopularProductList();
    if(response.statusCode==200){

     // print("got products OK");
      _popularProductList=[];
      _popularProductList.addAll(Product.fromJson(response.body).products);
     // print(_popularProductList);
      _isLoaded=true;
      update();
    }
    else{
      print("got products error");
    }
  }

  void setQuantity(bool isIncrement){
    if(isIncrement){
      print("it is increment "+_quantity.toString());
      _quantity=checkQuantity(_quantity+1);
    }
    else{
      print("it is decrement "+_quantity.toString());
      _quantity=checkQuantity(_quantity-1);
    }
    update();
  }
  int checkQuantity(int quantity){
    if(quantity<0){
      Get.snackbar("Кількість", "Більше не зменшиться!",
      backgroundColor: AppColors.mainColor,
      colorText: Colors.white,);
      return 0;
    }
    else if(quantity>20){
      Get.snackbar("Кількість", "Більше не додається!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,);
      return 20;
    }
    else{
      return quantity;
    }
  }

  void initProduct(CartController cart){
    _quantity=0;
    _inCartItems=0;
    _cart=cart;

    //if exist
    //get from storage _inCartItems=3
  }

  void addItem(ProductModel product ){
    _cart.addItem(product, quantity);
  }
}