import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:login/config/router.dart';
import 'package:login/core/assets/app_icons.dart';
import 'dart:async';
import 'package:login/core/assets/app_images.dart';
import 'package:login/core/theme/app_text_style.dart';
import 'package:login/core/utils/app_responsive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.go(AppRouters.loginScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.SplashScreenbg),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SvgPicture.asset(
                AppIcons.logo,
                width: AppResponsive.width(context) * .17,
                height: AppResponsive.height(context) * .13,
              ),
            ),
            Center(
              child: Text(
                "Plant SHOP",
                style: AppTextStyle.ts20bold.copyWith(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

