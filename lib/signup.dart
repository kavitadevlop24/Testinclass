import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:testinclass/uihelper.dart';

import 'login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  signup(String email,String password)async{
    if(email=="" && password==""){
      return log("Enter Required Field");
    }else{
      UserCredential? userCredential;
      try{
        userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value){
          log("User Created");
        });
      }
      on FirebaseAuthException catch(ex){
        log(ex.code.toString());
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignUp"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.CustomTextField(emailController, "Enter Email", Icons.mail, false),
          UiHelper.CustomTextField(passwordController, "Enter Password", Icons.password, true),
          const SizedBox(height: 20,),
          ElevatedButton(onPressed: (){
            signup(emailController.text.toString(), passwordController.text.toString());
          }, child: const Text("Sign Up")),
          const SizedBox(height: 15,),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignInScreen()));
          }, child: const Text("Sign In"))
        ],
      ),
    );
  }
}