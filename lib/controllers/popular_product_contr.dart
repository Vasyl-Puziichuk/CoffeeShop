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
      _quantity=checkQuantity(_quantity+1);
      //print("it is increment "+_quantity.toString());
    }
    else{
      _quantity=checkQuantity(_quantity-1);
      //print("it is decrement "+_quantity.toString());
    }
    update();
  }
  int checkQuantity(int quantity){
    if((_inCartItems+quantity)<0){
      Get.snackbar("Кількість", "Більше не зменшиться!",
      backgroundColor: AppColors.mainColor,
      colorText: Colors.white,);
      return 0;
    }
    else if((_inCartItems+quantity)>20){
      Get.snackbar("Кількість", "Більше не додається!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,);
      return 20;
    }
    else{
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart){
    _quantity=0;
    _inCartItems=0;
    _cart=cart;
    var exist=false;
    exist=_cart.existInCart(product);
    //if exist
    //get from storage _inCartItems=3
    print("exist or not "+exist.toString());
    if(exist){
      _inCartItems=cart.getQuantity(product);
    }
    print("Quantity in the cart is "+_inCartItems.toString());
  }

  void addItem(ProductModel product ){
    //if(_quantity>0) {
      _cart.addItem(product, quantity);

      _quantity=0;
      _inCartItems=_cart.getQuantity(product);

      _cart.items.forEach((key, value) {
        print("The id is "+value.id.toString()+" The quantity is "
            +value.quantity.toString());
      });
    // }
    // else{
    //   Get.snackbar("Кількість", "Додайте хоча б один товар до кошика!",
    //     backgroundColor: AppColors.mainColor,
    //     colorText: Colors.white,);
    // }
    update();
  }

  int get totalItems{
    return _cart.totalItems;
  }

}