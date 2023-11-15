import 'package:otto_customer/modules/dashboard/homepage/homepage.dart';
import 'package:otto_customer/shared/utils/bottom-nav-utils.dart';
import 'package:otto_customer/shared/widgets/all_package.dart';

class BottomNavPage extends StatefulWidget {
  final bool? initializeData;
  const BottomNavPage({Key? key, this.initializeData = true}) : super(key: key);

  @override
  _BottomNavPageState createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  ValueNotifier<int> selectedIndex = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedIndex,
      builder: (context, int index, _) => Scaffold(
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: BottomAppBar(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: navigationModel
                      .map(
                        (e) => e.index == 10
                            ? const SizedBox(width: 0)
                            : InkWell(
                                highlightColor: Colors.transparent,
                                splashFactory: NoSplash.splashFactory,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      e.index == index ? e.activeIcon : e.icon,
                                    ),
                                    HSpace(4.h),
                                    Text(
                                      e.title,
                                      style: TextStyle(
                                          color: e.index == index
                                              ? AppColors.primaryColor
                                              : AppColors.grayscale,
                                          fontSize: 12,
                                          fontWeight: e.index == index
                                              ? FontWeight.bold
                                              : FontWeight.w500),
                                    )
                                  ],
                                ),
                                onTap: () => selectedIndex.value = e.index,
                              ),
                      )
                      .toList()),
            ),
          ),
          body: Container(
            child: <Widget>[
              HomePage(),
              HomePage(),
              HomePage(),
              HomePage(),
            ].elementAt(index),
          )),
    );
    // );
  }
}
