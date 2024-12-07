import 'package:ecommerce_pharmacist_semarang/mvc/controller/change_password_controller.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/change_password_screen/change_password_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/resource/resource_manager.dart';
import 'package:flutter/material.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final ChangePasswordController changePasswordController =
      ChangePasswordController();
  final ChangePasswordDialog changePasswordDialog = ChangePasswordDialog();

  @override
  void initState() {
    super.initState();
    changePasswordController.viewDidLoad();
  }

  Widget changePasswordUILabel() {
    return Container(
      margin: PaddingMarginManager.horizontallySuperView,
      width: double.infinity,
      child: const Text(
        'Ganti Password',
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: FontSizeManager.title1,
          fontWeight: FontWeight.bold,
          color: ColorManager.blackText,
        ),
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
            controller: changePasswordController.usernameUIController,
            textAlignVertical: TextAlignVertical.center,
            decoration: const InputDecoration(
              hintText: "Masukkan username anda",
              prefixIcon: Icon(
                Icons.person_outline_rounded,
                size: 24,
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
            changePasswordController.usernameError,
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
            controller: changePasswordController.passwordUIController,
            obscureText: changePasswordController.isSecure,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: "Masukkan kata sandi akun",
              prefixIcon: const Icon(
                Icons.lock_outline_rounded,
                size: 24,
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
                    changePasswordController.securePasswordTextfieldPressed();
                  });
                },
                icon: Icon(
                  changePasswordController.securePasswordIcon,
                  size: 24,
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
            changePasswordController.passwordError,
            style: const TextStyle(
              fontSize: FontSizeManager.subheadFootnote,
              color: ColorManager.negative,
            ),
          ),
        )
      ],
    );
  }

  Widget submitChangeUIButton() {
    return Container(
      margin: PaddingMarginManager.horizontallySuperView,
      height: 34,
      width: double.infinity,
      child: FilledButton(
        onPressed: () {
          setState(() {
            final bool isSatisfied =
                changePasswordController.changePasswordButtonPressed();
            if (isSatisfied) {
              changePasswordDialog.changePasswordAlertDialog(
                  context, changePasswordController);
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
          'Simpan Perubahan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // changePasswordController.viewDidLoad();

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        changePasswordDialog.cancelAlertDialog(context);
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                changePasswordUILabel(),
                const SizedBox(height: 32),
                usernameUITextField(),
                const SizedBox(height: 16),
                passwordUITextField(),
                const SizedBox(height: 32),
                submitChangeUIButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
