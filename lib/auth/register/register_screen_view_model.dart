import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_app/auth/register/register_navigator.dart';

class RegisterScreenViewModel extends ChangeNotifier{
  //todo: hold data - handle logic
  late RegisterNavigator navigator;

 void register(String email,String password) async {

    try {
      // Todo: show Loading.
     navigator.showMyLoading();
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email:email,
        password: password,
      );
      //
      // MyUser myUser = MyUser(id: credential.user?.uid ??'', email: email, name: email);
      // var authProvider = Provider.of<AuthProviders>(context,listen: false);
      // authProvider.updateUser(myUser);
      // await  FirebaseUtlis.addUserToFireStore(myUser);
      //  Todo: hide Loading
       navigator.hideMyLoading();
      // Todo: show message
        navigator.showMyMessage('Register SuccessFully');

       if (kDebugMode) {
         print('register successfully');
       }
        if (kDebugMode) {
          print(credential.user?.uid??"");
        }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        //Todo hide loading
      navigator.hideMyLoading();
        navigator.showMyMessage('The password provided is too weak.');
        if (kDebugMode) {
          print('The password provided is too weak.');
        }
      } else if (e.code == 'email-already-in-use') {
        // Todo: hide Loading
        navigator.hideMyLoading();
        // Todo: show message
        navigator.showMyMessage('The account already exists for that email.');
      }
    } catch (e) {
      // Todo: hide Loading
      navigator.hideMyLoading();
      // Todo: show message
      navigator.showMyMessage(e.toString());
    }

  }
  }
