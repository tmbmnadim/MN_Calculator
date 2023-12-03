import 'package:flutter/material.dart';
import 'package:mn_calculator/pages/homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation colorAnimation;
  late Animation heightAnimation;
  late Animation widthAnimation;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1))
        .then((value) => _animationController.forward());
    Future.delayed(const Duration(milliseconds: 2200)).then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    });

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    colorAnimation = ColorTween(
      begin: Colors.transparent,
      end: Colors.white,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutBack,
    ));
    heightAnimation = Tween<double>(begin: 200, end: 1200).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutBack,
    ));
    widthAnimation = Tween<double>(begin: 200, end: 500).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutBack,
    ));
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.teal,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 400,
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: ClipOval(
                  child: Image.asset(
                    "images/icon.png",
                    scale: 0.5,
                  ),
                ),
              ),
            ),
            Container(
              color: colorAnimation.value,
              height: heightAnimation.value,
              width: widthAnimation.value,
            )
          ],
        ),
      ),
    );
  }
}
