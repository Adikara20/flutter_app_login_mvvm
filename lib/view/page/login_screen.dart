import 'package:flutter/material.dart';
import 'package:flutter_application_location/res/colors.dart';
import 'package:flutter_application_location/res/components/text_costum.dart';
import 'package:flutter_application_location/utils/routes/routes_name.dart';
import 'package:flutter_application_location/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../../res/components/round_button.dart';
import '../../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static GlobalKey<FormState> _formKey1 = new GlobalKey<FormState>();
  static GlobalKey<FormState> _formKey2 = new GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    emailFocusNode = FocusNode();
    emailFocusNode.addListener(() => setState(() {}));

    passwordFocusNode = FocusNode();
    passwordFocusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    _obsecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewMode = Provider.of<AuthViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const TextCostum(
                text: 'Login',
                fontSize: 45,
                fontWeight: FontWeight.bold,
                colorText: AppColors.titleTextColor,
              ),
              const SizedBox(
                height: 10,
              ),
              const TextCostum(
                text: 'Please sign in to continue',
                fontSize: 18,
                fontWeight: FontWeight.normal,
                colorText: AppColors.textColor,
              ),
              const SizedBox(
                height: 40,
              ),
              AnimatedContainer(
                duration: const Duration(seconds: 5),
                margin: const EdgeInsets.all(16),
                decoration: emailFocusNode.hasFocus
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 15,
                              offset: Offset(-5, 5),
                            ),
                          ])
                    : null,
                child: Form(
                  key: _formKey1,
                  child: TextFormField(
                    cursorColor: AppColors.titleTextColor,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: emailFocusNode,
                    decoration: const InputDecoration(
                        hintText: 'email',
                        //labelText: 'email',
                        //labelStyle: TextStyle(color: AppColors.titleTextColor),
                        prefixIcon: Icon(
                          Icons.alternate_email,
                          color: AppColors.titleTextColor,
                        ),
                        fillColor: Colors.white,
                        hoverColor: Colors.white,
                        filled: true,
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: AppColors.titleTextColor, width: 1))),
                    // onFieldSubmitted: ((value) {
                    //   Utils.fieldFocusChange(
                    //       context, emailFocusNode, passwordFocusNode);
                    // }),
                  ),
                ),
              ),
              ValueListenableBuilder(
                valueListenable: _obsecurePassword,
                builder: (context, value, child) {
                  return AnimatedContainer(
                    duration: const Duration(seconds: 5),
                    margin: const EdgeInsets.all(16),
                    decoration: passwordFocusNode.hasFocus
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 15,
                                  offset: Offset(-5, 5),
                                ),
                              ])
                        : null,
                    child: Form(
                      key: _formKey2,
                      child: TextFormField(
                        cursorColor: AppColors.titleTextColor,
                        controller: _passwordController,
                        obscureText: _obsecurePassword.value,
                        focusNode: passwordFocusNode,
                        obscuringCharacter: '*',
                        decoration: InputDecoration(
                            hintText: 'password',
                            //labelText: 'password',
                            prefixIcon: const Icon(Icons.lock,
                                color: AppColors.titleTextColor),
                            suffixIcon: InkWell(
                              onTap: (() {
                                _obsecurePassword.value =
                                    !_obsecurePassword.value;
                              }),
                              child: Icon(
                                  _obsecurePassword.value
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility,
                                  color: AppColors.titleTextColor),
                            ),
                            fillColor: Colors.white,
                            hoverColor: Colors.white,
                            filled: true,
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                    color: AppColors.titleTextColor,
                                    width: 1))),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 40,
              ),
              RoundButton(
                title: 'Login',
                loading: authViewMode.loading,
                onPress: () {
                  if (_emailController.text.isEmpty) {
                    Utils.flushBarErrorMessage('Please enter email', context);
                  } else if (_passwordController.text.isEmpty) {
                    Utils.flushBarErrorMessage(
                        'Please enter password', context);
                  } else if (_passwordController.text.length < 8) {
                    Utils.flushBarErrorMessage(
                        'Please enter 8 digit password', context);
                  } else {
                    Map data = {
                      'email': _emailController.text.toString(),
                      'password': _passwordController.text.toString(),
                    };
                    //test saja
                    Map hardData = {
                      "email": "eve.holt@reqres.in",
                      "password": "cityslicka"
                    };

                    //authViewMode.loginApi(data, context);

                    authViewMode.loginApi(hardData, context);
                  }
                },
                fontSize: 18,
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.signup);
                },
                child: RichText(
                  text: const TextSpan(
                    text: 'dont have an account ? ',
                    style: TextStyle(color: AppColors.textColor),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                              color: AppColors.titleTextColor,
                              fontWeight: FontWeight.bold)),
                      TextSpan(text: ' please!'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
