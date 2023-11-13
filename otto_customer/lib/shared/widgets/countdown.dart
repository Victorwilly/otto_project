import 'package:otto_customer/shared/widgets/all_package.dart';


class Countdown extends AnimatedWidget {
  Countdown({Key? key, this.animation}) : super(key: key, listenable: animation!);
  Animation<int>? animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation!.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    return Styles.regular(
      timerText, fontSize: 16.sp, color: AppColors.red,  fontWeight:FontWeight.w700);
  }
}
