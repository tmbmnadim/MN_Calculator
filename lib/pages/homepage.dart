import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mn_calculator/pages/bmi_calculator.dart';
import 'package:mn_calculator/pages/cgpa_calculator.dart';
import 'package:mn_calculator/pages/leap_year.dart';
import 'package:mn_calculator/pages/utils.dart';
import 'normal_calculator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<SharedPreferences> initSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bmiValue = prefs.getDouble("bmiValue")!;
    return prefs;
  }

  late double bmiValue;
  final PageController _pageController = PageController();
  int pageIndex = 0;
  UtilManager um = UtilManager();
  List<String> titles = [
    "General Calculator",
    "BMI Calculator",
    "Leap Year Calculator",
    "CGPA Calculator"
  ];
  List<IconData> icons = [
    Icons.calculate_outlined,
    Icons.monitor_weight,
    Icons.calendar_month,
    Icons.bookmark,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: customDrawer(),
      appBar: AppBar(
        title: Text(titles[pageIndex]),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black45,
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          scrollBehavior: const CupertinoScrollBehavior(),
          onPageChanged: (index) {
            pageIndex = index;
            setState(() {});
          },
          children: const [
            NormalCalculator(),
            BMICalculator(),
            LeapYearCalculator(),
            CGPACalculator(),
          ],
        ),
      ),
    );
  }

  Widget customDrawer() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                Image.asset(
                  "images/icon.png",
                  scale: 1.6,
                ),
                const SizedBox(
                  width: 200,
                  height: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Thanks For Using",
                        style: TextStyle(fontSize: 23, color: Colors.white),
                      ),
                      Text(
                        "MN Calculator",
                        style: TextStyle(fontSize: 28, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: titles.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: um.customListTile(
                    leadingIcon: icons[index],
                    title: titles[index],
                    onTap: () {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                      setState(() {});
                    },
                  ),
                );
              })
        ],
      ),
    );
  }
}
