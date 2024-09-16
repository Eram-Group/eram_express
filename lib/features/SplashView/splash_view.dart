import 'package:eram_express/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/*
class CustomSplashView extends StatelessWidget {
  const CustomSplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // المشكله هنا ان الصوره هنا كلها بتبان ابيض بس ومفروض انها صوره فدي كده المشكله لحد هنا
            Positioned.fill(
              child: Image.asset(
                "assets/splash_background.png",
                fit: BoxFit.fill,
              ),

              //SvgPicture.asset('Assets/bac_splash.svg',fit: BoxFit.fill,)
            ),

            Positioned(
              top: Responsive.getResponsivebyHeigth(context, fontSize: 100),
              left: 0,
              right: 0,
              child: Center(child: FadeInImageExample()),
            ),
            //دي وهي متاخده صغيره
            /*
            Positioned(
                bottom: -40,
                left: 0,
                child: SvgPicture.asset(
                  "Assets/logo brand.svg",
                  height: Responsive.responsiveValue(mobileValue: 450, tabletValue: 900),
                )),
                */
            Positioned(
                bottom:
                    -Responsive.getResponsivebyHeigth(context, fontSize: 30),
                right: 50,
                left: -50,
                child: SvgPicture.asset(
                  "assets/logo brand.svg",
                  height: Responsive.responsiveValue(
                      mobileValue: 500, tabletValue: 900),
                )),
          ],
        ),
      ),
    );
  }
}

class FadeInImageExample extends StatefulWidget {
  @override
  _FadeInImageExampleState createState() => _FadeInImageExampleState();
}

class _FadeInImageExampleState extends State<FadeInImageExample> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        opacity: _opacity,
        duration: Duration(seconds: 1), // مدة الأنيميشن
        child: SvgPicture.asset('assets/_Layer_.svg',
            height: Responsive.getResponsiveFontSize(context, fontSize: 45)));
  }
}
*/