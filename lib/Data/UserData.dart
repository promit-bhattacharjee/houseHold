// import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';
// class Userdata{
//
//   Future<String> getUserData(email) async {
//     var userEmail = email;
//     try {
//       FirebaseFirestore firestore = FirebaseFirestore.instance;
//       var querySnapshot = await firestore.collection('users')
//           .where("email", isEqualTo: userEmail)
//           .get();
//       final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
//       if(allData[0].isNotEmpty)
//         {
//           return jsonEncode(allData[0]).toString();
//         }
//       else{
//         return "false";
//       }
//     } catch (e) {
//       print('Error: $e');
//       return "false";
//     }
//   }
// }
