import 'package:flutter/services.dart';
import 'package:otto_customer/modules/dashboard/cart/cart.ui.dart';
import 'package:otto_customer/modules/dashboard/gift-card/viewmodel/giftcard_vm.dart';

import '../../../shared/widgets/all_package.dart';

class SendGiftCardsPage extends StatelessWidget {
  SendGiftCardsPage({Key? key}) : super(key: key);
  String? completeNo;

  final _tabs = [
    Tab(text: 'Tab1'),
    Tab(text: 'Tab3'),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SendGiftCardViewModel>(
      create: (_) => SendGiftCardViewModel(
          // context: context,
          // authenticationService: si.authenticationService,
          ),
      child: Consumer<SendGiftCardViewModel>(
        builder: (context, model, _) => Stack(
          children: [
            DefaultTabController(
              length: 2,
              child: Scaffold(
                backgroundColor: AppColors.scaffoldBGColor,
                appBar: buildAppbar(
                  context: context,
                  title: Styles.semiBold("Gift Cards", color: Colors.black),
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
                          height: kToolbarHeight - 8.0,
                          decoration: BoxDecoration(
                            color: Color(0xffF0F2F4),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: TabBar(
                            // controller: _tabController,
                            onTap: model.updateIndex,
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white),
                            labelColor: const Color(0xff141B2B),
                            unselectedLabelColor: const Color(0xff141B2B),
                            tabs: [
                              Tab(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 4.h),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Center(
                                      child: Text(
                                        'Personal Orders',
                                        style: TextStyle(
                                          fontWeight: model.pageIndex == 0
                                              ? FontWeight.w700
                                              : FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Tab(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 4.h),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Center(
                                      child: Text(
                                        'Gift Someone',
                                        style: TextStyle(
                                          fontWeight: model.pageIndex == 1
                                              ? FontWeight.w700
                                              : FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // TabBar(
                        //   enableFeedback: false,
                        //   automaticIndicatorColorAdjustment: false,
                        //   splashFactory: NoSplash.splashFactory,
                        //   overlayColor: MaterialStateProperty.resolveWith(
                        //     (Set states) {
                        //       return states.contains(MaterialState.focused)
                        //           ? null
                        //           : Colors.transparent;
                        //     },
                        //   ),
                        //   indicatorWeight: 1,
                        //   indicatorSize: TabBarIndicatorSize.tab,
                        //   // padding: const EdgeInsets.symmetric(horizontal: 15),
                        //   indicatorPadding: const EdgeInsets.all(2),
                        //   labelPadding: EdgeInsets.zero,
                        //   indicatorColor: Colors.red,
                        //
                        //   // indicator:,
                        //   labelColor: const Color(0xff141B2B),
                        //   unselectedLabelColor: const Color(0xff141B2B),
                        //   tabs: [
                        // Tab(
                        //   child: Padding(
                        //     padding: EdgeInsets.symmetric(
                        //         horizontal: 8.w, vertical: 4.h),
                        //     child: const SizedBox(
                        //       width: double.infinity,
                        //       child: Center(
                        //         child: Text(
                        //           'Personal Orders',
                        //           style: TextStyle(
                        //             fontWeight: FontWeight.w400,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // Tab(
                        //   child: Padding(
                        //     padding: EdgeInsets.symmetric(
                        //         horizontal: 8.w, vertical: 4.h),
                        //     child: const SizedBox(
                        //       width: double.infinity,
                        //       child: Center(
                        //         child: Text(
                        //           'Gift Someone',
                        //           style: TextStyle(
                        //             fontWeight: FontWeight.w400,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        //   ],
                        // ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              RefreshIndicator(
                                onRefresh: () async => {},
                                child: const PersonalWidget(),
                              ),
                              RefreshIndicator(
                                onRefresh: () async => {},
                                child: GiftSomeoneWidget(),
                              ),
                            ],
                          ),
                        ),
                        HSpace(50)
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

class PersonalWidget extends StatelessWidget {
  const PersonalWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HSpace(24.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(SvgAssets.chickenRepublicGiftCard),
                    HSpace(16),
                    Styles.semiBold("Chicken Republic",
                        color: Color(0Xff232E38), fontSize: 14.sp)
                  ],
                ),
              ),
              HSpace(24.h),
              Styles.bold("Enter Gift Card Amount",
                  color: Color(0Xff101828), fontSize: 16.sp),
              HSpace(16.h),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter Amount",
                  hintStyle: TextStyle(
                    fontSize: 16.sp,
                  ),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xffD9DFE9)),
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              HSpace(4.h),
              Styles.regular("Minimum purchase amount is ₵ 500",
                  color: const Color(0Xff101828), fontSize: 12.sp),
              HSpace(100.h),
              CustomButton(
                  isActive: true,
                  margin: 0.w,
                  title: "Add to Cart",
                  onPress: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartPage(),
                        ),
                      )),
            ],
          ),
        ),
      )
    ]);
  }
}

