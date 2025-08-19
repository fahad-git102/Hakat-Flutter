import 'package:flutter/material.dart';


class ProfilePlaceholder extends StatelessWidget {
  final String name ;
  const ProfilePlaceholder({Key? key,required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ClipRRect(
      borderRadius: BorderRadius.circular(67),
      child: Container(
          width: 52,
          height: 52,
          decoration:  BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
              border: Border.all(width: 1, color: Colors.white)
          ),
          child:
          Center(
            child: Text(getInitials(name),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white70),),
          )
      ),
    );
  }


  String getInitials(String bankAccountName) => bankAccountName.isNotEmpty
      ? bankAccountName.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()
      : '';

}
