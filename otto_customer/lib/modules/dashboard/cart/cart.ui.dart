import 'package:otto_customer/modules/dashboard/cart/cart-order-summary.dart';
import 'package:otto_customer/modules/dashboard/cart/viewmodel/cart-viewmodel.dart';

import '../../../shared/widgets/all_package.dart';

class CartPage extends StatelessWidget {
  CartPage({Key? key}) : super(key: key);
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
            Scaffold(
              backgroundColor: AppColors.scaffoldBGColor,
              appBar: buildAppbar(
                context: context,
                title: Styles.semiBold("Cart", color: Colors.black),
              ),
              body: SizedBox(
                width: deviceWidth(context),
                height: deviceHeight(context),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          children: [
                            ListItem(),
                            ListItem(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Styles.regular("Total",
                                    color: Color(0Xff101828), fontSize: 14.sp),
                                Styles.bold("₵ 1000",
                                    color: Color(0Xff101828), fontSize: 16.sp),
                              ],
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      CustomButton(
                          isActive: true,
                          margin: 0.w,
                          title: "Proceed to Payment",
                          onPress: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CartOrderSummaryPage(),
                                ),
                              )),
                      HSpace(16),
                      CustomButton(
                          isActive: true,
                          margin: 0.w,
                          title: "Add Gift Card",
                          txtColor: AppColors.black,
                          btnColor: AppColors.white,
                          onPress: () {}),
                      HSpace(100)
                    ],
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

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Image.asset(
              ImageAssets.gcFrame,
              fit: BoxFit.fill,
              height: 100.h,
              width: 86.w,
            )),
            WSpace(8.w),
            Expanded(
              child: Container(
                height: 100.h,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Styles.bold("Chicken Republic Gift Card",
                        color: Color(0Xff101828), fontSize: 14.sp),
                    Spacer(),
                    Styles.regular("₵ 500 to Esther Chukwuka",
                        color: Color(0Xff101828), fontSize: 12.sp),
                    HSpace(12)
                  ],
                ),
              ),
            ),
            SvgPicture.asset(SvgAssets.delete)
          ],
        ),
        Divider(),
      ],
    );
  }
}