class GiftSomeoneWidget extends StatelessWidget {
  GiftSomeoneWidget({
    Key? key,
  }) : super(key: key);
  ValueNotifier<SendBy> sendBy = ValueNotifier(SendBy.text);
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HSpace(24.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(SvgAssets.chickenRepublicGiftCard),
                    HSpace(16),
                    Styles.semiBold("Chicken Republic",
                        color: Color(0Xff232E38), fontSize: 14.sp)
                  ],
                ),
              ),
              HSpace(24.h),
              Styles.bold("Enter Gift Card Amount",
                  color: Color(0Xff101828), fontSize: 16.sp),
              HSpace(16.h),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter Amount",
                  hintStyle: TextStyle(
                    fontSize: 16.sp,
                  ),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xffD9DFE9)),
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              HSpace(4.h),
              Styles.regular("Minimum purchase amount is ₵ 500",
                  color: const Color(0Xff101828), fontSize: 12.sp),
              HSpace(18.h),
              const Divider(color: Colors.black26),
              HSpace(24.h),
              Styles.bold("Send via",
                  color: const Color(0Xff101828), fontSize: 16.sp),
              HSpace(16.h),
              ValueListenableBuilder(
                valueListenable: sendBy,
                builder: (context, val, _) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RadioListTile<SendBy>(
                        title: const Text('Text Message'),
                        value: SendBy.text,
                        dense: true,
                        groupValue: val,
                        onChanged: (SendBy? value) => sendBy.value = value!,
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<SendBy>(
                        title: const Text('Send by Email'),
                        dense: true,
                        value: SendBy.email,
                        groupValue: val,
                        onChanged: (SendBy? value) => sendBy.value = value!,
                      ),
                    ),
                  ],
                ),
              ),
              HSpace(24.h),
              ValueListenableBuilder(
                  valueListenable: sendBy,
                  builder: (context, val, _) => val == SendBy.text
                      ? PhoneNumberWidget(onChanged: (v) {})
                      : EmailWidget(onChanged: (v) {})),
              HSpace(16.h),
              Styles.regular("Recipient’s name",
                  color: const Color(0Xff101828), fontSize: 16.sp),
              HSpace(8.h),
              TextField(
                onChanged: (v) {},
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: "Enter Name",
                  hintStyle: TextStyle(
                    fontSize: 16.sp,
                  ),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xffD9DFE9)),
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              HSpace(16.h),
              Styles.regular("Sender’s name (optional)",
                  color: const Color(0Xff101828), fontSize: 16.sp),
              HSpace(8.h),
              TextField(
                onChanged: (v) {},
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: "Enter Name",
                  hintStyle: TextStyle(
                    fontSize: 16.sp,
                  ),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xffD9DFE9)),
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              HSpace(16.h),
              Styles.regular("Message (optional)",
                  color: const Color(0Xff101828), fontSize: 16.sp),
              HSpace(8.h),
              TextField(
                onChanged: (v) {},
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: "Enter Message",
                  hintStyle: TextStyle(
                    fontSize: 16.sp,
                  ),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xffD9DFE9)),
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              HSpace(24.h),
              CustomButton(
                  isActive: true,
                  margin: 0.w,
                  title: "Add to Cart",
                  onPress: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartPage(),
                        ),
                      )),
            ],
          ),
        ),
      )
    ]);
  }
}

class PhoneNumberWidget extends StatelessWidget {
  final Function(String) onChanged;
  PhoneNumberWidget({super.key, required this.onChanged});
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Styles.regular("Recipient’s phone number.",
            color: const Color(0Xff101828), fontSize: 16.sp),
        HSpace(8.h),
        TextField(
          onChanged: onChanged,
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            hintText: "Enter Phone Number",
            hintStyle: TextStyle(
              fontSize: 16.sp,
            ),
            suffixIcon: GestureDetector(
              onTap: () => {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SvgPicture.asset(SvgAssets.contact),
              ),
            ),
            border: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xffD9DFE9)),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
        HSpace(4.h),
        Align(
          alignment: Alignment.centerRight,
          child: Styles.bold("Select Beneficiary",
              color: const Color(0Xff526BB2), fontSize: 14.sp),
        )
      ],
    );
  }
}

class EmailWidget extends StatelessWidget {
  final Function(String) onChanged;
  EmailWidget({
    super.key,
    required this.onChanged,
  });
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Styles.regular("Recipient’s email",
            color: const Color(0Xff101828), fontSize: 16.sp),
        HSpace(8.h),
        TextField(
          onChanged: onChanged,
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            hintText: "Enter Email",
            hintStyle: TextStyle(
              fontSize: 16.sp,
            ),
            border: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xffD9DFE9)),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }
}

enum SendBy { text, email, none }
