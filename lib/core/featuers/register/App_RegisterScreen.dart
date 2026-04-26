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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isChecked = false;
  bool isPasswordHidden = true;
  final registerFormKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final AppDatabase _db = AppDatabase();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (registerFormKey.currentState!.validate()) {
      await _db.insertUser(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(AppStrings.successfullyRegistered),
          ),
        );
        context.go(AppRouters.loginScreen);
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
            key: registerFormKey,
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
                    AppStrings.registerTitle,
                    style: AppTextStyle.ts21bold.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Name Field
                Text(
                  AppStrings.nameLabel,
                  style: AppTextStyle.ts14normal.copyWith(
                    color: AppColors.primaryTextColor,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    hintText: AppStrings.nameHint,
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
                      return AppStrings.nameRequired;
                    }
                    if (value.length < 2) {
                      return "Name must be at least 2 characters";
                    }
                    return null;
                  },
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

                const SizedBox(height: 20),

                // Confirm Password Field
                Text(
                  AppStrings.confirmPasswordLabel,
                  style: AppTextStyle.ts14normal.copyWith(
                    color: AppColors.primaryTextColor,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: isPasswordHidden,
                  decoration: InputDecoration(
                    hintText: AppStrings.confirmPasswordHint,
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
                      return AppStrings.confirmPasswordRequired;
                    }
                    if (value != passwordController.text) {
                      return AppStrings.passwordsDoNotMatch;
                    }
                    return null;
                  },
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
                    onPressed: _register,
                    child: Text(
                      AppStrings.signUp,
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
                        AppStrings.alreadyHaveAccount,
                        style: AppTextStyle.ts12Regular.copyWith(
                          color: AppColors.secondaryTextColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.go(AppRouters.loginScreen);
                        },
                        child: Text(
                          AppStrings.backToSignIn,
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
