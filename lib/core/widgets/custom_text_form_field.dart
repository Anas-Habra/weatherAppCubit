import 'package:flutter/material.dart';

import '../constants/app_const.dart';
import '../theme/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final void Function(String) onSubmitted;

  const CustomTextFormField({
    super.key,
    required this.formKey,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        decoration: InputDecoration(
          prefixIconConstraints: const BoxConstraints(
            minWidth: 55,
            minHeight: 16,
          ),
          labelText: AppConstants.search,
          labelStyle: const TextStyle(fontSize: 12),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.colorDivider),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.colorDivider),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.colorDivider),
          ),
          filled: true,
          fillColor: AppColors.fillCol,
        ),
        validator: (value) {
          if ((value ?? '').isEmpty) {
            return AppConstants.enterCityName;
          } else {
            return null;
          }
        },
        onFieldSubmitted: (value) {
          if (formKey.currentState!.validate()) {
            onSubmitted(value);
          }
        },
      ),
    );
  }
}
