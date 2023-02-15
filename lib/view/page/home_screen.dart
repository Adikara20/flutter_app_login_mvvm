import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_location/res/colors.dart';
import 'package:flutter_application_location/utils/routes/routes_name.dart';
import 'package:flutter_application_location/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../../view_model/scanner_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//tessss
bool isScanCompleted = false;

List<IconData> iconList = [
  //list of icons that required by animated navigation bar.
  Icons.dashboard,
  Icons.person,
];
int _bottomNavIndex = 0; //default index of the tabs

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserViewModel>(context);
    final scannerViewModel = Provider.of<ScannerViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            onTap: (() {
              userPreference.remove().then((value) {
                Navigator.pushNamed(context, RoutesName.login);
              });
            }),
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: Text('logut'),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Scanned Result",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        scannerViewModel.stringTest,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.titleTextColor,
        child: const Icon(Icons.qr_code_2, size: 45),
        onPressed: () {
          Navigator.pushNamed(context, RoutesName.qrscan);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        //navigation bar
        activeColor: AppColors.buttonColor,
        inactiveColor: Colors.white,
        icons: iconList,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        backgroundColor: AppColors.titleTextColor,
      ),
    );
  }
}
