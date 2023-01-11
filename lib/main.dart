import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:testappfirst/home/main_page1.dart';
import 'package:testappfirst/pages/food/popular_details.dart';
import 'package:testappfirst/pages/food/recommended_food_details.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}): super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: RecommendedFoodDetail(),
    );
  }
}

