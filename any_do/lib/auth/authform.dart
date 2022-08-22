import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}
//------------------------------------------------------


class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
var _email ="";
var _password="";
bool isLoginPage=false;
var _username="";



//---------------------------------------------------------


//---------------------------------------------------------

startauthentication(){
  final validity = _formkey.currentState!.validate();
FocusScope.of(context).unfocus();

if (validity){
  _formkey.currentState.save();
  submitform(_email, _password, _username);
}
}

submitform(String email, String password, String username)async{
final auth = FirebaseAuth.instance;
AuthResult authResult;
try{
  if(isLoginPage){
      authResult= await auth.signInWithEmailAndPassword(email: email, password: password);
     
  }
  else{
    authResult= await auth.createUserWithEmailAndPassword(email: email, password: password);
     String uid= authResult.user.uid;
     await Firestore.instance.collection('users').document(uid).setData({
      'username': username,
      'email': email
     });
  }
}
catch(err){
print(err);
}
}


//----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(children: [
Container(
  padding: EdgeInsets.only(left:10.0, right: 10.0, top: 10.0),
  child:Form(
    key: _formkey,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (!isLoginPage)
         TextFormField(
        keyboardType:TextInputType.emailAddress,
        key: ValueKey("username"),
        validator: (value) {
          if (value!.isEmpty){
         return 'Incorect Username';
          }
          return null;
        },
        onSaved: (value) {
          _username = value!;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius:new BorderRadius.circular(8.0),
            borderSide: new BorderSide() 
          ),
          labelText: "Enter Username",
          labelStyle: GoogleFonts.roboto()
        ),
      ),
      SizedBox(height: 10),
        TextFormField(
        keyboardType:TextInputType.emailAddress,
        key: ValueKey("email"),
        validator: (value) {
          if (value!.isEmpty || !value.contains("@")){
         return 'Incorect Email';
          }
          return null;
        },
        onSaved: (value) {
          _email = value!;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius:new BorderRadius.circular(8.0),
            borderSide: new BorderSide() 
          ),
          labelText: "Enter Email",
          labelStyle: GoogleFonts.roboto()
        ),
      ),
      SizedBox(height: 10),
       TextFormField(
        obscureText: true,
        keyboardType:TextInputType.emailAddress,
        key: ValueKey("password"),
        validator: (value) {
          if (value!.isEmpty ){
         return 'Incorect Password';
          }
          return null;
        },
        onSaved: (value) {
          _password = value!;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius:new BorderRadius.circular(8.0),
            borderSide: new BorderSide() 
          ),
          labelText: "Enter Password",
          labelStyle: GoogleFonts.roboto()
        ),
      ),
      SizedBox(height: 10),
      Container(
      padding: EdgeInsets.all(5),
      width: double.infinity,
      height: 70,
      child: RaisedButton(
        child: isLoginPage 
        ? Text("Login",
        style: GoogleFonts.roboto(fontSize: 16.0))
        : Text ("Sign Up",
         style: GoogleFonts.roboto(fontSize: 16.0)),
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), onPressed: () {
          
        },)),
      SizedBox(height: 10),
      Container(
        child: TextButton(
          onPressed:() {
        setState(() {
          isLoginPage=!isLoginPage;
        });

        },
        child: isLoginPage
        ? Text("Not a member")
        : Text("Already a Member?")
         ),
      )
  ],)) ,
)
      ],
      ));
  }
}