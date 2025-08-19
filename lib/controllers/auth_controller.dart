// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import '../../services/auth_service.dart';
// import '../../utils/loading.dart';
// import '../models/user_model.dart';
// import '../routes/app_routes.dart';
// import '../services/user_database.dart';
// import 'user_controller.dart';
//
// class AuthController extends GetxController {
//
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController confirmPasswordController = TextEditingController();
//   TextEditingController nameController = TextEditingController();
//
//   ///Forgot Password
//   TextEditingController forgotPasswordController = TextEditingController();
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   final Rxn<User> _firebaseUser = Rxn<User>();
//
//   User? get user => _firebaseUser.value;
//
//   set setUser(User user) => _firebaseUser.value = user ;
//
//   /// Obscure Text
//   var _signUpObscureText = true.obs;
//
//   bool get getSignUpObscureText => _signUpObscureText.value;
//
//   void setSignUpObscureText() =>
//       _signUpObscureText.value = !_signUpObscureText.value;
//
//   var _userProfileURL = "".obs;
//
//   String get userProfileURL => _userProfileURL.value;
//
//
//
//   /// Accept TOS
//   var _checkBox = false.obs ;
//   bool get checkBox => _checkBox.value ;
//   void setCheckBox() => _checkBox.value = !_checkBox.value ;
//
//   @override
//   void onInit() {
//     _firebaseUser.bindStream(_auth.authStateChanges());
//     super.onInit();
//   }
//
//   void signUp() async {
//     Loading.show();
//     try {
//       UserCredential userCredential =
//       await _auth.createUserWithEmailAndPassword(
//           email: emailController.text, password: passwordController.text);
//      // await UserDatabase().createUser(_createUser(userCredential.user!.uid));
//       _firebaseUser.value = userCredential.user ;
//       clearControllers();
//       Get.offAll(()=>AuthWrapper());
//       Loading.dismiss();
//     } catch (e) {
//       Loading.dismiss();
//       Get.snackbar("Something’s Not Right", e.toString(), snackPosition: SnackPosition.BOTTOM);
//       print(e);
//     }
//   }
//
//
//   void login() async {
//     Loading.show();
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//           email: emailController.text, password: passwordController.text);
//       _firebaseUser.value = userCredential.user ;
//       //var user = await UserDatabase().getUser(userCredential.user!.uid);
//       // Get.find<UserController>().setUserModel = user;
//       Get.to(()=>AuthWrapper());
//       Loading.dismiss();
//       clearControllers();
//     } on FirebaseAuthException catch (e) {
//       String _errorMessage = "" ;
//       print(e.code);
//       if (e.code == 'user-not-found') {
//           _errorMessage = 'No user found for that email.';
//           Get.snackbar("Error", _errorMessage,snackPosition: SnackPosition.BOTTOM);
//       } else if (e.code == 'invalid-credential') {
//           _errorMessage = 'Email or password provided is wrong. Please try again';
//           Get.snackbar("Error", _errorMessage,snackPosition: SnackPosition.BOTTOM);
//       } else {
//           _errorMessage = 'An unknown error occurred.';
//           Get.snackbar("Error", _errorMessage,snackPosition: SnackPosition.BOTTOM);
//       }
//       Loading.dismiss();
//     } catch (e) {
//         Get.snackbar("Error", 'An error occurred. Please try again.',snackPosition: SnackPosition.BOTTOM);
//         Loading.dismiss();
//     }
//   }
//
//   void sendPasswordResetEmail() async {
//     try {
//       Loading.show();
//       await _auth.sendPasswordResetEmail(email: forgotPasswordController.text);
//       Get.back();
//       Get.snackbar("Almost there! Verify your email", "Check your inbox and follow the link",
//           snackPosition: SnackPosition.BOTTOM);
//       Loading.dismiss();
//     } catch (e) {
//       Loading.dismiss();
//       Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
//     }
//   }
//
//   // void setupUser()async{
//   //   try{
//   //     Loading.show();
//   //     await UserDatabase().updateInfo(_auth.currentUser!.uid,nameController.text,phoneNoController.text);
//   //     phoneLogin();
//   //     // Get.to(()=>AuthWrapper());
//   //   }
//   //   catch(e){
//   //     print(e);
//   //   }
//   // }
//
//   void signOut() async {
//     try {
//       await _auth.signOut();
//       Get.find<UserController>().clear();
//       Get.offAllNamed(AppRoutes.loginPage);
//     } catch (e) {
//       Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
//       print(e);
//     }
//   }
//
//   void clearControllers() {
//     emailController.clear();
//     passwordController.clear();
//     confirmPasswordController.clear();
//   }
//
//   @override
//   void onClose() {
//     emailController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     super.onClose();
//   }
// }
