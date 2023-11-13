import 'package:otto_customer/shared/widgets/all_package.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _startTimer(RoutePaths.splashOptions);
  }

  _startTimer(routeName) {
    const duration = Duration(seconds: 3);
    return Timer(duration, () {
      _route(routeName);
    });
  }

  _route(routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        top: false,
        child: _buildSplash(context),
      ),
    );
  }

  Widget _buildSplash(BuildContext context) {
    return Stack(
      children: [
        // Positioned(
        //   child: Container(
        //     width: deviceWidth(context),
        //     decoration: const BoxDecoration(
        //       color: AppColors.white,
        //       // image: DecorationImage(
        //       //   fit: BoxFit.fitHeight,
        //       //   image: AssetImage(ImageAssets.splashBG),
        //       // ),
        //     ),
        //   ),
        // ),
        Positioned.fill(
          child: Align(alignment: Alignment.topCenter,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.white
              ),
              width: deviceWidth(context),
              height: deviceHeight(context),
            ),
          ),
        ),
        Positioned(
          bottom: 100.h,
          top: 100.h,
          left: 120.h,
          right: 120.h,
          child: SvgPicture.asset(
            width: 32.w,
            height: 48.h,
            SvgAssets.logo,
          ),
        ),
      ],
    );
  }
}







