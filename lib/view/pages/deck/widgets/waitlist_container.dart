

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
      height: 450,
      width: Get.width,
      padding: const EdgeInsets.only(top: 150,left: 20,right: 20),
      decoration: BoxDecoration(
        color:  Colors.white.withOpacity(0.4),
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
              "To bring this deck into the world in physical form is a sacred act. We honor our planet by printing only when enough kindred souls join the circle — ensuring sustainable, intentional creation.",
              textAlign: TextAlign.center,
              style:
              TextStyle(
                fontSize: 18,
                fontFamily: "Garamond",
                fontWeight: FontWeight.w400,
                letterSpacing: 1,
              ).copyWith(
                color: Colors.white,
              ), // Color must be set, but it will be masked
            ),
          AddHeight(30),
          _buildTextField(TextEditingController(), "Email"),

          // Title
        ],
      ),
    );
  }


   Widget _buildTextField(TextEditingController controller, String hint) {
     return Container(
       decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(8),
         border: Border.all(
           color: Colors.white,
           width: 1,
         ),
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