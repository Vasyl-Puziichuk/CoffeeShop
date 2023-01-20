import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:testappfirst/controllers/auth_controller.dart';
import 'package:testappfirst/controllers/location_controller.dart';
import 'package:testappfirst/controllers/user_controller.dart';
import 'package:testappfirst/untils/dimensions.dart';
import 'package:testappfirst/widgets/app_text_field.dart';
import 'package:testappfirst/widgets/big_taxt.dart';

import '../../untils/colors.dart';

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
   CameraPosition _cameraPosition = const CameraPosition(target: LatLng(
       45.508800, -122.624189
     //50.258151, 28.664383
  ), zoom: 15);
  late LatLng _initialPosition = LatLng(
      45.508800, -122.624189
      //50.258151, 28.664383
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
    title: Text("Address page"),
        backgroundColor: AppColors.mainColor,
    ),
      body: GetBuilder<UserController>(builder: (userController){
        if(userController.userModel!=null&&_contactPersonName.text.isEmpty){
          _contactPersonName.text='${userController.userModel?.name}';
          _contactPersonNumber.text='${userController.userModel?.phone}';
          if(Get.find<LocationController>().addressList.isNotEmpty){
          }
        }
        return GetBuilder<LocationController>(builder: (locationController){
          //Адреса по пунктам
          _addressController.text='${locationController.placemark.name??''}'
              '${locationController.placemark.locality??''}'
              '${locationController.placemark.postalCode??''}'
              '${locationController.placemark.country??''}';
          print("Address in my view is ${_addressController.text}");
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 140,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      width: 2,
                      color: Theme.of(context).primaryColor,
                    )
                ),
                child: Stack(
                  children: [
                    GoogleMap(initialCameraPosition:
                    CameraPosition(target: _initialPosition, zoom: 17),
                        zoomControlsEnabled: false,
                        compassEnabled: false,
                        indoorViewEnabled: true,
                        mapToolbarEnabled: false,
                        onCameraIdle: (){
                          locationController.updatePosition(_cameraPosition, true);
                        },
                        onCameraMove: ((position)=>_cameraPosition=position),
                        onMapCreated: (GoogleMapController controller){
                          locationController.setMapController(controller);
                        }
                    )
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height20,),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.width20+2),
                child: BigText(text: "Адреса для доставки"),
              ),
              SizedBox(height: Dimensions.height20,),
              AppTextField(textController: _addressController,
                  hintText: "Ваша адреса", icon: Icons.map)
            ],
          );
        });
      }),
    );
  }
}
