import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:vigoplace/core/colors/colors.dart';
import 'package:vigoplace/core/constants/sizes.dart';
import 'package:vigoplace/screens/sign_in.dart';
import 'package:vigoplace/widgets/button.dart';
import 'package:vigoplace/widgets/custom_text.dart';
import 'package:vigoplace/widgets/input.dart';
import 'package:vigoplace/widgets/text_label.dart';

class PersonalInfo extends StatefulWidget {
  static String routeName = 'PersonalInfo';
  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final _formKey = GlobalKey<FormState>();
  bool showSpinner = false;


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
                        const CustomText(
                          text: 'PersonalInfo',
                          color: kMainBlack,
                          size: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: sizeFit(false, 32, context),
                        ),
                        SizedBox(
                          height: sizeFit(false, 10, context),
                        ),
                        const TextLabel(
                          text: 'Full Name',
                        ),
                        InputField(
                          obscureText: false,
                          hintText: 'Full Name',
                          inputType: TextInputType.text,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "All field is required";
                            }
                            return null;
                          },
                          borderSideColor: const BorderSide(
                              color:  kInputGray),
                          onSaved: (value) {
                            // _authData['email'] = value;
                          },
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
                        InputField(
                          obscureText: false,
                          hintText: 'Date of Birth',
                          inputType: TextInputType.datetime,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "All field are required";
                            }
                            
                            return null;
                          },
                          borderSideColor: BorderSide(
                              color:  kInputGray),
                          onSaved: (value) {
                            // _authData['email'] = value;
                          },
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
                          buttonText: 'PersonalInfo',
                          color: kGreen,
                          textColor: kWhite,
                          onPressed: (){},
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
                            CustomText(
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
                              onClick: () {
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
