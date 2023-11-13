import 'package:otto_customer/shared/widgets/all_package.dart';


class CustomButton extends StatefulWidget {
  final Widget? icon;
  final String title;
  final VoidCallback onPress;
  final Color? txtColor;
  final double? width;
  final double? height;
  final bool hasElevation;
  final double? txtSize;
  final bool isActive;
  final Color? btnColor;
  final Color? nonActiveBtnColor;
  final FontWeight? fontWeight;
  final double margin;
  final bool? trackBtnChild;
  final Widget? btnChild;
  final bool? warningBtn;

  const CustomButton({
    Key? key,
    this.icon,
    this.warningBtn,
    required this.margin,
    required this.title,
    this.nonActiveBtnColor,
    required this.onPress,
    this.txtColor = AppColors.white,
    this.fontWeight,
    this.txtSize,
    this.width,
    this.btnColor = AppColors.primaryColor,
    this.height,
    this.isActive = false,
    this.hasElevation = false,
    this.btnChild,
    this.trackBtnChild,
  }) : super(key: key);
  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: widget.margin.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: widget.warningBtn == true ? AppColors.red : AppColors.borderGrey, //widget.txtColor!,
          width: 0.8,
        ),
        color: widget.isActive == true
            ? widget.btnColor
            : widget.nonActiveBtnColor??widget.btnColor!.withOpacity(.50),
      ),
      width: widget.width ?? deviceWidth(context).w,
      height: widget.height ?? 54.h,
      child: TextButton(
        onPressed: widget.isActive ? widget.onPress : () {},
        style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  // side: BorderSide(color: widget.btnColor!)
                  side: BorderSide(color: widget.isActive ? widget.btnColor!: widget.nonActiveBtnColor??widget.btnColor!.withOpacity(.10))
              ),
            ),
            padding: MaterialStateProperty.all(const EdgeInsets.all(6)),
            backgroundColor:
                MaterialStateProperty.all<Color>(widget.isActive ? widget.btnColor!: widget.nonActiveBtnColor??widget.btnColor!.withOpacity(.10))),
        child: widget.trackBtnChild == true
            ? widget.btnChild!
            : Styles.semiBold(
                widget.title,
                color: widget.txtColor ?? AppColors.white,
                fontSize: widget.txtSize ?? 16.sp,
              ),
      ),
    );
  }
}
