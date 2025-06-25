import 'package:flaury_mobile/app/shared/new_drop_down.dart';
import 'package:flaury_mobile/app/src/authentication/controllers/auth_controller.dart';
import 'package:flaury_mobile/app/util/app_colors.dart';
import 'package:flaury_mobile/app/util/app_text_style.dart';
import 'package:flaury_mobile/app/util/custom_padding.dart';
import 'package:flaury_mobile/app/util/size_config.dart';
import 'package:flaury_mobile/app/util/validator.dart';
import 'package:flaury_mobile/app/shared/textfield.dart';
import 'package:flaury_mobile/app/shared/custom_button.dart';
import 'package:flaury_mobile/app/src/authentication/providers/provider.dart';
import 'package:flaury_mobile/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../util/app_spacing.dart';

class RegisterCustomerView extends StatefulHookConsumerWidget {
  const RegisterCustomerView({super.key});

  @override
  ConsumerState<RegisterCustomerView> createState() =>
      _RegisterCustomerViewState();
}

class _RegisterCustomerViewState extends ConsumerState<RegisterCustomerView> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _namecontroller.dispose();
    _passwordcontroller.dispose();
    _phonecontroller.dispose();
    _emailcontroller.dispose();
    _usernamecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final obscurePassword = ref.watch(passwordvisible);
    // final navigation = ref.watch(navigationServiceProvider);

    ref.listen<AuthState>(authControllerProvider, (prev, next) {
      if (next.status == AuthStatus.success) {
        // navigation.pushTo(
        //   page: VerifyEmailView(email: _emailcontroller.text),
        // );

        Navigator.pushReplacementNamed(context, AppRoutes.verifyemail,
            arguments: _emailcontroller.text);
      } else if (next.status == AuthStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.message)),
        );
      }
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: _formkey,
              child: SymetricPadding(
                h: 20,
                v: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: SizeConfig.fromDesignHeight(context, 20),
                    ),
                    // appbar
                    Row(
                      children: [
                        SizedBox(
                          width: SizeConfig.fromDesignHeight(context, 4),
                        ),
                        AppTextBold(text: 'Create your account', fontSize: 18)
                      ],
                    ),

                    SizedBox(
                      height: SizeConfig.fromDesignHeight(context, 20),
                    ),

                    //name textfield
                    AuthTextfield(
                      hintext: 'Enter your Full Name',
                      obscureText: false,
                      validator: Validator.nameValidator,
                      controller: _namecontroller,
                      label: 'Name',
                    ),

                    SizedBox(
                      height: SizeConfig.fromDesignHeight(context, 20),
                    ),

                    AuthTextfield(
                      hintext: 'Enter your Username',
                      obscureText: false,
                      validator: Validator.nameValidator,
                      controller: _usernamecontroller,
                      label: 'Username ',
                    ),

                    SizedBox(
                      height: SizeConfig.fromDesignHeight(context, 20),
                    ),

                    //email textfield
                    AuthTextfield(
                      hintext: 'info@flaury.email.com',
                      obscureText: false,
                      validator: Validator.emailValidator,
                      controller: _emailcontroller,
                      label: 'Email Address',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: SizeConfig.fromDesignHeight(context, 20),
                    ),

                    //phone number textfield
                    AuthTextfield(
                      hintext: '08012345678',
                      obscureText: false,
                      validator: Validator.validatePhoneNumber,
                      controller: _phonecontroller,
                      label: 'Phone Number',
                      keyboardType: TextInputType.number,
                    ),

                    SizedBox(
                      height: SizeConfig.fromDesignHeight(context, 20),
                    ),
                    AppTextBold(text: 'Gender', fontSize: 14),
                    const AppSpacing(v: 5),

                    // CustomDropDown(
                    //   isfilled: false,
                    //   hint: 'select category',
                    //   items: acceptableGender.map((item) {
                    //     return DropdownMenuItem<String>(
                    //       value: item,
                    //       child: Text(item),
                    //     );
                    //   }).toList(),
                    //   onChanged: (value) {
                    //     setState(() {
                    //       _selectedValue =
                    //           value; // Correctly update the selected value
                    //     });
                    //   },
                    // ),

                    NewCustomDropdown<String>(
                      showBoxShadow: false,
                      value: _selectedValue,
                      items: acceptableGender,
                      menuItemBuilder: (val) => Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.fromDesignHeight(context, 8)),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: AppColors.background,
                            border: Border.all(
                                color: const Color.fromRGBO(173, 173, 173, 1)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: AppTextRegular(
                                  text: val,
                                  fontSize: 12,
                                  color: AppColors.grey,
                                ),
                              ),
                              Radio<String>(
                                activeColor: AppColors.primary,
                                value: val,
                                groupValue: _selectedValue,
                                onChanged: (value) {},
                                visualDensity: VisualDensity.compact,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                            ],
                          ),
                        ),
                      ),
                      selectedBuilder: (val) => Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: SizeConfig.fromDesignHeight(context, 12)),
                        child: Text(val ?? "select your gender"),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _selectedValue = val!;
                        });
                      },
                    ),

                    const AppSpacing(v: 20),
                    //password field

                    AuthTextfield(
                        hintext: 'Enter Your Password',
                        obscureText: obscurePassword.isPasswordVisible,
                        validator: Validator.passwordValidator,
                        controller: _passwordcontroller,
                        label: 'Password',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            obscurePassword.visiblePassword();
                          },
                          child: Icon(obscurePassword.isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility),
                        )),

                    SizedBox(
                      height: SizeConfig.fromDesignHeight(context, 20),
                    ),

                    //terms and condition text
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text:
                                'Clicking the “Continue” button means I agree to the',
                            style: GoogleFonts.montserrat(
                              color: AppColors.primary,
                              fontSize: SizeConfig.fontSize(context, 10),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text:
                                ' Terms & Conditions and Privacy Policy of FLAURY',
                            style: GoogleFonts.montserrat(
                              color: AppColors.primary,
                              fontSize: SizeConfig.fontSize(context, 10),
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ])),

                    SizedBox(
                      height: SizeConfig.fromDesignHeight(context, 29),
                    ),

                    //sign up button
                    ListenableBuilder(
                        listenable: Listenable.merge([
                          _emailcontroller,
                          _namecontroller,
                          _phonecontroller,
                          _passwordcontroller,
                        ]),
                        builder: (context, child) {
                          final enable = _emailcontroller.text.isNotEmpty &&
                              _namecontroller.text.isNotEmpty &&
                              _passwordcontroller.text.isNotEmpty &&
                              _phonecontroller.text.isNotEmpty;

                          return enable
                              ? LargeButon(
                                  label: "Sign up",
                                  isloading: ref
                                          .watch(authControllerProvider)
                                          .status ==
                                      AuthStatus.loading,
                                  ontap: () {
                                    if (_formkey.currentState!.validate()) {
                                      ref
                                          .read(authControllerProvider.notifier)
                                          .signUp(
                                              email: _emailcontroller.text,
                                              password:
                                                  _passwordcontroller.text,
                                              userName:
                                                  _usernamecontroller.text,
                                              gender: _selectedValue.toString(),
                                              name: _namecontroller.text,
                                              phoneNumber:
                                                  _phonecontroller.text);
                                    }
                                  },
                                )
                              : const LargeButonDisabled(
                                  label: 'Sign up', ontap: null);
                        }),

                    SizedBox(
                      height: SizeConfig.fromDesignHeight(context, 27),
                    ),

                    //this routes to the sign in page

                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppTextSemiBold(
                            text: "Already have an account?  ",
                            fontSize: 12,
                            color: AppColors.grey,
                          ),
                          GestureDetector(
                              onTap: () {
                                //logic goes here
                                Navigator.pushNamed(
                                    context, AppRoutes.signInView);
                              },
                              child: AppTextBold(
                                  text: 'Login',
                                  fontSize: 14,
                                  color: AppColors.primary)),
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

final List<String> acceptableGender = ['Male', 'Female'];
