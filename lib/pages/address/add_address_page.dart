import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:testappfirst/controllers/auth_controller.dart';
import 'package:testappfirst/controllers/location_controller.dart';
import 'package:testappfirst/controllers/user_controller.dart';
import 'package:testappfirst/pages/address/pick_address_map.dart';
import 'package:testappfirst/routes/route_helper.dart';
import 'package:testappfirst/untils/dimensions.dart';
import 'package:testappfirst/widgets/app_text_field.dart';
import 'package:testappfirst/widgets/big_taxt.dart';

import '../../models/address_model.dart';
import '../../untils/colors.dart';
import '../../widgets/app_icon.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
   CameraPosition _cameraPosition = const CameraPosition(
       target: LatLng(
       //45.508800, -122.624189
     50.258151, 28.664383
  ), zoom: 18);
  late LatLng _initialPosition = LatLng(
      //45.508800, -122.624189
      50.258151, 28.664383
  );

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    if(_isLogged&&Get.find<UserController>().userModel==null){
      Get.find<UserController>().getUserInfo();
    }
    if(Get.find<LocationController>().addressList.isNotEmpty){
      if(Get.find<LocationController>().getUserAddressFromLocalStorage()==""){
        Get.find<LocationController>().saveUserAddress(Get
        .find<LocationController>()
            .addressList
            .last);
      }
      Get.find<LocationController>().getUserAddress();
      _cameraPosition=CameraPosition(target: LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"]),
      ));
      _initialPosition = LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar  : AppBar(
    title: Text("Вікно адреси"),
        backgroundColor: AppColors.mainColor,
    ),
      body: GetBuilder<UserController>(builder: (userController){
        if(userController.userModel!=null&&_contactPersonName.text.isEmpty){
          _contactPersonName.text='${userController.userModel?.name}';
          _contactPersonNumber.text='${userController.userModel?.phone}';
          if(Get.find<LocationController>().addressList.isNotEmpty){
            _addressController.text = Get.find<LocationController>().getUserAddress().address;
          }
        }
        return GetBuilder<LocationController>(builder: (locationController){
          //Адреса по пунктам
          _addressController.text='${locationController.placemark.name??''}'
              '${locationController.placemark.locality??''}'
              '${locationController.placemark.postalCode??''}'
              '${locationController.placemark.country??''}';
          print("Address in my view is ${_addressController.text}");
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        width: 2,
                        color: AppColors.mainColor,
                      )
                  ),
                  child: Stack(
                    children: [
                      GoogleMap(initialCameraPosition:
                      CameraPosition(target: _initialPosition, zoom: 18),
                          onTap: (latlng){
                              Get.toNamed(RouteHelper.getPickAddressPage(),
                                arguments: PickAddressMap(
                                    fromSignup: false,
                                    fromAddress: true,
                                    googleMapController: locationController.mapController,
                                )
                              );
                          },
                          zoomControlsEnabled: false,
                          compassEnabled: false,
                          indoorViewEnabled: true,
                          mapToolbarEnabled: false,
                          myLocationEnabled: true,
                          onCameraIdle: (){
                            locationController.updatePosition(_cameraPosition, true);
                          },
                          onCameraMove: ((position)=>_cameraPosition=position),
                          onMapCreated: (GoogleMapController controller){
                            locationController.setMapController(controller);
                            if(Get.find<LocationController>().addressList.isEmpty){
                              //locationController.getCurrentLocation(true,)
                            }
                          }
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20, top:  Dimensions.height20),
                  child: SizedBox(height: 50,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: locationController.addressTypeList.length,
                        itemBuilder: (context, index){
                          return InkWell(
                            onTap: (){
                              locationController.setAddressTypeIndex(index);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.width20,
                              vertical: Dimensions.height10),
                              margin: EdgeInsets.only(right: Dimensions.width10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.radius20/4),
                                color: Theme.of(context).cardColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[200]!,
                                    spreadRadius: 1,
                                    blurRadius: 5
                                  )
                                ]
                              ),
                              child: Icon(
                                index==0?Icons.home:index==1?Icons.work:Icons.location_on,
                                color: locationController.addressTypeIndex==index
                                    ?AppColors.mainColor:Theme.of(context).disabledColor,
                              ),
                            ),
                          );
                        }),),
                ),
                SizedBox(height: Dimensions.height20,),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20+2),
                  child: BigText(text: "Адреса для доставки"),
                ),
                SizedBox(height: Dimensions.height10,),
                AppTextField(textController: _addressController,
                    hintText: "Ваша адреса", icon: Icons.map),
                SizedBox(height: Dimensions.height20,),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20+2),
                  child: BigText(text: "Контактне ім'я"),
                ),
                SizedBox(height: Dimensions.height10,),
                AppTextField(textController: _contactPersonName,
                    hintText: "Ваше Ім'я", icon: Icons.person),
                SizedBox(height: Dimensions.height20,),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20+2),
                  child: BigText(text: "Ваш телефон"),
                ),
                SizedBox(height: Dimensions.height10,),
                AppTextField(textController: _contactPersonNumber,
                    hintText: "Ваш телефон", icon: Icons.phone)
              ],
            ),
          );
        });
      }),
      bottomNavigationBar: GetBuilder<LocationController>(builder: (locationController){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Container(
              height: Dimensions.height20*6.5,
              padding: EdgeInsets.only(top:Dimensions.height30,
                  bottom:Dimensions.height30, left: Dimensions.width20,
                  right: Dimensions.width20 ),
              decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20*2),
                    topRight: Radius.circular(Dimensions.radius20*2),
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  GestureDetector(
                    onTap: (){
                      AddressModel _addressModel = AddressModel(
                          addressType: locationController.addressTypeList[
                            locationController.addressTypeIndex],
                          contactPersonName: _contactPersonName.text,
                          contactPersonNumber: _contactPersonNumber.text,
                          address: _addressController.text,
                          latitude: locationController.position.latitude.toString(),
                          longitude: locationController.position.longitude.toString(),
                      );
                      locationController.addAddress(_addressModel).then((response){
                          if(response.isSuccess){
                            //Get.back();
                            Get.toNamed(RouteHelper.getInitial());
                            Get.snackbar("Address", "Added Successfully");
                          }
                          else{
                            Get.snackbar("Address", "Couldn't save address");
                          }
                      });
                    },
                    child:  Container(
                      padding: EdgeInsets.only(top: Dimensions.height20,
                          bottom: Dimensions.height20, left:Dimensions.width20,
                          right: Dimensions.height20),
                      child: BigText(text: "Зберегти", color: Colors.white, size: 26,),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
