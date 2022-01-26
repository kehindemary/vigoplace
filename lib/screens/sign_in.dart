import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:vigoplace/core/colors/colors.dart';
import 'package:vigoplace/core/constants/sizes.dart';
import 'package:vigoplace/core/services/auth_services.dart';
import 'package:vigoplace/screens/personal_info.dart';
import 'package:vigoplace/screens/sign_up.dart';
import 'package:vigoplace/widgets/button.dart';
import 'package:vigoplace/widgets/custom_text.dart';
import 'package:vigoplace/widgets/input.dart';
import 'package:vigoplace/widgets/text_label.dart';
import 'package:websafe_svg/websafe_svg.dart';

class SignIn extends StatefulWidget {
  static String routeName = 'SignIn';
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool showSpinner = false;
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  void loginUser() async {
    setState(() {
      showSpinner = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      Navigator.pushNamed(context, PersonalInfo.routeName);

      setState(() {
        showSpinner = false;
      });
    } else {
      setState(() {
        showSpinner = false;
      });
      // showSnackBar(context, res);
    }
  }

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.95),
            child: ModalProgressHUD(
              inAsyncCall: showSpinner,
              color: kWhite,
              progressIndicator: CircularProgressIndicator(
                color: kGreen,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: sizeFit(true, 20, context),
                          bottom: sizeFit(true, 20, context),
                          right: sizeFit(false, 20, context),
                          top: sizeFit(false, 57, context)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'SignIn ',
                            color: kMainBlack,
                            size: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(
                            height: sizeFit(false, 32, context),
                          ),
                         
                          TextLabel(
                            text: 'Email Address',
                          ),
                          InputField(
                            borderSideColor: BorderSide(color: kInputGray),
                            obscureText: false,
                            controller: _emailController,
                            hintText: 'Email Address',
                            inputType: TextInputType.text,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Email is required";
                              }
                              return null;
                            },
                            // onSaved: (value) {
                            //   _authData['email'] = value;
                            // },
                          ),
                          SizedBox(
                            height: sizeFit(false, 20, context),
                          ),
                          TextLabel(
                            text: 'Password',
                          ),
                          InputField(
                            borderSideColor: BorderSide(color: kInputGray),
                            obscureText: !isPasswordVisible,
                            controller: _passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field cannot be empty";
                              }
                            },
                            // onSaved: (value) {
                            //   _authData['password'] = value;
                            // },
                            hintText: 'Password',
                            inputType: TextInputType.text,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    });
                                  },
                                  child: isPasswordVisible
                                      ? WebsafeSvg.asset('images/visible.svg')
                                      : WebsafeSvg.asset(
                                          'images/invisible.svg')),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: sizeFit(true, 20, context),
                          bottom: sizeFit(true, 20, context),
                          right: sizeFit(false, 20, context)),
                      child: Column(
                        children: [
                          Button(
                              buttonText: 'Login',
                              color: kGreen,
                              textColor: kWhite,
                              onPressed: loginUser,
                              width: double.infinity,
                              fontSize: 15),
                          SizedBox(
                            height: sizeFit(false, 20, context),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                  text: "Not tried us yet?",
                                  size: 14,
                                  fontWeight: FontWeight.w400,
                                  color: kDark,
                                  textAlign: TextAlign.center),
                              CustomText(
                                text: 'Sign up',
                                size: 14,
                                fontWeight: FontWeight.w400,
                                color: kGreen,
                                textAlign: TextAlign.center,
                                onClick: () {
                                  Navigator.pushNamed(
                                      context, SignUp.routeName);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
