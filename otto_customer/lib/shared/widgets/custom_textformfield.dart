// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otto_customer/shared/utils/color.dart';
import 'package:otto_customer/shared/utils/styles.dart';
import 'package:otto_customer/shared/widgets/space.dart';

class CustomTextFormField extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? suffix;
  final bool? obscureText;
  String? hintText;
  final Widget? icon;
  String? label;
  Color? labelColor;
  final String? Function(String?)? validator;
  final void Function(String)? onSaved;
  Function()? onTap;
  Color? fillingColor;
  bool autofocus;
  bool isEnabled;
  TextInputType? keyboardType;
  int? maxLines;
  TextInputType? textInputType;
  TextEditingController? controller;
  List<TextInputFormatter>? inputFormatters;
  String? labelText;
  bool? filled;
  bool? useUnderline;
  AutovalidateMode? autovalidateMode;

  CustomTextFormField(
      {Key? key,
        this.textInputType,
        this.prefixIcon,
        this.suffixIcon,
        this.autovalidateMode,
        this.maxLines = 1,
        this.label = '',
        this.icon,
        this.labelColor,
        this.fillingColor = AppColors.grey,
        this.hintText = '',
        this.obscureText,
        this.controller,
        this.validator,
        this.onSaved,
        this.onTap,
        this.autofocus = false,
        this.isEnabled = true,
        this.keyboardType,
        this.inputFormatters,
        this.labelText,
        this.filled = true,
        this.useUnderline = false,
        this.suffix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        useUnderline == true
            ? const SizedBox.shrink()
            : Text(
          label!,
          style: TextStyle(
              fontSize: 16.sp,
              color: labelColor ?? AppColors.black2,
              fontWeight: FontWeight.w400),
        ),
        useUnderline == true ? HSpace(0.h) : HSpace(8.h),
        TextFormField(
          // textAlign: useUnderline == true ? TextAlign.center : TextAlign.left,
          style: TextStyle(
              color: AppColors.blackText,
              letterSpacing: useUnderline == true ? 5.0 : 0.0,
              fontSize: useUnderline == true ? 30.sp : 14.sp,
              fontWeight: FontWeight.w400),
          enabled: isEnabled,
          textCapitalization: TextCapitalization.sentences,
          autovalidateMode: autovalidateMode,
          inputFormatters: inputFormatters,
          controller: controller,
          onTap: onTap,
          maxLines: maxLines,
          obscureText: obscureText ?? false,
          obscuringCharacter: '*',
          keyboardType: textInputType,
          validator: validator,
          onChanged: onSaved,
          decoration: InputDecoration(
            suffix: suffix,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            // helperText: labelText,
            labelText: labelText,
            // label: Padding(
            //   padding: EdgeInsets.only(top: 35.h),
            //   child: Styles.regular(
            //     labelText ?? "",
            //     fontSize: 16.sp,
            //     color: AppColors.black,
            //   ),
            // ),
            labelStyle: TextStyle(
              fontSize: 16.sp,
              color: AppColors.blackText,
            ),
            helperStyle: TextStyle(
              fontSize: 16.sp,
              color: AppColors.black,
            ),
            // errorStyle: const TextStyle(color: AppColors.red,),
            errorStyle: TextStyle(color: AppColors.red, height: 0.2.h, ),
            contentPadding:
            // EdgeInsets.only(top: 21.h, bottom: 21.h, left: 20.w),
            EdgeInsets.only(top: 18.h, bottom: 18.h, left: 20.w),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 1.5.w,
                style: BorderStyle.solid,
              ),
            ),
            fillColor: useUnderline == true ? Colors.transparent : fillingColor,
            filled: filled ?? false,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: TextStyle(
                color: AppColors.hintTextColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400),
            focusedBorder: useUnderline == true
                ? const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black26))
                : OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                borderSide: BorderSide(
                    color: AppColors.primaryColor,
                    width: 2.w,
                    style: BorderStyle.solid)),
            enabledBorder: useUnderline == true
                ? const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black26))
                : OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                borderSide: BorderSide(
                    color: AppColors.borderGrey,
                    width: 0.5.w,
                    style: BorderStyle.solid)),
            errorBorder: useUnderline == true
                ? const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black26))
                : OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                borderSide: BorderSide(
                    color: AppColors.red,
                    width: 0.5.w,
                    style: BorderStyle.solid)),
          ),
        ),
      ],
    );
  }
}



