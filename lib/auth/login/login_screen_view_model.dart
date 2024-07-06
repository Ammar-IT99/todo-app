
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Home_Screen.dart';
import 'package:todo_app/auth/login/login_navigator.dart';

import '../../Providers/auth_Provider.dart';
import '../../firebase_utlis.dart';

class LoginScreenViewModel extends ChangeNotifier{
//todo: hold data - handle logic
var emailController=TextEditingController(text: 'elkingamar44@gmail.com');
var passwordController=TextEditingController(text: '111111');
var formKey=GlobalKey<FormState>();
late LoginNavigator navigator;
Future<void> login() async {

  if (formKey.currentState?.validate() == true) {
    try {
      // Todo: show Loading.
      navigator.showMyLoading();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
       );
      // var user = await FirebaseUtlis.readUserFromFireStore(credential.user?.uid??"");
      // if(user==null){
      //   return ;
      // }
      // var authProvider = Provider.of<AuthProviders>(context,listen: false);
      // authProvider.updateUser(user);
      // Todo: hide Loading
      navigator.hideMyLoading();
      // Todo: show message
      navigator.showMyMessage('Login SuccessFully');

      print('login successfully');
      print(credential.user?.uid ?? "");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        //Todo hide loading
        navigator.hideMyLoading();
        // Todo: show message
        navigator.showMyMessage('No user found for that email.');
        print('No user found for that email.');
      }
      else if (e.code == 'wrong-password') {
        //Todo hide loading
        navigator.hideMyLoading();
        // Todo: show message
        navigator.showMyMessage('Wrong password provided for that user.');

        print('Wrong password provided for that user.');
      }
    } catch (e) {
      // Todo: hide Loading
      navigator.hideMyLoading();
      // Todo: show message
      navigator.showMyMessage(e.toString());
      print(e.toString());
    }
  }
}
}
