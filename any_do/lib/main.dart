import 'dart:ui';
import 'package:any_do/auth/authscreen.dart';
import 'package:any_do/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() => runApp (new MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder(stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, usersnapshot){
          if(usersnapshot.hasData){
            return Home();
          }
          else{
            return AuthScreen();
          }
      },),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
         // ignore: prefer_const_constructors
         appBarTheme: AppBarTheme(
          backgroundColor: Colors.purple
         ),
        brightness: Brightness.dark,
        primaryColor: Colors.purple,
        primarySwatch: Colors.purple),
    );
  }
}


