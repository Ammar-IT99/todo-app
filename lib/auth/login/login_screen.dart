
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_app/auth/custome_text_form_field.dart';
import 'package:todo_app/auth/login/login_navigator.dart';
import 'package:todo_app/auth/login/login_screen_view_model.dart';
import 'package:todo_app/auth/register/register_screen.dart';

import '../../dialog_utlis.dart';
import '../../my_theme.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_Screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginNavigator{

  LoginScreenViewModel viewModel = LoginScreenViewModel();
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
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
                'Login',
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
                    key: viewModel.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.3,
                        ),
                        Text('Welcome Back', style: Theme
                            .of(context)
                            .textTheme
                            .titleLarge, textAlign: TextAlign.center,),
                        CustomTextFormField(
                          label: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          controller: viewModel.emailController,
                          validator: (text) {
                            if (text == null || text
                                .trim()
                                .isEmpty) {
                              return 'please enter Email';
                            }
                            bool emailValid =
                            RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(viewModel.emailController.text);
                            if (!emailValid) {
                              return 'Please Enter Valid Email ';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          label: 'Password',
                          keyboardType: TextInputType.number,
                          controller: viewModel.passwordController,
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
                        Padding(
                            padding: const EdgeInsets.all(8),
                            child: ElevatedButton(onPressed: () {
                              viewModel.login();

                            }, child: const Text('login'))),
                        TextButton(onPressed: () {
                          Navigator.of(context).pushNamed(RegisterScreen.routeName);
                        }, child: const Text('OR Create Account'))

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



  @override
  void hideMyLoading() {
    // TODO: implement hideMyLoading
    DialogUtlis.hideLoading(context: context);
  }

  @override
  void showMyLoading() {
    // TODO: implement showMyLoading
    DialogUtlis.showMessage(context: context, message: 'loading...');

  }

  @override
  void showMyMessage(String message) {
    // TODO: implement showMyMessage
    DialogUtlis.showMessage(context: context, message: message,
    posActionName: 'OK',

    );
  }
}
