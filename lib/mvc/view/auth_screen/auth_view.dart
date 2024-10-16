import 'package:ecommerce_pharmacist_semarang/mvc/view/login_screen/login_view.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/menu_screen/main_menu_view.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/splash_screen/spash_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {

  final Future<SharedPreferences> futurePrefs = SharedPreferences.getInstance();
  late Future<bool> loginCheckFuture;

  Future<bool> checkIfLoggedIn() async {
    await Future.delayed(const Duration(seconds: 1));
    final SharedPreferences prefs = await futurePrefs;
    var isAuth = prefs.getString('username');
    if (isAuth != null && isAuth.isNotEmpty && isAuth != '') {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    loginCheckFuture = checkIfLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    return FutureBuilder(
      future: checkIfLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == true) {
            child = const MainMenuView();
          } else {
            child = const LoginView();
          }
        } else {
          child = const SplashView();
        }
        return Scaffold(
          body: child,
        );
      },
    );
  }
}