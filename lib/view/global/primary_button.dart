import 'package:flutter/material.dart';
import '../../constants/dimensions.dart';
import '../../constants/styles.dart';
import '../../constants/theme/colors.dart';

class PrimaryButton extends StatelessWidget {
  final String title ;
  final VoidCallback onPressed ;
  final bool? active ;
  PrimaryButton({required this.title,required this.onPressed,this.active,Key? key}) : super(key: key);


  final _radius = BorderRadius.circular(8) ;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        //      width: Dimensions.AUTH_BUTTON_WIDTH,
        height: Dimensions.AUTH_BUTTON_HEIGHT,
        decoration: BoxDecoration(
       //   gradient:AppStyles.gradient,
          color:active ?? true ? AppColor.primaryColor : Colors.grey,
          borderRadius: _radius,
        ),
        child: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: AppColor.whiteColor,
                fontSize: Dimensions.FONT_SIZE_DEFAULT,
                fontWeight: FontWeight.bold,
              ),
            )),
      ),
    );
  }
}


class DeleteButton extends StatelessWidget {
  final String title ;
  final VoidCallback onPressed ;
  final Color? color ;
   DeleteButton({required this.title,required this.onPressed,Key? key,this.color}) : super(key: key);


  final _radius = BorderRadius.circular(8) ;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        //      width: Dimensions.AUTH_BUTTON_WIDTH,
        height: Dimensions.AUTH_BUTTON_HEIGHT,
        decoration: BoxDecoration(
          //   gradient:AppStyles.gradient,
          color: color ?? Colors.redAccent,
          borderRadius: _radius,
        ),
        child: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: AppColor.whiteColor,
                fontSize: Dimensions.FONT_SIZE_DEFAULT,
                fontWeight: FontWeight.bold,
              ),
            )),
      ),
    );
  }
}