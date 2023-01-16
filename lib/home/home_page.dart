import 'package:flutter/material.dart';
import 'package:testappfirst/untils/colors.dart';


import 'main_page1.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int  _selectedIndex=0;
  List pages=[
    MainFoodPage(),
    Container(child: Center(child: Text("Next 2 page"))),
    Container(child: Center(child: Text("Next 3 page"))),
    Container(child: Center(child: Text("Next 4 page"))),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      //Можливо буде без нижнього меню, воно в мене не працює
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
            //title: Text("home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
            //title: Text("home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
            //title: Text("home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
            //title: Text("home"),
          ),

        ],),
    );
  }
}
