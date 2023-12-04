import 'package:otto_customer/modules/dashboard/cart/viewmodel/cart-viewmodel.dart';

import '../../../shared/widgets/all_package.dart';

class CartOrderSummaryPage extends StatelessWidget {
  CartOrderSummaryPage({Key? key}) : super(key: key);
  String? completeNo;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CartViewModel>(
      create: (_) => CartViewModel(
          // context: context,
          // authenticationService: si.authenticationService,
          ),
      child: Consumer<CartViewModel>(
        builder: (context, model, _) => Stack(
          children: [
            DefaultTabController(
              length: 2,
              child: Scaffold(
                backgroundColor: AppColors.scaffoldBGColor,
                appBar: buildAppbar(
                  context: context,
                  title: Styles.semiBold("Order Summary", color: Colors.black),
                ),
                body: SizedBox(
                  width: deviceWidth(context),
                  height: deviceHeight(context),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const HSpace(24),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12.r),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                ImageAssets.gcFrame,
                              ),
                              const HSpace(8),
                              Styles.semiBold("Chicken Republic GiftCard",
                                  color: const Color(0Xff101828),
                                  fontSize: 14.sp),
                              const HSpace(16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Styles.regular("To:",
                                      color: const Color(0Xff4F5862),
                                      fontSize: 12.sp),
                                  Styles.regular("mike@mail.com",
                                      color: const Color(0Xff4F5862),
                                      fontSize: 12.sp),
                                ],
                              ),
                              const HSpace(10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Styles.regular("From:",
                                      color: const Color(0Xff4F5862),
                                      fontSize: 12.sp),
                                  Styles.regular("Precious",
                                      color: const Color(0Xff4F5862),
                                      fontSize: 12.sp),
                                ],
                              ),
                              HSpace(12.h),
                              const Divider(),
                              const HSpace(10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Styles.bold("Message:",
                                      color: const Color(0Xff4F5862),
                                      fontSize: 12.sp),
                                  Styles.regular("Enjoy a beautiful meal 🎉",
                                      color: const Color(0Xff4F5862),
                                      fontSize: 12.sp),
                                ],
                              ),
                              const HSpace(10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Styles.regular("Total:",
                                      color: const Color(0Xff4F5862),
                                      fontSize: 12.sp),
                                  Styles.bold("₵ 500",
                                      color: const Color(0Xff4F5862),
                                      fontSize: 12.sp),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        CustomButton(
                            isActive: true,
                            margin: 0.w,
                            title: "Proceed to Payment",
                            onPress: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CartOrderSummaryPage(),
                                  ),
                                )),
                        const HSpace(100),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            newLoader(model.isLoading)
          ],
        ),
      ),
    );
  }
}
