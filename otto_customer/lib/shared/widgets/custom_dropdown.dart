import 'package:otto_customer/shared/widgets/all_package.dart';



class CustomDropDown extends StatefulWidget {
  const CustomDropDown(
      {Key? key,
      required this.dropDownValue,
      required this.onChanged,
      required this.items,
      required this.isExpanded,
      this.selectedItemBuilder,
      this.onTap,
      this.isValueEmpty = false,
      this.isDisabled = false,
      this.hintText})
      : super(key: key);
  final String? dropDownValue;
  final String? hintText;
  final bool isExpanded;
  final bool isValueEmpty;
  final bool isDisabled;
  final Function(String?) onChanged;
  final Function()? onTap;
  final dynamic selectedItemBuilder;
  final List<DropdownMenuItem<String>> items;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  // List of items in our dropdown menu

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      decoration: BoxDecoration(
          color: widget.isDisabled
              ? AppColors.black3
              // : Colors.transparent,
              : AppColors.grey,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
              color: widget.isValueEmpty ? AppColors.red : AppColors.borderGrey,
              width: 1)),
      child: IgnorePointer(
        ignoring: widget.isDisabled,
        child: DropdownButton<String>(
          hint: Text(
            widget.hintText ?? "Select",
            // style: TextStyle(fontFamily: 'Inter', fontSize: 14.sp),
            style: TextStyle(fontSize: 16.sp, color: AppColors.black2),
          ),
          style: TextStyle(fontSize: 16.sp, color: AppColors.blackText),
          underline: SizedBox(),
          isExpanded: widget.isExpanded,
          onTap: widget.onTap,
          value: widget.dropDownValue,
          icon: const Icon(Icons.keyboard_arrow_down_sharp,
              color: AppColors.iconGrey, size: 16),
          items: widget.items,
          onChanged: widget.onChanged,
          selectedItemBuilder: widget.selectedItemBuilder,
        ),
      ),
    );
  }
}



class DropdownItem<T> {
  final String displayText;
  final T value;
  final String uniqueIdentifier;

  DropdownItem({
    required this.displayText,
    required this.value,
    required this.uniqueIdentifier,
  });
}

class CustomDropdown<T> extends StatefulWidget {
  final List<DropdownItem<String>> items;
  final String? value;
  // final ValueChanged<String?>? onChanged;
  final Function(DropdownItem<String>?)? onChanged;
  final bool isDisabled;
  final bool isValueEmpty;
  final String? hintText;
  final bool isExpanded;
  final dynamic selectedItemBuilder;

  const CustomDropdown({super.key,
    required this.items,
    this.value,
    this.onChanged,
    this.isDisabled = false,
    this.isValueEmpty = false,
    this.hintText,
    this.isExpanded = false,
    this.selectedItemBuilder,
  });

  @override
  _CustomDropdownState<T> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      decoration: BoxDecoration(
          color: widget.isDisabled
              ? AppColors.black3
          // : Colors.transparent,
              : AppColors.grey,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
              color: widget.isValueEmpty ? AppColors.red : AppColors.borderGrey,
              width: 1)),
      child: IgnorePointer(
        ignoring: widget.isDisabled,
        child: DropdownButton<DropdownItem<String>>(
          value: _selectedValue == null
          ? null
              : widget.items
              .firstWhere((item) => item.value == _selectedValue),
          hint: Text( widget.hintText ?? "Select",
            // style: TextStyle(fontFamily: 'Inter', fontSize: 14.sp),
            style: TextStyle(fontSize: 14.sp, color: AppColors.blackText),),
          isExpanded: widget.isExpanded,
          underline: SizedBox(),
          // onChanged: widget.onChanged,
          onChanged: (DropdownItem<String>? newValue) {
            setState(() {
              _selectedValue = newValue?.value ?? '';
            });

            if (widget.onChanged != null) {
              widget.onChanged!(newValue!);
            }
          },
          icon: const Icon(Icons.keyboard_arrow_down_sharp,
              color: AppColors.iconGrey, size: 16),
          selectedItemBuilder: widget.selectedItemBuilder,
          items: widget.items.map((item) {
            return DropdownMenuItem<DropdownItem<String>>(
              value: item,
              child: Styles.regular(item.displayText,
                  color: AppColors.blackText), // You can customize the display text here
            );
          }).toList(),
        ),
      ),
    );
  }
}




class CustomDropdownFormField<T> extends DropdownButtonFormField<T> {
  CustomDropdownFormField({
    Key? key,
    required List<DropdownMenuItem<T>> items,
    T? value,
    String? hint,
    ValueChanged<T?>? onChanged,
    FormFieldSetter<T>? onSaved,
    FormFieldValidator<T>? validator,
  }) : super(
    key: key,
    items: items,
    value: value,
    onChanged: onChanged,
    onSaved: onSaved,
    validator: validator,
    decoration: InputDecoration(
      hintText: hint,
    ),
  );
}
