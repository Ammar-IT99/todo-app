import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Home_Screen.dart';
import 'package:todo_app/My_Theme.dart';
import 'package:todo_app/Providers/auth_Provider.dart';
import 'package:todo_app/auth/custome_text_form_field.dart';
import 'package:todo_app/auth/login/login_Screen.dart';
import 'package:todo_app/dialog_utlis.dart';
import 'package:todo_app/firebase_utlis.dart';
import 'package:todo_app/model/my_users.dart';

class registerScreen extends StatefulWidget {
  static const String routeName = 'register_Screen';

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  TextEditingController nameController=TextEditingController();

  TextEditingController emailController=TextEditingController();

  TextEditingController passwordController=TextEditingController();

  TextEditingController confirmPasswordController=TextEditingController();

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
              'Create Account',
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
                      CustomTextFormField(
                        label: 'User Name',
                        controller:nameController
                        , validator: (text ) {
                          if(text==null|| text.trim().isEmpty){
                            return 'please enter user Name';
                          }
                          return null;
                      },
                      ),
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
                      CustomTextFormField(
                        label: 'Confirm Password',
                          keyboardType:TextInputType.number, controller: confirmPasswordController,
                        obscureText: true,
                        validator: (text ) {
                          if(text==null|| text.trim().isEmpty){
                            return 'please enter Confirm Password';
                          }
                          if(text!=passwordController.text){
                            return "Confirm Password doesn't match ";
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                          child: ElevatedButton(onPressed: (){
                            register();
                          }, child: const Text('Crete Account'))),
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

  void register ()async{
    if(formKey.currentState?.validate()==true){

      try {
        // Todo: show Loading.
        DialogUtlis.showLoading(context: context, message: 'Loading');

      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      MyUser myUser = MyUser(id: credential.user?.uid ??'', email: emailController.text, name: nameController.text);
        var authProvider = Provider.of<AuthProviders>(context,listen: false);
        authProvider.updateUser(myUser);
        await  FirebaseUtlis.addUserToFireStore(myUser);
      // Todo: hide Loading
        DialogUtlis.hideLoading(context: context);
        // Todo: show message
        DialogUtlis.showMessage(context: context, message:'Register SuccessFully',
        title: 'success',
          posActionName: 'OK',
          posAction: (){
          Navigator.pushReplacementNamed(context,HomeScreen.routeName);
          }
        );

      print('register successfully');
      print(credential.user?.uid??"");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        //Todo hide loading
        DialogUtlis.hideLoading(context: context);
        // Todo: show message
        DialogUtlis.showMessage(context: context, message: 'The password provided is too weak.',
        title: 'Error', posActionName: 'OK');
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // Todo: hide Loading
        DialogUtlis.hideLoading(context: context);
        // Todo: show message
        DialogUtlis.showMessage(context: context, message:'The account already exists for that email.',title: 'Error', posActionName: 'OK');
        print('The account already exists for that email.');
      }
    } catch (e) {
        // Todo: hide Loading
        DialogUtlis.hideLoading(context: context);
        // Todo: show message
        DialogUtlis.showMessage(context: context, message: e.toString(),title: 'Error', posActionName: 'OK');
      print(e);
    }

    }
  }
}