// class CustomTextFormField extends StatefulWidget {
//   final Widget? prefixIcon;
//   final Widget? suffixIcon;
//   final Widget? suffix;
//   final bool? obscureText;
//   String? hintText;
//   final Widget? icon;
//   String? label;
//   Color? labelColor;
//   final String? Function(String?)? validator;
//   final void Function(String)? onSaved;
//   Function()? onTap;
//   Color? fillingColor;
//   bool autofocus;
//   bool isEnabled;
//   TextInputType? keyboardType;
//   int? maxLines;
//   TextInputType? textInputType;
//   TextEditingController? controller;
//   List<TextInputFormatter>? inputFormatters;
//   String? labelText;
//   bool? filled;
//   bool? useUnderline;
//   AutovalidateMode? autovalidateMode;
//   final FocusNode? textFormFieldFocusNode;
//
//   CustomTextFormField({
//     Key? key,
//     this.textInputType,
//     this.prefixIcon,
//     this.suffixIcon,
//     this.autovalidateMode,
//     this.maxLines = 1,
//     this.label = '',
//     this.icon,
//     this.labelColor,
//     this.fillingColor = AppColors.primaryBgColor,
//     this.hintText = '',
//     this.obscureText,
//     this.controller,
//     this.validator,
//     this.onSaved,
//     this.onTap,
//     this.autofocus = false,
//     this.isEnabled = true,
//     this.keyboardType,
//     this.inputFormatters,
//     this.labelText,
//     this.filled = true,
//     this.useUnderline = false,
//     this.suffix,
//     this.textFormFieldFocusNode,
//   }) : super(key: key);
//
//   @override
//   _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
// }
//
// class _CustomTextFormFieldState extends State<CustomTextFormField> {
//   Color containerBorderColor = AppColors.borderGrey;
//
//   @override
//   Widget build(BuildContext context) {
//     return Focus(
//       focusNode: widget.textFormFieldFocusNode,
//       onFocusChange: (hasFocus) {
//         setState(() {
//           containerBorderColor = hasFocus ? AppColors.primaryColor : AppColors.borderGrey;
//         });
//       },
//       child: Container(
//         height: 56.h,
//         padding: EdgeInsets.only(left: 20.w, top: 5.h),
//         decoration: BoxDecoration(
//           color: AppColors.grey,
//           borderRadius: BorderRadius.circular(12.r),
//           border: Border.all(
//             color: containerBorderColor,
//             width: 1,
//           ),
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               flex: 5,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   widget.useUnderline == true
//                       ? const SizedBox.shrink()
//                       : Text(
//                     widget.label!,
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       color: widget.labelColor ?? AppColors.black2,
//                       fontFamily: 'SF Pro Display',
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   HSpace(16.h),
//                   Expanded(
//                     child: SizedBox(
//                       height: 56,
//                       child: TextFormField(
//                         textAlign: widget.useUnderline == true
//                             ? TextAlign.center
//                             : TextAlign.left,
//                         style: TextStyle(
//                           color: AppColors.black,
//                           letterSpacing: widget.useUnderline == true ? 5.0 : 0.0,
//                           fontSize: widget.useUnderline == true ? 30.sp : 16.sp,
//                           fontWeight: FontWeight.w400,
//                         ),
//                         enabled: widget.isEnabled,
//                         textCapitalization: TextCapitalization.sentences,
//                         autovalidateMode: widget.autovalidateMode,
//                         inputFormatters: widget.inputFormatters,
//                         controller: widget.controller,
//                         onTap: widget.onTap,
//                         maxLines: widget.maxLines,
//                         obscureText: widget.obscureText ?? false,
//                         obscuringCharacter: '*',
//                         keyboardType: widget.textInputType,
//                         validator: (value) {
//                           if (widget.validator != null) {
//                             // Validate the input value
//                             final error = widget.validator!(value);
//                             // Update the border color if there's an error
//                             setState(() {
//                               containerBorderColor =
//                               error == null ? containerBorderColor : Colors.red;
//                             });
//                             return error;
//                           }
//                           return null;
//                         },
//                         onChanged: widget.onSaved,
//                         decoration: InputDecoration(
//                           suffix: widget.suffix,
//                           labelText: widget.labelText,
//                           // errorStyle: const TextStyle(color: AppColors.red),
//                           errorStyle: const TextStyle(color: Colors.transparent, height: 56),
//                           contentPadding:
//                           EdgeInsets.only(top: 24.h, bottom: 24.h, left: 0.w),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12.r),
//                             borderSide: BorderSide(
//                               color: Colors.transparent,
//                               width: 1.5.w,
//                               style: BorderStyle.solid,
//                             ),
//                           ),
//                           // fillColor: widget.useUnderline == true
//                           //     ? Colors.transparent
//                           //     : widget.fillingColor ?? Colors.transparent,
//                           // filled: widget.filled ?? false,
//                           filled: false,
//                           prefixIcon: widget.prefixIcon,
//                           // suffixIcon: widget.suffixIcon,
//                           hintText: widget.hintText,
//                           hintStyle: TextStyle(
//                             color: AppColors.black2,
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.w400,
//                           ),
//                           focusedBorder: widget.useUnderline == true
//                               ? const UnderlineInputBorder(
//                               borderSide: BorderSide(color: Colors.black26))
//                               : OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(12.r)),
//                             borderSide: BorderSide(
//                               color: Colors.transparent,
//                               width: 0.5.w,
//                               style: BorderStyle.none,
//                             ),
//                           ),
//                           enabledBorder: widget.useUnderline == true
//                               ? const UnderlineInputBorder(
//                               borderSide: BorderSide(color: Colors.black26))
//                               : OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(12.r)),
//                             borderSide: BorderSide(
//                               color: Colors.transparent,
//                               width: 0.5.w,
//                               style: BorderStyle.solid,
//                             ),
//                           ),
//                           errorBorder: widget.useUnderline == true
//                               ? const UnderlineInputBorder(
//                               borderSide: BorderSide(color: Colors.black26))
//                               : OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(12.r)),
//                             borderSide: BorderSide(
//                               // color: Colors.red,
//                               color: Colors.transparent,
//                               width: 0.5.w,
//                               style: BorderStyle.solid,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(child: widget.suffixIcon??const SizedBox())
//           ],
//         ),
//       ),
//     );
//   }
// }

