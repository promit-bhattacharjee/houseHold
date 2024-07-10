import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:house_hold/activity/UserLogin.dart';

class HomeActivity extends StatelessWidget {
  final String data;

  HomeActivity({Key? key, required this.data}) : super(key: key);

  // Method to decode JSON data
  Map<String, dynamic> getUserData() {
    return jsonDecode(data);
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> userData = getUserData();
    String role = userData['role']; // Assuming 'role' is part of user data

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Text("Welcome, ${userData['name']}"), // Display user's name or other data
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: buildDrawerOptions(context, role),
        ),
      ),
    );
  }

  List<Widget> buildDrawerOptions(BuildContext context, String role) {
    List<Widget> options = [];
    options.add(
      ListTile(
        leading: Icon(Icons.arrow_back),
        onTap: () {
          // Close the drawer when the back button is tapped
          Navigator.pop(context);
        },
      ),
    );
      options.addAll([
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Home'),
          onTap: () {
            // Navigate to profile details screen for renters
          },
        ),
        ListTile(
          leading: Icon(Icons.info),
          title: Text('Profile Details'),
          onTap: () {
            // Navigate to profile details screen for renters
          },
        ),
        ListTile(
          leading: Icon(Icons.list),
          title: Text('Appointment List'),
          onTap: () {
            // Navigate to appointment list screen for renters
          },
        ),

        ListTile(
          leading: Icon(Icons.list_alt),
          title: Text('See Listings'),
          onTap: () {
            // Navigate to see listings screen for holders
          },
        ),
      ListTile(
        leading: Icon(Icons.logout),
        title: Text('Logout'),
        onTap: () async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('user', false);
          FirebaseAuth.instance.signOut(); // Sign out the user
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => UserLogin()),
          ); // Close the drawer and navigate to login or another screen
        },
      ),
    ]);


    return options;
  }
}
