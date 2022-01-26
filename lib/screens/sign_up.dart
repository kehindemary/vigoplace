import 'dart:typed_data';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:vigoplace/core/colors/colors.dart';
import 'package:vigoplace/core/constants/sizes.dart';
import 'package:vigoplace/core/constants/utils.dart';
import 'package:vigoplace/core/services/auth_services.dart';
import 'package:vigoplace/screens/home.dart';
import 'package:vigoplace/screens/sign_in.dart';
import 'package:vigoplace/widgets/button.dart';
import 'package:vigoplace/widgets/custom_text.dart';
import 'package:vigoplace/widgets/input.dart';
import 'package:vigoplace/widgets/text_label.dart';
import 'package:websafe_svg/websafe_svg.dart';

import 'dashboard_container.dart';

class SignUp extends StatefulWidget {
  static String routeName = 'SignUp';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  bool showSpinner = false;
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _userNameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _dobController = TextEditingController();
  Uint8List? _image;


  void signupUser() async {
    setState(() {
      showSpinner = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _userNameController.text,
      fullname: _fullNameController.text,
      dob: DateTime.parse(_dobController.text),
      file: _image!,
    );
    if (res == 'success') {
      Navigator.pushNamed(context, Home.routeName);

      setState(() {
        showSpinner = false;
      });
    } else {
      setState(() {
        showSpinner = false;
      });
      showSnackBar(context, res);
      print(res);
    }
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);

    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  final format = DateFormat("yyyy-MM-dd");

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
    _fullNameController.dispose();
    _dobController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          color: kWhite,
          progressIndicator: const CircularProgressIndicator(
            color: kGreen,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: sizeFit(true, 20, context),
                        right: sizeFit(false, 20, context),
                        top: sizeFit(false, 57, context)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _image != null
                            ? Center(
                                child: CircleAvatar(
                                  radius: 64,
                                  backgroundImage: MemoryImage(_image!),
                                  backgroundColor: Colors.red,
                                ),
                              )
                            : const Center(
                                child: CircleAvatar(
                                  radius: 64,
                                  backgroundImage: NetworkImage(
                                      'https://i.stack.imgur.com/l60Hf.png'),
                                  backgroundColor: Colors.purple,
                                ),
                              ),
                        SizedBox(
                          height: sizeFit(false, 10, context),
                        ),
                        Center(
                          child: IconButton(
                            onPressed: selectImage,
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        ),
                        const CustomText(
                          text: 'SignUp',
                          color: kMainBlack,
                          size: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: sizeFit(false, 32, context),
                        ),
                        const TextLabel(
                          text: 'Email',
                        ),
                        InputField(
                          obscureText: false,
                          hintText: 'Email Address',
                          controller: _emailController,
                          inputType: TextInputType.text,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Email is required";
                            }
                            if (!RegExp(
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                .hasMatch(value)) {
                              return "Please enter a valid email address";
                            }
                            return null;
                          },
                          borderSideColor: const BorderSide(color: kInputGray),
                        ),
                        SizedBox(
                          height: sizeFit(false, 20, context),
                        ),
                        const TextLabel(
                          text: 'Full Name',
                        ),
                        InputField(
                          obscureText: false,
                          hintText: 'Full Name',
                          controller: _fullNameController,
                          inputType: TextInputType.text,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "All field is required";
                            }
                            return null;
                          },
                          borderSideColor: const BorderSide(color: kInputGray),
                        ),
                        SizedBox(
                          height: sizeFit(false, 5, context),
                        ),
                        SizedBox(
                          height: sizeFit(false, 20, context),
                        ),
                        const TextLabel(
                          text: 'Username',
                        ),
                        InputField(
                          borderSideColor: const BorderSide(color: kInputGray),
                          obscureText: false,
                          controller: _userNameController,
                          hintText: 'Username',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "This field cannot be empty";
                            }
                          },
                          inputType: TextInputType.text,
                        ),
                        SizedBox(
                          height: sizeFit(false, 20, context),
                        ),
                        const TextLabel(
                          text: 'Date of Birth',
                        ),
                        DateTimeField(
                          format: format,
                          controller: _dobController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: kPurple),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: const BorderSide(
                                  color: kInputGray,
                                  width: 0.2,
                                )),
                            hintText: "Date",
                            fillColor: kWhite,
                            filled: true,
                            suffixIcon: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(Icons.calendar_today_outlined)),
                          ),
                          onShowPicker: (ctx, currentValue) {
                            return showDatePicker(
                                context: ctx,
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100));
                          },
                        ),
                        SizedBox(
                          height: sizeFit(false, 20, context),
                        ),
                        const TextLabel(
                          text: 'Password',
                        ),
                        InputField(
                          borderSideColor: const BorderSide(color: kInputGray),
                          obscureText: !isPasswordVisible,
                          controller: _passwordController,
                          hintText: 'Password',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "This field cannot be empty";
                            }
                            if (value.length < 5) {
                              return "Password too short";
                            }
                          },
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
                                    : WebsafeSvg.asset('images/invisible.svg')),
                          ),
                        ),
                        SizedBox(
                          height: sizeFit(false, 20, context),
                        ),
                        const TextLabel(
                          text: 'Confirm Password',
                        ),
                        InputField(
                          obscureText: !isConfirmPasswordVisible,
                          borderSideColor: const BorderSide(color: kInputGray),
                          hintText: 'Confirm Password',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "This field cannot be empty";
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                          },
                          inputType: TextInputType.text,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isConfirmPasswordVisible =
                                        !isConfirmPasswordVisible;
                                  });
                                },
                                child: isConfirmPasswordVisible
                                    ? WebsafeSvg.asset('images/visible.svg')
                                    : WebsafeSvg.asset('images/invisible.svg')),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: sizeFit(false, 22, context),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: sizeFit(false, 154, context),
                      bottom: sizeFit(false, 20, context),
                      left: sizeFit(false, 20, context),
                      right: sizeFit(false, 20, context),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Button(
                          buttonText: 'SignUp',
                          color: kGreen,
                          textColor: kWhite,
                          onPressed: signupUser,
                          width: double.infinity,
                          fontSize: 15,
                        ),
                        SizedBox(
                          height: sizeFit(false, 20, context),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CustomText(
                                text: 'Already have an account?',
                                size: 14,
                                fontWeight: FontWeight.w400,
                                color: kDark,
                                textAlign: TextAlign.center),
                            CustomText(
                              text: 'Log in',
                              size: 14,
                              fontWeight: FontWeight.w400,
                              color: kGreen,
                              textAlign: TextAlign.center,
                              onClick: () async {
                                Navigator.pushNamed(context, SignIn.routeName);
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: sizeFit(false, 20, context),
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
    );
  }

}
