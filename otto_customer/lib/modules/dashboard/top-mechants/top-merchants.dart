import 'package:otto_customer/modules/dashboard/gift-card/giftcard.dart';
import 'package:otto_customer/modules/dashboard/top-mechants/viewmodel/top-merchant_vm.dart';

import '../../../shared/widgets/all_package.dart';

class TopMerchantsPage extends StatelessWidget {
  TopMerchantsPage({Key? key}) : super(key: key);
  String? completeNo;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TopMerchantViewModel>(
      create: (_) => TopMerchantViewModel(
          // context: context,
          // authenticationService: si.authenticationService,
          ),
      child: Consumer<TopMerchantViewModel>(
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

  Widget _buildScreen(BuildContext context, TopMerchantViewModel viewModel) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBGColor,
      appBar: buildAppbar(
          context: context,
          title: Styles.semiBold("Buy Gift Cards", color: Colors.black),
          actions: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {},
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: SvgPicture.asset(SvgAssets.cartDark)),
            )
          ]),
      body: SizedBox(
        width: deviceWidth(context),
        height: deviceHeight(context),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                            suffixIcon: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: SvgPicture.asset(
                                SvgAssets.search,
                              ),
                            ),
                          ),
                        ),
                      ),
                      HSpace(16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Styles.semiBold("Top Merchants", color: Colors.black),
                        ],
                      ),
                      HSpace(16.h),
                      SizedBox(
                        // height: 100,
                        child: Center(
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            runAlignment: WrapAlignment.spaceBetween,
                            children: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
                                .map((e) => GestureDetector(
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SendGiftCardsPage(),
                                        ),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        padding: const EdgeInsets.all(12),
                                        width:
                                            (MediaQuery.of(context).size.width /
                                                    2) -
                                                40,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 4.w, vertical: 4.h),
                                        child: Column(
                                          children: [
                                            Image.asset(
                                                'assets/images/cr-merchant.png'),
                                            HSpace(15.h),
                                            Styles.semiBold("Chicken Republic",
                                                color: Colors.black,
                                                fontSize: 14.sp)
                                          ],
                                        ),
                                      ),
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
