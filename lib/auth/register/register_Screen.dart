
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_app/My_Theme.dart';

import 'package:todo_app/auth/custome_text_form_field.dart';
import 'package:todo_app/auth/register/register_navigator.dart';
import 'package:todo_app/auth/register/register_screen_view_model.dart';
import 'package:todo_app/dialog_utlis.dart';


class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register_Screen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> implements RegisterNavigator{

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  RegisterScreenViewModel viewModel = RegisterScreenViewModel();

  var formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator=this;
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
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
                style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge,
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
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.3,
                        ),
                        CustomTextFormField(
                          label: 'User Name',
                          controller: nameController
                          , validator: (text) {
                          if (text == null || text
                              .trim()
                              .isEmpty) {
                            return 'please enter user Name';
                          }
                          return null;
                        },
                        ),
                        CustomTextFormField(
                          label: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (text) {
                            if (text == null || text
                                .trim()
                                .isEmpty) {
                              return 'please enter Email';
                            }
                            bool emailValid =
                            RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(emailController.text);
                            if (!emailValid) {
                              return 'Please Enter Valid Email ';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          label: 'Password',
                          keyboardType: TextInputType.number,
                          controller: passwordController,
                          obscureText: true,
                          validator: (text) {
                            if (text == null || text
                                .trim()
                                .isEmpty) {
                              return 'please enter Password';
                            }
                            if (text.length < 6) {
                              return 'Password Should be at least 6chars.';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          label: 'Confirm Password',
                          keyboardType: TextInputType.number,
                          controller: confirmPasswordController,
                          obscureText: true,
                          validator: (text) {
                            if (text == null || text
                                .trim()
                                .isEmpty) {
                              return 'please enter Confirm Password';
                            }
                            if (text != passwordController.text) {
                              return "Confirm Password doesn't match ";
                            }
                            return null;
                          },
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8),
                            child: ElevatedButton(onPressed: () {
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
      ),
    );
  }

  void register() async {
    if (formKey.currentState?.validate() == true) {

      viewModel.register(emailController.text, passwordController.text);
    }
  }

  @override
  void hideMyLoading() {
    // TODO: implement hideMyLoading
    DialogUtlis.hideLoading(context:context);
  }

  @override
  void showMyLoading() {
    // TODO: implement showMessage
 DialogUtlis.showMessage(context: context, message: 'loading...');
  }

  @override
  void showMyMessage(String message) {
    // TODO: implement showMyLoading
    DialogUtlis.showMessage(context: context, message: message,
    posActionName: 'OK');
  }
}