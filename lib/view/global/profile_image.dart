import 'dart:typed_data';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../constants/theme/colors.dart';


class ProfileImage extends StatelessWidget {
  String? image;
  double? size ;
  String? status ;
  bool? online ;
  ProfileImage({Key? key,this.image,this.size,this.status,this.online}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? 52,
      height: size ?? 52,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.greyColor,
              ),
              child: image != null ?
              ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: FastCachedImage(
                  url:image!,
                  // placeholder: (context, url) =>
                  // const CircularProgressIndicator(),
                  // errorWidget: (context, url, error) =>
                  // const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ):
              const Center(child: Icon(Icons.person,size: 22,color: Colors.white,),),

            ),
          ),
        ],
      ),
    );
  }
}


class StatusIcon extends StatelessWidget {
  final Color color ;
  const StatusIcon({Key? key,required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(width: 2,color: Colors.white),
      ),
    );
  }
}

