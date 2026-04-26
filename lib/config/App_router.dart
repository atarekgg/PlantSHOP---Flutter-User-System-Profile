import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login/core/featuers/SplashScreen/App_SplashScreen.dart';
import 'package:login/core/featuers/login/App_LoginScreen.dart';
import 'package:login/core/featuers/register/App_RegisterScreen.dart';
import 'package:login/core/featuers/profile/App_ProfileScreen.dart';
import 'package:login/core/featuers/form/App_FormScreen.dart';
import 'package:login/config/router.dart';


class AppRouter {
  static final router=GoRouter(
    routes: [
      GoRoute(
        path: AppRouters.splashScreen,
        builder: (context,state)=>const SplashScreen(),   
      ),
      GoRoute(
        path: AppRouters.loginScreen,
        builder: (context,state)=>const Loginscreen(),
      ),
      GoRoute(
        path: AppRouters.registerScreen,
        builder: (context,state)=>const RegisterScreen(),
      ),
      GoRoute(
        path: AppRouters.profileScreen,
        builder: (context,state)=>const ProfileScreen(),
      ),
      GoRoute(
        path: AppRouters.formScreen,
        builder: (context,state)=>const FormScreen(),
      ),
    ]
  );



}
