import 'package:otto_customer/modules/dashboard/homepage/view-models/homepage_vm.dart';

import '../../../shared/widgets/all_package.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  String? completeNo;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageViewModel>(
      create: (_) => HomePageViewModel(
          // context: context,
          // authenticationService: si.authenticationService,
          ),
      child: Consumer<HomePageViewModel>(
          builder: (context, viewModel, _) => _buildScreen(context, viewModel)
          //     Stack(
          //   children: [
          //     _buildScreen(context, viewModel),
          //     newLoader(viewModel.isLoading)
          //   ],
          // ),
          ),
    );
  }

  Widget _buildScreen(BuildContext context, HomePageViewModel viewModel) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBGColor,
      // appBar: buildAppbar(context: context),
      body: SizedBox(
        width: deviceWidth(context),
        height: deviceHeight(context),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xff06184D),
                      Color(0xff04123C),
                      Color(0xff051A57)
                    ]),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: SvgPicture.asset(SvgAssets.appbarBg),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HSpace(50.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 40.w,
                                    height: 40.h,
                                    decoration: const BoxDecoration(
                                        color: AppColors.white,
                                        shape: BoxShape.circle),
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          SvgAssets.notificationBell),
                                      WSpace(16.w),
                                      SvgPicture.asset(SvgAssets.cart),
                                    ],
                                  )
                                ],
                              ),
                              HSpace(24.h),
                              Styles.semiBold("Welcome Back,",
                                  color: AppColors.white, fontSize: 16.sp),
                              HSpace(8.h),
                              Styles.bold("Jhud Chukwuka",
                                  color: AppColors.white, fontSize: 20.sp),
                              HSpace(12.h),
                              Row(
                                children: [
                                  Styles.semiBold("You have",
                                      color: AppColors.white, fontSize: 16.sp),
                                  Styles.bold(" 350 ",
                                      color: AppColors.white, fontSize: 16.sp),
                                  Styles.semiBold("loyalty points.",
                                      color: AppColors.white, fontSize: 16.sp),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                HSpace(16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.r),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12.r)),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search Merchants",
                            hintStyle: TextStyle(
                              fontSize: 16.sp,
                            ),
                            border: InputBorder.none,
                            suffixIcon: SvgPicture.asset(
                              SvgAssets.search,
                            ),
                          ),
                        ),
                      ),
                      HSpace(16.h),
                      Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 14.w),
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(12.r)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Styles.semiBold("Buy Gift Cards",
                                  color: Colors.black),
                              SvgPicture.asset(
                                SvgAssets.gcSuffix,
                              ),
                            ],
                          )),
                      HSpace(16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Styles.semiBold("Top Merchants", color: Colors.black),
                          Styles.regular("See all", color: Colors.black),
                        ],
                      ),
                      HSpace(16.h),
                      SizedBox(
                        height: 300,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
                                .map((e) => Column(
                                      children: [
                                        Image.asset(
                                            'assets/images/chicken-republic.png'),
                                        HSpace(8.h),
                                        Styles.semiBold("Chicken Republic",
                                            color: Colors.black)
                                      ],
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                      HSpace(32.h),
                      Styles.semiBold("Suggestions for you",
                          color: Colors.black),
                      HSpace(10.h),
                      SvgPicture.asset(
                        SvgAssets.cashbackBanner,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
