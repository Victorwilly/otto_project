// ignore_for_file: unnecessary_null_comparison, duplicate_ignore

import 'package:flutter/services.dart';

// ignore: unused_import
import 'constants.dart';

TextInputType inputType(KeyboardType textInputType) {
  if (textInputType == KeyboardType.email) {
    return TextInputType.emailAddress;
  }
  if (textInputType == KeyboardType.number ||
      textInputType == KeyboardType.phone) {
    return TextInputType.number;
  }
  return TextInputType.visiblePassword;
}

List<TextInputFormatter> inputFormatter(KeyboardType textInputType) {
  if (textInputType == KeyboardType.number) {
    return <TextInputFormatter>[
      LengthLimitingTextInputFormatter(10),
      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
    ];
  }
  if (textInputType == KeyboardType.phone) {
    return <TextInputFormatter>[
      LengthLimitingTextInputFormatter(11),
      // LengthLimitingTextInputFormatter(14),

      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      // FilteringTextInputFormatter.allow(RegExp(phoneNumberRegex)),
      // FilteringTextInputFormatter.allow(RegExp(r'^([0|\+[0-9]{1,5})?([0-9]{10})$')),
      // FilteringTextInputFormatter.allow(RegExp(r'^(?:[+0]9)?[0-9]{10}$')),
    ];
  }
  return <TextInputFormatter>[];
}

class MaskedTextInputFormatter extends TextInputFormatter {
  final String mask;
  final String separator;

  MaskedTextInputFormatter({
    required this.mask,
    required this.separator,
    // ignore: unnecessary_null_comparison
  }) {
    assert(mask != null);
    assert(separator != null);
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > mask.length) return oldValue;
        if (newValue.text.length < mask.length &&
            mask[newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text:
                '${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      }
    }
    return newValue;
  }
}

enum KeyboardType { regular, email, number, phone }
