import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:testappfirst/controllers/location_controller.dart';
import 'package:testappfirst/pages/address/widgets/search_location_page.dart';
import 'package:testappfirst/routes/route_helper.dart';
import 'package:testappfirst/untils/colors.dart';
import 'package:testappfirst/untils/dimensions.dart';

import '../../base/custom_button.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddress;
  final GoogleMapController? googleMapController;
  const PickAddressMap({Key? key,
    required this.fromSignup,
    required this.fromAddress,
    this.googleMapController}) : super(key: key);

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(Get.find<LocationController>().addressList.isEmpty){
      _initialPosition=LatLng(50.258151, 28.664383);
      _cameraPosition=CameraPosition(target: _initialPosition, zoom: 18);

    }
    else{
      if(Get.find<LocationController>().addressList.isNotEmpty){
        _initialPosition=LatLng(
            double.parse(Get.find<LocationController>().getAddress["latitude"]),
            double.parse(Get.find<LocationController>().getAddress["longitude"]));
        _cameraPosition=CameraPosition(target: _initialPosition, zoom: 18);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<LocationController>(builder: (locationController){
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: double.maxFinite,
              child: Stack(
                children: [
                  GoogleMap(initialCameraPosition: CameraPosition(
                      target: _initialPosition, zoom: 18
                  ),
                    zoomControlsEnabled: false,

                    onCameraMove: (CameraPosition cameraPosition){
                      _cameraPosition=cameraPosition;
                    },
                    onCameraIdle: (){
                      Get.find<LocationController>().updatePosition(_cameraPosition, false);
                    },
                    onMapCreated: (GoogleMapController mapController){
                      _mapController=mapController;
                      //if(!widget.fromAddress){}
                    },
                  ),
                  Center(
                    child: !locationController.loading?Image.asset("assets/image/pick_marker.png",
                      height: 50, width: 50,
                    ):CircularProgressIndicator()
                  ),
                  /*
                    Відображення і вибір адреси
                  */
                  Positioned(
                    top: Dimensions.height45,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: InkWell(
                      onTap: ()=>Get.dialog(LocationDialogue(mapController: _mapController)),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(Dimensions.radius20/2),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.location_on, size: 25, color: AppColors.yellowColor,),
                            Expanded(child: Text(
                              '${locationController.pickPlacemark.name??''}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimensions.font16
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )),
                            SizedBox(width: Dimensions.width10,),
                            Icon(Icons.search, size: 25, color: AppColors.yellowColor,)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 80,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      child: locationController.isLoading?Center(
                        child: CircularProgressIndicator(),
                      ):CustomButton(
                        //width: 200,
                        buttonText: locationController.inZone?
                        widget.fromAddress?'Pick Address':'Pick Location':'Pick Address',
                        onPressed: (locationController.buttonDisable || locationController.loading)?null:(){
                          if(locationController.pickPosition.latitude!=0&&
                              locationController.pickPlacemark.name!=null){
                            if(widget.fromAddress){
                              if(widget.googleMapController!=null){
                                print("Now you can clicked on this");
                                widget.googleMapController!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(
                                    locationController.pickPosition.latitude,
                                    locationController.pickPosition.longitude
                                ))));
                                locationController.setAddAddressData();
                              }
                              Get.back();
                              //Get.toNamed(RouteHelper.getAddressPage());
                            }
                          }
                        },
                      )
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
