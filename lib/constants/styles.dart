import 'package:flutter/material.dart';

import 'theme/colors.dart';

class AppStyles {
  /// Auth Form Field Decoration

  static getAuthFormFieldDecoration(String label) {
    const _hintColor = AppColor.hintColor;
    var _radius =  BorderRadius.circular(8.0);

    return InputDecoration(
      labelText: label,
      fillColor: AppColor.textFieldBgdColor,
      filled: true,

      labelStyle: const TextStyle(color: _hintColor),
      enabledBorder:  OutlineInputBorder(
        borderRadius: _radius,
          borderSide: BorderSide(color: AppColor.hintColor)
      ),
      focusedBorder:  OutlineInputBorder(
        borderRadius: _radius,
          borderSide: BorderSide(color: AppColor.hintColor)
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: _radius,
          borderSide: BorderSide(color: AppColor.hintColor)
      ),
      border: OutlineInputBorder(
          borderRadius: _radius,
          borderSide: BorderSide(color: AppColor.hintColor)
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    );
  }
}
