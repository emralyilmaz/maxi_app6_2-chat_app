import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maxi_app6_2_shop_app/screen/auth_screen.dart';
import 'package:maxi_app6_2_shop_app/screen/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        backgroundColor: Colors.pink,
        accentColor: Colors.deepPurple,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        // stateless widget içerisinde yapmak için
        stream: FirebaseAuth.instance.authStateChanges(),
        // eskiden onAuthStateChanged kullanılıyordu.
        builder: (ctx, userSnapshot) {
          if (userSnapshot.hasData) {
            return ChatScreen();
          }
          return AuthScreen();
        },
      ),
      // StreamBuilder ile chatscreen ve authscreen arasında geçiş yapılmasını kolaylaştırıyoruz.
    );
  }
}
