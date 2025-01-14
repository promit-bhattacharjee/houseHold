import 'dart:convert';
import 'dart:developer';
import 'dart:js_interop';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'HomeActivity.dart';
import 'SignupActivity.dart';
import 'DefaultSnackBar.dart'; // Assuming you have a custom Snackbar widget
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Data/UserData.dart';
class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }
  Future<String> getUserData(email) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      var querySnapshot = await firestore.collection('users')
          .where("email", isEqualTo: email)
          .get();
      final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      if(allData[0].isNotEmpty)
        {
          return jsonEncode(allData[0]).toString();
        }
      else{
        return "false";
      }
    } catch (e) {
      print('Error: $e');
      return "false";
    }
  }

  Future<void> checkLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? user = prefs.getBool('user');

    if (user == true) {
      final String userData = prefs.getString('userData').toString();
      DefaultSnackbar.SuccessSnackBar("SuccessFully Loged In ",context);
      Future.delayed(Duration(seconds: 1),(){
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeActivity(data:userData),
            ));
      });

    }
  }

  Future<void> setLoginStatus(userData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('user', true);
    prefs.setString('userData', userData);

  }

  void checkLogin(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Assuming getUserData returns a Future<String>
      String userData = await getUserData(_emailController.text); // Make sure getUserData() returns a String
      print(userData);
      await setLoginStatus(userData);
      DefaultSnackbar.SuccessSnackBar("SuccessFully Loged In ",context);
      Future.delayed(Duration(seconds: 1),(){
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeActivity(data:userData.toString()),
            ));
      });

    } on FirebaseAuthException catch (e) {
      // Handle Firebase Auth exceptions
      DefaultSnackbar.AlertSnackBar(e.code, context);
    } catch (e) {
      // Handle other exceptions
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () => checkLogin(context),
              child: Text("Submit"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextButton(
                    onPressed: () {},
                    child: Text("Forget Password"),
                    style: TextButton.styleFrom(
                      minimumSize: Size(50, 50),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignupActivity()),
                      );
                    },
                    child: Text("Sign Up"),
                    style: TextButton.styleFrom(
                      minimumSize: Size(50, 50),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
