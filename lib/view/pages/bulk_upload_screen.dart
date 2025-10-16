// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:path/path.dart' as path;
// import 'package:flutter/services.dart' show rootBundle;
//
// import '../../models/new_cards.dart';
//
// class FirebaseBulkUploader {
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   /// Convert OracleCard to Map for Firestore
//   Map<String, dynamic> oracleCardToMap(OracleCard card, String? firebaseImageUrl) {
//     return {
//       'title': card.title,
//       'image': firebaseImageUrl ?? card.image,
//       'keywords': card.keywords,
//       'description': card.description,
//       'shadowWisdom': card.shadowWisdom,
//       'mantra': card.mantra,
//       'callToIntuition': card.callToIntuition,
//       'sigilActivation': card.sigilActivation,
//       'originalImagePath': card.image, // Keep original path for reference
//       'imageUploaded': firebaseImageUrl != null,
//       'uploadedAt': firebaseImageUrl != null ? FieldValue.serverTimestamp() : null,
//     };
//   }
//
//   /// Upload a single image to Firebase Storage
//   // Future<String> uploadImage(String localImagePath, String fileName) async {
//   //   try {
//   //     File imageFile = File(localImagePath);
//   //
//   //     if (!await imageFile.exists()) {
//   //       throw Exception('Image file does not exist: $localImagePath');
//   //     }
//   //
//   //     // Create a reference to the Firebase Storage location
//   //     Reference storageRef = _storage.ref().child('oracle_cards/$fileName');
//   //
//   //     // Upload the file
//   //     UploadTask uploadTask = storageRef.putFile(imageFile);
//   //
//   //     // Wait for upload completion and get download URL
//   //     TaskSnapshot snapshot = await uploadTask;
//   //     String downloadURL = await snapshot.ref.getDownloadURL();
//   //
//   //     print('Uploaded: $fileName -> $downloadURL');
//   //     return downloadURL;
//   //
//   //   } catch (e) {
//   //     print('Error uploading $fileName: $e');
//   //     rethrow;
//   //   }
//   // }
//
//   /// Extract filename from asset path
//   String extractFileName(String assetPath) {
//     return path.basename(assetPath);
//   }
//
//   /// Upload all images and get their download URLs
//   Future<Map<String, String>> uploadAllImages(
//       String localAssetsDirectory,
//       List<OracleCard> cards
//       ) async {
//     Map<String, String> imageUrlMap = {};
//
//     try {
//       print('Starting image upload process...');
//
//       for (int i = 0; i < cards.length; i++) {
//         OracleCard card = cards[i];
//         String assetPath = card.image??'';
//         String fileName = extractFileName(assetPath);
//         // String localPath = path.join(localAssetsDirectory, fileName);
//         try {
//           // String downloadURL = await uploadImage(localPath, fileName);
//           String downloadURL = await uploadAssetImage(assetPath, fileName);
//           imageUrlMap[assetPath] = downloadURL;
//
//           print('Progress: ${i + 1}/${cards.length} images uploaded');
//         } catch (e) {
//           print('Failed to upload $fileName: $e');
//           // Continue with other images even if one fails
//         }
//       }
//
//       print('Image upload completed. Successfully uploaded ${imageUrlMap.length} images.');
//       return imageUrlMap;
//
//     } catch (e) {
//       print('Error in bulk image upload: $e');
//       rethrow;
//     }
//   }
//
//   Future<String> uploadAssetImage(String assetPath, String fileName) async {
//     try {
//       // Load the asset into memory
//       final byteData = await rootBundle.load(assetPath);
//       final Uint8List imageData = byteData.buffer.asUint8List();
//
//       // Storage reference
//       Reference storageRef = _storage.ref().child('oracle_cards/$fileName');
//
//       // Upload task
//       UploadTask uploadTask = storageRef.putData(
//         imageData,
//         SettableMetadata(contentType: 'image/png'), // adjust if JPG
//       );
//
//       // Listen to progress/errors
//       uploadTask.snapshotEvents.listen((event) {
//         print("Upload progress: ${(event.bytesTransferred / event.totalBytes) * 100}%");
//       }, onError: (e) {
//         print("Upload failed: $e");
//       });
//
//       // Wait for completion
//       TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
//       String downloadURL = await snapshot.ref.getDownloadURL();
//
//       print('✅ Uploaded: $fileName -> $downloadURL');
//       return downloadURL;
//     } catch (e) {
//       print('❌ Error uploading $fileName: $e');
//       rethrow;
//     }
//   }
//
//
//   /// Update card data with Firebase Storage URLs
//   List<Map<String, dynamic>> updateCardsWithUrls(
//       List<OracleCard> cards,
//       Map<String, String> imageUrlMap
//       ) {
//     return cards.map((card) {
//       String? firebaseUrl = imageUrlMap[card.image];
//       return oracleCardToMap(card, firebaseUrl);
//     }).toList();
//   }
//
//   /// Save cards to Firestore using batch write
//   Future<void> saveCardsToFirestore(List<Map<String, dynamic>> cards) async {
//     try {
//       print('Starting Firestore upload...');
//
//       // Firestore batch write limit is 500 operations
//       const int batchSize = 500;
//
//       for (int i = 0; i < cards.length; i += batchSize) {
//         WriteBatch batch = _firestore.batch();
//         int endIndex = (i + batchSize < cards.length) ? i + batchSize : cards.length;
//
//         for (int j = i; j < endIndex; j++) {
//           DocumentReference docRef = _firestore.collection('oracle_cards').doc();
//           batch.set(docRef, {
//             ...cards[j],
//             'createdAt': FieldValue.serverTimestamp(),
//             'id': docRef.id,
//           });
//         }
//
//         await batch.commit();
//         print('Batch ${(i ~/ batchSize) + 1} completed: ${endIndex - i} cards saved');
//       }
//
//       print('All ${cards.length} cards saved to Firestore successfully!');
//
//     } catch (e) {
//       print('Error saving cards to Firestore: $e');
//       rethrow;
//     }
//   }
//
//   /// Main method to perform complete bulk upload
//   Future<void> performBulkUpload(
//       String localAssetsDirectory,
//       List<OracleCard>? cards
//       ) async {
//     try {
//       print('=== Starting Oracle Cards Bulk Upload Process ===');
//
//       // Step 1: Upload all images to Firebase Storage
//       print('\n--- Step 1: Uploading Images ---');
//       Map<String, String> imageUrlMap = await uploadAllImages(localAssetsDirectory, cards??[]);
//
//       // Step 2: Update card data with Firebase URLs
//       print('\n--- Step 2: Updating Card Data ---');
//       List<Map<String, dynamic>> updatedCards = updateCardsWithUrls(cards??[], imageUrlMap);
//
//       // Step 3: Save cards to Firestore
//       print('\n--- Step 3: Saving to Firestore ---');
//       await saveCardsToFirestore(updatedCards);
//
//       print('\n=== Bulk Upload Process Completed Successfully! ===');
//       print('Total cards processed: ${updatedCards.length}');
//       print('Images uploaded: ${imageUrlMap.length}');
//
//     } catch (e) {
//       print('Bulk upload failed: $e');
//       rethrow;
//     }
//   }
//
//   /// Alternative method to upload only missing images
//   Future<void> uploadMissingImages(
//       String localAssetsDirectory,
//       List<OracleCard> cards
//       ) async {
//     try {
//       // Query existing cards to see which images are already uploaded
//       QuerySnapshot existingCards = await _firestore.collection('oracle_cards').get();
//       Set<String> uploadedImages = {};
//
//       for (var doc in existingCards.docs) {
//         Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//         if (data['imageUploaded'] == true && data['originalImagePath'] != null) {
//           uploadedImages.add(data['originalImagePath']);
//         }
//       }
//
//       // Filter cards that need image upload
//       List<OracleCard> cardsNeedingUpload = cards
//           .where((card) => !uploadedImages.contains(card.image))
//           .toList();
//
//       if (cardsNeedingUpload.isEmpty) {
//         print('All images are already uploaded!');
//         return;
//       }
//
//       print('Found ${cardsNeedingUpload.length} cards needing image upload');
//
//       // Upload missing images
//       Map<String, String> newImageUrls = {};
//       for (var card in cardsNeedingUpload) {
//         String assetPath = card.image??'';
//         String fileName = extractFileName(assetPath);
//         // String localPath = path.join(localAssetsDirectory, fileName);
//
//         try {
//           // String downloadURL = await uploadImage(localPath, fileName);
//           String downloadURL = await uploadAssetImage(assetPath, fileName);
//           newImageUrls[assetPath] = downloadURL;
//         } catch (e) {
//           print('Failed to upload $fileName: $e');
//         }
//       }
//
//       print('Uploaded ${newImageUrls.length} new images');
//
//     } catch (e) {
//       print('Error uploading missing images: $e');
//       rethrow;
//     }
//   }
// }
//
// // Usage example:
// class OracleCardsUploadScreen extends StatefulWidget {
//   const OracleCardsUploadScreen({super.key});
//
//   @override
//   State<StatefulWidget> createState() => _OracleCardsUploadScreenState();
// }
//
// class _OracleCardsUploadScreenState extends State<OracleCardsUploadScreen> {
//   final FirebaseBulkUploader _uploader = FirebaseBulkUploader();
//   bool _isUploading = false;
//   String _uploadStatus = '';
//
//   Future<void> _startBulkUpload() async {
//     setState(() {
//       _isUploading = true;
//       _uploadStatus = 'Starting upload process...';
//     });
//
//     try {
//       // Update this path to match your local assets directory
//       String localAssetsDirectory = '/path/to/your/local/assets/cards/';
//
//       // Pass your oracleCards list to the uploader
//       // await _uploader.performBulkUpload(localAssetsDirectory, oracleCards);
//       await _uploader.performBulkUpload(localAssetsDirectory, []);
//
//       setState(() {
//         _uploadStatus = 'Upload completed successfully!';
//       });
//
//     } catch (e) {
//       setState(() {
//         _uploadStatus = 'Upload failed: $e';
//       });
//     } finally {
//       setState(() {
//         _isUploading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Oracle Cards Bulk Upload'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Text(
//               'Total Cards: ${[].length}',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _isUploading ? null : _startBulkUpload,
//               child: Text(_isUploading ? 'Uploading...' : 'Start Bulk Upload'),
//             ),
//             SizedBox(height: 20),
//             if (_uploadStatus.isNotEmpty)
//               Container(
//                 padding: EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Text(
//                   _uploadStatus,
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//             if (_isUploading)
//               Padding(
//                 padding: EdgeInsets.only(top: 20),
//                 child: CircularProgressIndicator(),
//               ),
//             Expanded(child: ListView.builder(
//                 itemCount: oracleCards.length,
//                 shrinkWrap: true,
//                 itemBuilder: (context, index){return Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Image.asset(oracleCards[index].image, height: 150,),
//                 Text(oracleCards[index].title),
//                 SizedBox(height: 10,)
//               ],
//             );}))
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // Instructions for usage:
// /*
// 1. Add the required dependencies to your pubspec.yaml
// 2. Make sure Firebase is properly configured in your Flutter app
// 3. Import your OracleCard model file at the top
// 4. Update the localAssetsDirectory path to point to your local images folder
// 5. Call performBulkUpload(localAssetsDirectory, oracleCards) to start the process
//
// Example directory structure:
// /your_project_folder/assets/cards/
//   ├── Leo, the Father.png
//   ├── Bobo, the Child.png
//   ├── Shella, the Queen.png
//   └── ... (all other card images)
//
// Usage example:
// FirebaseBulkUploader uploader = FirebaseBulkUploader();
// await uploader.performBulkUpload('/path/to/assets/cards/', oracleCards);
// */