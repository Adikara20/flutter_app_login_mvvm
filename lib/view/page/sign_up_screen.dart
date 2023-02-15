import 'package:flutter/material.dart';
import 'package:flutter_application_location/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';

import '../../res/colors.dart';
import '../../res/components/round_button.dart';
import '../../res/components/text_costum.dart';
import '../../res/components/text_formfield_custom.dart';
import '../../utils/utils.dart';
import '../../view_model/auth_view_model.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  static GlobalKey<FormState> _formKey1 = new GlobalKey<FormState>();
  static GlobalKey<FormState> _formKey2 = new GlobalKey<FormState>();
  static GlobalKey<FormState> _formKey3 = new GlobalKey<FormState>();
  static GlobalKey<FormState> _formKey4 = new GlobalKey<FormState>();

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode firstNameNode = FocusNode();
  FocusNode lastNameNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();

    firstNameNode = FocusNode();
    firstNameNode.addListener(() => setState(() {}));

    lastNameNode = FocusNode();
    lastNameNode.addListener(() => setState(() {}));

    emailFocusNode = FocusNode();
    emailFocusNode.addListener(() => setState(() {}));

    passwordFocusNode = FocusNode();
    passwordFocusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();

    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    firstNameNode.dispose();
    lastNameNode.dispose();
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
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const TextCostum(
                    text: 'Sign Up',
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    colorText: AppColors.titleTextColor,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormFieldCustom(
                    formKey: _formKey1,
                    textController: _firstNameController,
                    obsecureText: ValueNotifier<bool>(false),
                    focusNode: firstNameNode,
                    text: 'First Name',
                    keyboardType: TextInputType.text,
                    iconData: Icons.person_add,
                    useObsecure: false,
                    iconColor: AppColors.titleTextColor,
                  ),
                  TextFormFieldCustom(
                    formKey: _formKey2,
                    textController: _lastNameController,
                    obsecureText: ValueNotifier<bool>(false),
                    focusNode: lastNameNode,
                    text: 'Last Name',
                    keyboardType: TextInputType.text,
                    iconData: Icons.person_add,
                    useObsecure: false,
                    iconColor: AppColors.titleTextColor,
                  ),
                  TextFormFieldCustom(
                    formKey: _formKey3,
                    textController: _emailController,
                    obsecureText: ValueNotifier<bool>(false),
                    focusNode: emailFocusNode,
                    text: 'email',
                    keyboardType: TextInputType.emailAddress,
                    iconData: Icons.alternate_email,
                    useObsecure: false,
                    iconColor: AppColors.titleTextColor,
                  ),
                  ValueListenableBuilder(
                    valueListenable: _obsecurePassword,
                    builder: (context, value, child) {
                      return TextFormFieldCustom(
                        formKey: _formKey4,
                        textController: _passwordController,
                        obsecureText: _obsecurePassword,
                        focusNode: passwordFocusNode,
                        text: 'Password',
                        keyboardType: TextInputType.text,
                        iconData: Icons.lock,
                        useObsecure: true,
                        iconColor: AppColors.titleTextColor,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  RoundButton(
                    title: 'Login',
                    loading: authViewMode.signUpLoading,
                    onPress: () {
                      if (_emailController.text.isEmpty) {
                        Utils.flushBarErrorMessage(
                            'Please enter email', context);
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
                        authViewMode.loginApi(data, context);
                      }
                    },
                    fontSize: 18,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.login);
                    },
                    child: RichText(
                      text: const TextSpan(
                        text: 'Already have account ?',
                        style: TextStyle(color: AppColors.textColor),
                        children: <TextSpan>[
                          TextSpan(text: ' to '),
                          TextSpan(
                              text: 'Login',
                              style: TextStyle(
                                  color: AppColors.titleTextColor,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
