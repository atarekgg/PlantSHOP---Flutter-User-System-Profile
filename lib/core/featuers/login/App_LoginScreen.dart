import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:login/config/router.dart';
import 'package:login/core/theme/app_colors.dart';
import 'package:login/core/theme/app_text_style.dart';
import 'package:login/core/utils/app_responsive.dart';
import 'package:login/core/theme/app_string.dart';
import 'package:login/core/assets/app_icons.dart';
import 'package:login/core/utils/app_database.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  bool isChecked = false;
  bool isPasswordHidden = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  bool isLoading = false;
  final AppDatabase _db = AppDatabase();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (loginFormKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      final isValid = await _db.validateCredentials(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      setState(() {
        isLoading = false;
      });

      if (isValid) {
        if (mounted) {
          context.go(AppRouters.profileScreen);
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                AppStrings.loginFailed,
                style: AppTextStyle.ts14normal,
              ),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppResponsive.height(context) * 0.1),
                Center(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        AppIcons.logo,
                        width: 80,
                        height: 80,
                        color: AppColors.primaryColor,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Plant",
                              style: AppTextStyle.ts20bold.copyWith(
                                color: AppColors.hintColore,
                              ),
                            ),
                            TextSpan(
                              text: "SHOP",
                              style: AppTextStyle.ts20bold.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: Text(
                    AppStrings.loginTitle,
                    style: AppTextStyle.ts21bold.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Email Field
                Text(
                  AppStrings.emailLabel,
                  style: AppTextStyle.ts14normal.copyWith(
                    color: AppColors.primaryTextColor,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: AppStrings.emailHint,
                    hintStyle: AppTextStyle.ts12Regular.copyWith(
                      color: AppColors.secondaryTextColor,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.hintColore,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.errorColor,
                        width: 2,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.emailRequired;
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return AppStrings.emailInvalid;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Password Field
                Text(
                  AppStrings.passwordLabel,
                  style: AppTextStyle.ts14normal.copyWith(
                    color: AppColors.primaryTextColor,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: passwordController,
                  obscureText: isPasswordHidden,
                  decoration: InputDecoration(
                    hintText: AppStrings.passwordHint,
                    hintStyle: AppTextStyle.ts12Regular.copyWith(
                      color: AppColors.secondaryTextColor,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordHidden
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColors.secondaryTextColor,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordHidden = !isPasswordHidden;
                        });
                      },
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.hintColore,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.errorColor,
                        width: 2,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.passwordRequired;
                    }
                    if (value.length < 6) {
                      return AppStrings.passwordTooShort;
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    AppStrings.forgotPassword,
                    style: AppTextStyle.ts12Regular.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: AppTextStyle.ts16medium.copyWith(
                            color: AppColors.secondaryTextColor,
                          ),
                          children: [
                            const TextSpan(text: AppStrings.agreementText),
                            TextSpan(
                              text: AppStrings.userAgreement,
                              style: AppTextStyle.ts16medium.copyWith(
                                color: AppColors.linkColor,
                              ),
                            ),
                            const TextSpan(text: " and "),
                            TextSpan(
                              text: AppStrings.privacyPolicy,
                              style: AppTextStyle.ts16medium.copyWith(
                                color: AppColors.linkColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                    ),
                    onPressed: isLoading ? null : _login,
                    child: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            AppStrings.signIn,
                            style: AppTextStyle.ts14normal.copyWith(
                              color: AppColors.backgroundColor,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 20),
                Center(
                  child: Text(
                    AppStrings.otherWaySignIn,
                    style: AppTextStyle.ts12Regular.copyWith(
                      color: AppColors.hintColore,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppIcons.googleIcon, width: 40, height: 40),
                    const SizedBox(width: 20),
                    SvgPicture.asset(
                      AppIcons.facebookIcon,
                      width: 40,
                      height: 40,
                    ),
                  ],
                ),

                const SizedBox(height: 40),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.dontHaveAccount,
                        style: AppTextStyle.ts12Regular.copyWith(
                          color: AppColors.secondaryTextColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.go(AppRouters.registerScreen);
                        },
                        child: Text(
                          AppStrings.createAccount,
                          style: AppTextStyle.ts12Regular.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
