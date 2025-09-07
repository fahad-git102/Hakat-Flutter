import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hakat/controllers/user_controller.dart';
import 'package:hakat/view/pages/subscription/monthly_subscription_page.dart';
import '../../../constants/icons.dart';
import '../../../controllers/subscriptions_controller.dart';
import '../../global/custom_appbar.dart';
import '../../global/spacing.dart';
import '../root_page.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'annual_subscriber.dart';

enum SubscriptionType {
  monthly,
  annual,
  none,
}

class SubscriptionsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SubscriptioPageState();
}

class _SubscriptioPageState extends State<SubscriptionsPage>{

  final SubscriptionsController controller = Get.find<SubscriptionsController>();
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              width: Get.width,
              height: Get.height,
              child: Image.asset(AppIcon.smokey_bg, fit: BoxFit.fill),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Column(
                children: [
                  AddHeight(4),
                  CustomAppBar(text: "MY ACCOUNT"),
                  const SizedBox(height: 20),
                  Container(
                    height: Get.height / 1.3,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 68,
                          left: 15,
                          right: 15,
                          child: _buildWidget(),
                        ),
                        Positioned(
                          top: 15,
                          child: Image.asset(
                            "assets/logo.png",
                            width: 105,
                            height: 100,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildWidget(){
    return Container(
      width: Get.width,
      padding: const EdgeInsets.only(top: 50,left: 20,right: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            Color(0xFF201C27).withOpacity(0.8),
            Color(0xFF282433).withOpacity(0.7),
          ],
        ), // Dark background
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback: (bounds) =>
                  LinearGradient(
                    colors: [Color(0xFFEBCD8C), Color(0xFFA47E4D)],
                  ).createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
              child: Text(
                "Unlock Full Access",
                style:
                TextStyle(
                  fontSize: 26,
                  fontFamily: "Garamond_Italic",
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                ).copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 6),
            ShaderMask(
              shaderCallback: (bounds) =>
                  LinearGradient(
                    colors: [Color(0xFFEBCD8C), Color(0xFFA47E4D)],
                  ).createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
              child: Text(
                "A DEEPER JOURNEY BEGINS HERE.",
                textAlign: TextAlign.center,
                style:
                TextStyle(
                  fontSize: 12,
                  fontFamily: "Literata",
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                ).copyWith(
                  color: Colors.white,
                ), // Color must be set, but it will be masked
              ),
            ),
            AddHeight(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Image.asset('assets/stars.png',width: 20,height: 100,),
                ),
                AddWidth(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "All spreads uplocked.",
                      style:
                      TextStyle(
                        fontSize: 18,
                        fontFamily: "Garamond",
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w400,
                      ).copyWith(
                        color: Colors.white,
                      ), // Color must be set, but it will be masked
                    ),
                    AddHeight(10),
                    Text(
                      "Chaos mode: access the wild card.",
                      style:
                      TextStyle(
                        fontSize: 18,
                        fontFamily: "Garamond",
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w400,
                      ).copyWith(
                        color: Colors.white,
                      ), // Color must be set, but it will be masked
                    ),
                    AddHeight(10),
                    Text(
                      "Save your readings & journal.",
                      style:
                      TextStyle(
                        fontSize: 18,
                        fontFamily: "Garamond",
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w400,
                      ).copyWith(
                        color: Colors.white,
                      ), // Color must be set, but it will be masked
                    ),
                  ],
                )
              ],
            ),
            AddHeight(20),
            Text(
              "(1-Card Pull, Always Free)",
              style:
              TextStyle(
                fontSize: 20,
                fontFamily: "Garamond_Italic",
                letterSpacing: 1.2,
                fontWeight: FontWeight.w400,
              ).copyWith(
                color: Colors.white,
              ), // Color must be set, but it will be masked
            ),
            AddHeight(30),
            // Row(
            //   children: [
            //     Expanded(
            //       child: InkWell(
            //         onTap: (){
            //           Get.to(()=> MonthlySubscriberScreen());
            //         },
            //         child: Container(
            //           padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
            //           height: 65,
            //           decoration:  BoxDecoration(
            //             borderRadius: BorderRadius.circular(5),
            //             image: DecorationImage(
            //               fit: BoxFit.fill,
            //               image: AssetImage('assets/images/gold_effect.jpg'),
            //             ),
            //           ),
            //           child: Center(
            //             child: Container(
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(5),
            //                 color: Colors.white,
            //                 gradient: LinearGradient(colors: [
            //                   Color(0xFF49415D),
            //                   Color(0xFF786F8E),
            //                 ],),
            //
            //               ),
            //               child:   Center(
            //                 child: Text(
            //                   "SUBSCRIBE\nMONTHLY",
            //                   style:
            //                   TextStyle(
            //                     fontSize: 17,
            //                     fontFamily: "Sanford",
            //                     letterSpacing: 1.2,
            //                     fontWeight: FontWeight.w400,
            //                   ).copyWith(
            //                     color: Colors.white,
            //                   ), // Color must be set, but it will be masked
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //     AddWidth(10),
            //     Expanded(
            //       child: InkWell(
            //         onTap: (){
            //           Get.to(()=> AnnualSubscriberScreen());
            //         },
            //         child: Container(
            //           padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
            //           height: 65,
            //           decoration:  BoxDecoration(
            //             borderRadius: BorderRadius.circular(5),
            //             image: DecorationImage(
            //               fit: BoxFit.fill,
            //               image: AssetImage('assets/images/gold_effect.jpg'),
            //             ),
            //           ),
            //           child: Center(
            //             child: Container(
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(5),
            //                 color: Colors.white,
            //                 gradient: LinearGradient(colors: [
            //                   Color(0xFF49415D),
            //                   Color(0xFF786F8E),
            //                 ],),
            //
            //               ),
            //               child:   Center(
            //                 child: Text(
            //                   "SUBSCRIBE\nANNUALLY",
            //                   style:
            //                   TextStyle(
            //                     fontSize: 17,
            //                     fontFamily: "Sanford",
            //                     letterSpacing: 1.2,
            //                     fontWeight: FontWeight.w400,
            //                   ).copyWith(
            //                     color: Colors.white,
            //                   ), // Color must be set, but it will be masked
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            Obx(() {
              final packages = controller.availablePackages;

              if (packages.isEmpty) {
                return Center(child: Text("No subscriptions available"));
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(packages.length, (index) {
                  final package = packages[index];
                  final product = package.storeProduct;

                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            try {
                              EasyLoading.show();
                              PurchaseResult purchaserInfo = await Purchases.purchasePackage(package);
                              bool isPro = purchaserInfo.customerInfo.entitlements.all["pro"]?.isActive ?? false;
                              EasyLoading.dismiss();
                              if (isPro) {
                                await userController.updateUserSubscription(
                                  uid: userController.currentUser.value?.uid??'',
                                  isSubscribed: true,
                                  subscribedPlan: product.title.toLowerCase().contains('monthly')?SubscriptionType.monthly:SubscriptionType.annual,
                                );
                                Get.snackbar("Success", product.title.toLowerCase().contains('monthly')?'You are a monthly subscriber now.':'You are an annual subscriber now.');
                              } else {
                                print("❌ Not subscribed");
                              }
                            } on PlatformException catch (e) {
                              EasyLoading.dismiss();
                              if (e.details["readable_error_code"] == "PURCHASE_CANCELLED") {
                                print(e.message);
                                Get.snackbar('Error', e.message??'');
                              } else {
                                print("Other error: ${e.details}");
                              }
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                            height: 65,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/images/gold_effect.jpg'),
                              ),
                            ),
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  gradient: LinearGradient(
                                    colors: [Color(0xFF49415D), Color(0xFF786F8E)],
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    // dynamic label
                                    product.title.toLowerCase().contains('monthly')?'SUBSCRIBE\nMONTHLY':'SUBSCRIBE\nANNUALLY',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: "Sanford",
                                      letterSpacing: 1.2,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        AddHeight(10),
                        Text(
                          product.title.contains('Annual')?"\$${product.priceString}/year\n(Save 30%)":"\$${product.priceString}/month",
                          textAlign: TextAlign.center,
                          style:
                          TextStyle(
                            fontSize: 18,
                            fontFamily: "Garamond",
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w400,
                          ).copyWith(
                            color: Colors.white,
                          ), // Color must be set, but it will be masked
                        ),
                      ],
                    ),
                  );
                }),
              );
            }),

            // AddHeight(10),
            // Row(
            //   children: [
            //     Expanded(
            //       child: Text(
            //         "\$5.99/month",
            //         textAlign: TextAlign.center,
            //         style:
            //         TextStyle(
            //           fontSize: 18,
            //           fontFamily: "Garamond",
            //           letterSpacing: 1.2,
            //           fontWeight: FontWeight.w400,
            //         ).copyWith(
            //           color: Colors.white,
            //         ), // Color must be set, but it will be masked
            //       ),
            //     ),
            //     AddWidth(10),
            //     Expanded(
            //       child: Text(
            //         "\$49.99/year\n(Save 30%)",
            //         textAlign: TextAlign.center,
            //         style:
            //         TextStyle(
            //           fontSize: 18,
            //           fontFamily: "Garamond",
            //           letterSpacing: 1.2,
            //           fontWeight: FontWeight.w400,
            //         ).copyWith(
            //           color: Colors.white,
            //         ), // Color must be set, but it will be masked
            //       ),
            //     ),
            //   ],
            // ),
            AddHeight(30),
            Divider(color: Colors.black,),
            AddHeight(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already Subscribed? ",
                  style:
                  TextStyle(
                    fontSize: 17,
                    fontFamily: "Garamond",
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w400,
                  ).copyWith(
                    color: Colors.white.withAlpha(90),
                  ), // Color must be set, but it will be masked
                ),
                Text(
                  "Already Subscribed? ",
                  style:
                  TextStyle(
                    fontSize: 17,
                    decoration: TextDecoration.underline,
                    fontFamily: "Garamond",
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w600,
                  ).copyWith(
                    color: Colors.white.withAlpha(90),
                  ), // Color must be set, but it will be masked
                ),
              ],
            ),
            AddHeight(30),
          ],
        ),
      ),
    );
  }

}