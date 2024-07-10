import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:house_hold/layout/UserLayout.dart';
import 'firebase_options.dart';
import 'activity/UserLogin.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures that plugin services are initialized
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget
{
  const MyApp({super.key});
@override
Widget build(BuildContext){
  return const MaterialApp(
    home: Scaffold(
      body: LoginActivity(),
    ),
      debugShowCheckedModeBanner:false,

  );
}
}
// class HomeActivity extends StatelessWidget {
//   const HomeActivity({super.key});
//   Widget build(BuildContext context)
//   {
//     return Scaffold();
//   }
// }
class LoginActivity extends StatelessWidget{
  const LoginActivity({super.key});

  @override
  Widget build(BuildContext context ) {
  return UserLogin();
  }


}
