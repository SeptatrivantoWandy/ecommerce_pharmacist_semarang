import 'package:ecommerce_pharmacist_semarang/mvc/controller/login_controller.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/login_screen/login_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/resource/resource_manager.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/healthicons.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginController loginController = LoginController();
  final LoginDialog loginDialog = LoginDialog();

  Widget welcomeDisplaysUIView() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: const Iconify(
              Healthicons.pharmacy,
              size: 64,
              color: ColorManager.primary,
            ),
          ),
          Container(
            margin: PaddingMarginManager.horizontallySuperView,
            child: const Text(
              'PBF Apps',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: FontSizeManager.title1,
                fontWeight: FontWeight.bold,
                color: ColorManager.blackText,
              ),
            ),
          ),
          Container(
            margin: PaddingMarginManager.horizontallySuperView,
            child: const Text(
              'Silahkan masukkan data untuk login',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: FontSizeManager.headlineBody,
                color: ColorManager.subheadFootnote,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget usernameUITextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: PaddingMarginManager.labelTextField,
          child: const Text(
            'Username',
            style: TextStyle(
                fontSize: FontSizeManager.subheadFootnote,
                color: ColorManager.subheadFootnote),
          ),
        ),
        const SizedBox(height: 2),
        Container(
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadiusManager.textfieldRadius,
          ),
          padding: PaddingMarginManager.onlyRight6,
          height: SizeManager.textFieldContainerHeight,
          margin: PaddingMarginManager.textField,
          child: TextField(
            style: const TextStyle(fontSize: FontSizeManager.headlineBody),
            controller: loginController.usernameUIController,
            textAlignVertical: TextAlignVertical.center,
            decoration: const InputDecoration(
              hintText: "Masukkan username anda",
              prefixIcon: Icon(
                Icons.person_outline_rounded,
                size: 26,
                color: ColorManager.primary,
              ),
              prefixIconConstraints: BoxConstraints(
                minWidth: 36,
                minHeight: 34,
              ),
            ),
          ),
        ),
        const SizedBox(height: 2),
        Container(
          margin: PaddingMarginManager.labelTextField,
          child: Text(
            loginController.usernameError,
            style: const TextStyle(
              fontSize: FontSizeManager.subheadFootnote,
              color: ColorManager.negative,
            ),
          ),
        )
      ],
    );
  }

  Widget passwordUITextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: PaddingMarginManager.labelTextField,
          child: const Text(
            'Password',
            style: TextStyle(
              color: ColorManager.subheadFootnote,
              fontSize: FontSizeManager.subheadFootnote,
            ),
          ),
        ),
        const SizedBox(height: 2),
        Container(
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadiusManager.textfieldRadius,
          ),
          height: SizeManager.textFieldContainerHeight,
          margin: PaddingMarginManager.textField,
          child: TextField(
            style: const TextStyle(fontSize: FontSizeManager.headlineBody),
            controller: loginController.passwordUIController,
            obscureText: loginController.isSecure,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: "Masukkan kata sandi akun",
              prefixIcon: const Icon(
                Icons.lock_outline_rounded,
                size: 26,
                color: ColorManager.primary,
              ),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 36,
                minHeight: 34,
              ),
              suffixIcon: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    loginController.securePasswordTextfieldPressed();
                  });
                },
                icon: Icon(
                  loginController.securePasswordIcon,
                  size: 26,
                  color: ColorManager.primary,
                ),
              ),
              suffixIconConstraints: const BoxConstraints(
                minWidth: 36,
                minHeight: 34,
              ),
            ),
          ),
        ),
        const SizedBox(height: 2),
        Container(
          margin: PaddingMarginManager.labelTextField,
          child: Text(
            loginController.passwordError,
            style: const TextStyle(
              fontSize: FontSizeManager.subheadFootnote,
              color: ColorManager.negative,
            ),
          ),
        )
      ],
    );
  }

  Widget loginUIButton() {
    return SizedBox(
      height: 34,
      width: double.infinity,
      child: FilledButton(
        onPressed: () {
          setState(() {
            final bool isSatisfied = loginController.loginButtonPressed();
            if (isSatisfied) {
              loginDialog.loadingAlertDialog(context);
              loginController.loginAccount(context);
            }
          });
        },
        style: FilledButton.styleFrom(
          backgroundColor: ColorManager.primary,
          foregroundColor: ColorManager.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: const Text(
          'Login',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget registerUIButton() {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          loginController.registerButtonPressed(context);
        },
        style: TextButton.styleFrom(
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Belum punya akun? '),
            Text(
              'Register',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: SizedBoxManager.largeSpace),
              welcomeDisplaysUIView(),
              const SizedBox(height: 124),
              usernameUITextField(),
              const SizedBox(height: 16),
              passwordUITextField()
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: BottomAppBarManager.regular + 26,
        child: Column(
          children: [
            loginUIButton(),
            const SizedBox(height: 6),
            registerUIButton()
          ],
        ),
      ),
    );
  }
}
