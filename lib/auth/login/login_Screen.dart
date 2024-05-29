
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/My_Theme.dart';
import 'package:todo_app/auth/custome_text_form_field.dart';
import 'package:todo_app/auth/register/register_Screen.dart';
import 'package:todo_app/firebase_utlis.dart';

import '../../Home_Screen.dart';
import '../../Providers/auth_Provider.dart';
import '../../dialog_utlis.dart';

class loginScreen extends StatefulWidget {
  static const String routeName = 'login_Screen';

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  TextEditingController emailController=TextEditingController();

  TextEditingController passwordController=TextEditingController();

 var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: MyTheme.backGroundColor,
          child: Image.asset(
            'assets/images/background.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: Text(
              'Login',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                      Text('Welcome Back', style: Theme.of(context).textTheme.titleLarge,textAlign:TextAlign.center,),
                      CustomTextFormField(
                        label: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        validator: (text ) {
                          if(text==null|| text.trim().isEmpty){
                            return 'please enter Email';
                          }
                          bool emailValid =
                          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(emailController.text);
                          if(!emailValid){
                            return 'Please Enter Valid Email ';
                          }
                          return null;
                        },
                      ),
                       CustomTextFormField(
                        label: 'Password',
                        keyboardType: TextInputType.number, controller: passwordController,
                        obscureText: true,
                        validator: (text ) {
                          if(text==null|| text.trim().isEmpty){
                            return 'please enter Password';
                          }
                          if(text.length<6){
                            return 'Password Should be at least 6chars.';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                          child: ElevatedButton(onPressed: (){
                            login();

                          }, child: const Text('login'))),
                      TextButton(onPressed: (){
                        Navigator.of(context).pushNamed(registerScreen.routeName);
                      }, child: Text('OR Create Account'))

                    ],
                  ),

                )
              ],
            ),
          ),
        ),
      ],
    );

  }

  Future<void> login () async {
    if(formKey.currentState?.validate()==true){
      try {
        // Todo: show Loading.
        DialogUtlis.showLoading(context: context, message: 'Loading');
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
      var user = await FirebaseUtlis.readUserFromFireStore(credential.user?.uid??"");
      if(user==null){
        return ;
      }
        var authProvider = Provider.of<AuthProviders>(context,listen: false);
        authProvider.updateUser(user);
        // Todo: hide Loading
        DialogUtlis.hideLoading(context: context);
        // Todo: show message
        DialogUtlis.showMessage(context: context, message:'Login SuccessFully',
            title: 'success',
            posActionName: 'OK',
            posAction: (){
              Navigator.pushReplacementNamed(context,HomeScreen.routeName);
            }
        );
        print('login successfully');
        print(credential.user?.uid??"");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          //Todo hide loading
          DialogUtlis.hideLoading(context: context);
          // Todo: show message
          DialogUtlis.showMessage(context: context, message: 'No user found for that email.',
              title: 'Error', posActionName: 'OK');
          print('No user found for that email.');
        }
        else if (e.code == 'wrong-password') {
          //Todo hide loading
          DialogUtlis.hideLoading(context: context);
          // Todo: show message
          DialogUtlis.showMessage(context: context, message: 'Wrong password provided for that user.',
              title: 'Error', posActionName: 'OK');
          print('Wrong password provided for that user.');
        }
      }catch(e){
        // Todo: hide Loading
        DialogUtlis.hideLoading(context: context);
        // Todo: show message
        DialogUtlis.showMessage(context: context, message:'${e.toString()}',
           title: 'Error', posActionName: 'OK');
        print(e.toString());
      }

    }
  }
}
