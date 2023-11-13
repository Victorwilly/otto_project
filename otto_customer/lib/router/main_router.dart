import 'package:flutter/material.dart';
import 'package:otto_customer/modules/authentication/create_account/account_verification.dart';
import 'package:otto_customer/modules/authentication/create_account/confirm_pin.dart';
import 'package:otto_customer/modules/authentication/create_account/create_account.dart';
import 'package:otto_customer/modules/authentication/create_account/ready_to_go.dart';
import 'package:otto_customer/modules/authentication/create_account/setup_account.dart';
import 'package:otto_customer/modules/authentication/create_account/setup_pin.dart';
import 'package:otto_customer/modules/authentication/create_account/success_registration.dart';
import 'package:otto_customer/modules/authentication/forgot_password/enter_otp.dart';
import 'package:otto_customer/modules/authentication/forgot_password/forgot_pin.dart';
import 'package:otto_customer/modules/authentication/forgot_password/setup_new_pin.dart';
import 'package:otto_customer/modules/authentication/login/enter_login_verification.dart';
import 'package:otto_customer/modules/splash/splash_options.dart';
import 'package:otto_customer/modules/splash/splash_screen.dart';

import '../modules/authentication/forgot_password/pin_reset_success.dart';
import '../modules/authentication/login/new_login.dart';
import '../modules/authentication/login/returning_login.dart';
import '../shared/widgets/bottom_nav.dart';
import 'route_paths.dart';

class MainRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RoutePaths.setupAccount:
        return MaterialPageRoute(builder: (_) => SetupAccount());
      case RoutePaths.accountVerification:
        return MaterialPageRoute(builder: (_) => const AccountVerification());
      case RoutePaths.createAccount:
        return MaterialPageRoute(builder: (_) => CreateAccount());
      case RoutePaths.setupPin:
        return MaterialPageRoute(builder: (_) => const SetupPin());
      case RoutePaths.confirmPin:
        return MaterialPageRoute(builder: (_) => const ConfirmPin());
      case RoutePaths.successRegistration:
        return MaterialPageRoute(builder: (_) => const SuccessRegistration());
      case RoutePaths.readyToGo:
        return MaterialPageRoute(builder: (_) => const ReadyToGo());
      case RoutePaths.newSignIn:
        return MaterialPageRoute(builder: (_) => NewLogin());
      case RoutePaths.enterLoginPin:
        return MaterialPageRoute(builder: (_) => const EnterLoginVerification());
      case RoutePaths.signIn:
        return MaterialPageRoute(builder: (_) => const ReturnLogin());
      case RoutePaths.forgotPin:
        return MaterialPageRoute(builder: (_) => ForgotPin());
      case RoutePaths.enterResetPin:
        return MaterialPageRoute(builder: (_) => const EnterOtp());
      case RoutePaths.setupNewPin:
        return MaterialPageRoute(builder: (_) => SetupYourNewPin());
      case RoutePaths.pinResetSuccess:
        return MaterialPageRoute(builder: (_) => const PinResetSuccess());
      case RoutePaths.bottomNav:
        return MaterialPageRoute(builder: (_) => const BottomNav());
      case RoutePaths.splashOptions:
        return MaterialPageRoute(builder: (_) => const SplashOptions());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
