import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/theme/colors.dart';
import '../../../../controllers/auth_controller.dart';
import '../../constants/styles.dart';


class CustomTextField extends StatelessWidget {

  final String label;
  final TextInputType? inputType ;
  final TextEditingController textController ;
  final int? maxlines ;
  const CustomTextField({required this.label,required this.textController,this.inputType,this.maxlines});


  @override
  Widget build(BuildContext context) {
    const _hintColor = AppColor.hintColor ;
    var _radius =  BorderRadius.circular(12.0);


    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child:
          TextFormField(
            controller: textController,
            keyboardType: inputType ?? TextInputType.text,
            textInputAction: TextInputAction.next,
            validator: (String? value) {
              if (value==null) {
                return '$label is required';
              }
              if(value.isEmpty){
                return '$label is required';
              }
              return null;
            },
            maxLines: maxlines ?? 1,
            decoration: AppStyles.getAuthFormFieldDecoration(label),
          ),
      );

  }
}


class NotesTextField extends StatelessWidget {

  final String label;
  final TextEditingController textController ;
  const NotesTextField({required this.label,required this.textController});


  @override
  Widget build(BuildContext context) {
    const _hintColor = AppColor.hintColor ;
    var _radius =  BorderRadius.circular(12.0);


    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child:
      TextFormField(
        controller: textController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        maxLines: 3,
        decoration: AppStyles.getAuthFormFieldDecoration(label),
      ),
    );

  }
}

class ContactTextField extends StatelessWidget {

  final String label;
  final TextInputType? inputType ;
  final TextEditingController textController ;
  final int? maxlines ;
  const ContactTextField({required this.label,required this.textController,this.inputType,this.maxlines});


  @override
  Widget build(BuildContext context) {
    const _hintColor = AppColor.hintColor ;
    var _radius =  BorderRadius.circular(12.0);


    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child:
      TextFormField(
        controller: textController,
        keyboardType: inputType ?? TextInputType.number,
        textInputAction: TextInputAction.next,
        maxLines: maxlines ?? 1,
        decoration: AppStyles.getAuthFormFieldDecoration(label),
      ),
    );

  }
}
