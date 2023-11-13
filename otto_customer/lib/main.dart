// ignore_for_file: non_constant_identifier_names, dead_code
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otto_customer/router/main_router.dart';
import 'package:otto_customer/shared/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';

import 'core/locator/locator.dart';
import 'core/service-injector/service_injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(RouteObserverProvider(
    child: const MyApp(
      appKey: ValueKey<String>('root'),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({this.appKey}) : super(key: appKey);
  final ValueKey<String>? appKey;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {

  double appHeight = 0;
  double appWidth = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    appHeight = logicalHeight()??772.0;
    appWidth = logicalWidth()??360.0;
    _init();

    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //     statusBarBrightness: Brightness.dark,
    //     statusBarColor: Colors.black,
    //     systemNavigationBarColor: Colors.black,
    //   ),
    // );

    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]).then((_) {});
    super.initState();

  }

  // _fetchData(BuildContext context) {
  //   String? id;
  //   SharedPreferences? prefs;
  //   final key = prefs?.getString('dataOwnerId');
  //   if (key != null) {
  //     id = json.decode(key);
  //     FirebaseMessaging.instance.getToken().then((token) {
  //       _signOut(context, deviceId: token!, dataownerId: id!);
  //     });
  //   }
  // }
  //
  // _signOut(BuildContext context,
  //     {required String deviceId, required String dataownerId}) async {
  //   await si.profileService!.signOut(deviceId, dataownerId, context: context);
  //   await si.storageService.removeItem('token');
  //   si.storeService.reset();
  // }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.detached:
        break;
      default:
        break;
    }
  }

  Future<void> _init() async {
    await si.init();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // designSize: Size(logicalWidth()??360.0, logicalHeight()??772.0),
      designSize: const Size(360.0, 772.0),
      // designSize: ScreenUtil.defaultSize,
      // builder: (context, Widget? child) => MultiProvider(
      builder: () => MultiProvider(
        providers: allProviders,
        child: MaterialApp(
          // useInheritedMediaQuery: true,
          title: 'Otto Customer',
          debugShowCheckedModeBanner: false,
          // home: const SplashScreen(),
          onGenerateRoute: MainRouter.generateRoute,
          theme: ThemeData(
            fontFamily: 'SF Pro Display',
          ),
        ),
      ),
    );
  }
}
