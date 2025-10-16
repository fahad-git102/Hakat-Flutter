

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/theme/colors.dart';
import '../../../global/spacing.dart';


class WaitlistContainer extends StatelessWidget {
   WaitlistContainer({super.key});



  bool soundEffects = false;
  bool backgroundMusic = false;
  bool notifications = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.only(top: 150,left: 20,right: 20),
      decoration: BoxDecoration(
        color:  Colors.grey.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
              "To bring this deck into the world in physical form is a sacred act. We honor our planet by printing only when enough kindred souls join the circle — ensuring sustainable, intentional creation.",
              style:
              TextStyle(
                fontSize: 20,
                fontFamily: "Garamond",
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
              ).copyWith(
                color: Colors.white,
              ), // Color must be set, but it will be masked
            ),
          AddHeight(30),
          _buildTextField(TextEditingController(), "Email"),
          AddHeight(20),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'JOIN THE CIRCLE',
              style:
              TextStyle(
                fontSize: 16,
                fontFamily: "Garamond",
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ).copyWith(
                color: Colors.black,
              ), // Color must be set, but it will be masked
            ),
          ),
          AddHeight(30),
          // Title
        ],
      ),
    );
  }


   Widget _buildTextField(TextEditingController controller, String hint) {
     return Container(
       decoration: BoxDecoration(
         color: Colors.black.withAlpha(70),
         borderRadius: BorderRadius.circular(8),

       ),
       child: TextField(
         controller: controller,
         style: TextStyle(
           color: Colors.white,
           fontSize: 16,
         ),
         decoration: InputDecoration(
           hintText: hint,
           hintStyle: TextStyle(
             color: Colors.white.withOpacity(0.5),
           ),
           contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
           border: InputBorder.none,
         ),
       ),
     );
   }

}