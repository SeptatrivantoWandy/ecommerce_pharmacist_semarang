import 'package:ecommerce_pharmacist_semarang/mvc/controller/register_controller.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/register_screen/register_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/resource/resource_manager.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  RegisterController registerController = RegisterController();
  RegisterDialog registerDialog = RegisterDialog();

  Widget welcomeDisplaysUIView() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            child: const Icon(
              Icons.local_pharmacy_rounded,
              color: ColorManager.primary,
              size: 100,
            ),
          ),
          Container(
            margin: PaddingMarginManager.horizontallySuperView,
            child: const Text(
              'Register Account',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: FontSizeManager.largeTitle,
                fontWeight: FontWeight.bold,
                color: ColorManager.blackText,
              ),
            ),
          ),
          Container(
            margin: PaddingMarginManager.horizontallySuperView,
            child: const Text(
              'Lengkapi data berikut untuk mendaftar',
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
            controller: registerController.usernameUIController,
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
            registerController.usernameError,
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
            controller: registerController.passwordUIController,
            obscureText: registerController.isSecure,
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
                    registerController.securePasswordTextfieldPressed();
                  });
                },
                icon: Icon(
                  registerController.securePasswordIcon,
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
            registerController.passwordError,
            style: const TextStyle(
              fontSize: FontSizeManager.subheadFootnote,
              color: ColorManager.negative,
            ),
          ),
        )
      ],
    );
  }

  Widget confirmPasswordUITextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: PaddingMarginManager.labelTextField,
          child: const Text(
            'Confirm Password',
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
            controller: registerController.confirmPasswordUIController,
            obscureText: registerController.isSecureConfirm,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: "Konfirmasi kata sandi akun",
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
                    registerController.secureConfirmPasswordTextfieldPressed();
                  });
                },
                icon: Icon(
                  registerController.secureConfirmPasswordIcon,
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
            registerController.confirmPasswordError,
            style: const TextStyle(
              fontSize: FontSizeManager.subheadFootnote,
              color: ColorManager.negative,
            ),
          ),
        )
      ],
    );
  }

  Widget dataFakturPajakUILabel() {
    return Container(
      margin: PaddingMarginManager.horizontallySuperView,
      width: double.infinity,
      child: const Text(
        'Data Faktur Pajak',
        style: TextStyle(
          fontSize: FontSizeManager.largeTitle,
          fontWeight: FontWeight.bold,
          color: ColorManager.blackText,
        ),
      ),
    );
  }

  Widget namaUITextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: PaddingMarginManager.labelTextField,
          child: const Text(
            'Nama',
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
            controller: registerController.namaUIController,
            textAlignVertical: TextAlignVertical.center,
            decoration: const InputDecoration(
              hintText: "Nama",
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
            registerController.namaError,
            style: const TextStyle(
              fontSize: FontSizeManager.subheadFootnote,
              color: ColorManager.negative,
            ),
          ),
        )
      ],
    );
  }

  Widget alamatUITextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: PaddingMarginManager.labelTextField,
          child: const Text(
            'Alamat',
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
            controller: registerController.alamatUIController,
            textAlignVertical: TextAlignVertical.center,
            decoration: const InputDecoration(
              hintText: "Alamat",
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
            registerController.alamatError,
            style: const TextStyle(
              fontSize: FontSizeManager.subheadFootnote,
              color: ColorManager.negative,
            ),
          ),
        )
      ],
    );
  }

  Widget kotaUITextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: PaddingMarginManager.labelTextField,
          child: const Text(
            'Kota',
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
            controller: registerController.kotaUIController,
            textAlignVertical: TextAlignVertical.center,
            decoration: const InputDecoration(
              hintText: "Kota",
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
            registerController.kotaError,
            style: const TextStyle(
              fontSize: FontSizeManager.subheadFootnote,
              color: ColorManager.negative,
            ),
          ),
        )
      ],
    );
  }

  Widget npwpUITextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: PaddingMarginManager.labelTextField,
          child: const Text(
            'NPWP',
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
            controller: registerController.npwpUIController,
            textAlignVertical: TextAlignVertical.center,
            decoration: const InputDecoration(
              hintText: "NPWP",
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
            registerController.npwpError,
            style: const TextStyle(
              fontSize: FontSizeManager.subheadFootnote,
              color: ColorManager.negative,
            ),
          ),
        )
      ],
    );
  }

  Widget registerUIButton() {
    return Container(
      margin: PaddingMarginManager.horizontallySuperView,
      height: 34,
      width: double.infinity,
      child: FilledButton(
        onPressed: () {
          setState(() {
            final bool isSatisfied =
                registerController.registerButtonPressed(context);
            if (isSatisfied) {
              registerDialog.registerAlertDialog(context, registerController);
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
          'Simpan Registrasi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget batalUIButton() {
    return Container(
      margin: PaddingMarginManager.horizontallySuperView,
      height: 34,
      width: double.infinity,
      child: FilledButton(
        onPressed: () {
          
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: ColorManager.white,
          foregroundColor: ColorManager.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: const BorderSide(
              color: ColorManager.negative
            )
          ),
        ),
        child: const Text(
          'Batal',
          style: TextStyle(
            color: ColorManager.negative,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget sudahPunyaAkunUIButton() {
    return Container(
      margin: PaddingMarginManager.horizontallySuperView,
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          
        },
        style: TextButton.styleFrom(
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sudah punya akun? '),
            Text(
              'Login',
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
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              welcomeDisplaysUIView(),
              const SizedBox(height: 48),
              usernameUITextField(),
              const SizedBox(height: 16),
              passwordUITextField(),
              const SizedBox(height: 16),
              confirmPasswordUITextField(),
              const SizedBox(height: 64),
              dataFakturPajakUILabel(),
              const SizedBox(height: 16),
              namaUITextField(),
              const SizedBox(height: 16),
              alamatUITextField(),
              const SizedBox(height: 16),
              kotaUITextField(),
              const SizedBox(height: 16),
              npwpUITextField(),
              const SizedBox(height: 16),
              registerUIButton(),
              const SizedBox(height: 16),
              batalUIButton(),
              const SizedBox(height: 16),
              sudahPunyaAkunUIButton()
            ],
          ),
        ),
      ),
    );
  }
}
