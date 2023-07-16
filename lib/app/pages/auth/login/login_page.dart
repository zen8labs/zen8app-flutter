import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zen8app/app/pages/auth/login/login_vm.dart';
import 'package:zen8app/core/core.dart';
import 'package:zen8app/router/router.dart';
import 'package:zen8app/utils/utils.dart';
import 'package:zen8app/widgets/widgets.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with MVVMBinding<LoginVM, LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController(text: "toann@zen8labs.com");
  final _passwordController = TextEditingController(text: "1234567890");

  @override
  LoginVM onCreateVM() => LoginVM();

  @override
  void onBindingVM(CompositeSubscription subscription) {
    vm.output.response.listen((response) async {
      await Session.startAuthenticatedSession(response);
      context.router.replaceAll([HomeRoute()]);
    }).addTo(subscription);
  }

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      error: vm.errorTracker.asAppException(),
      isLoading: vm.activityTracker.isRunningAny(),
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Đăng nhập",
                  style: AppTheme.textStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
                _usernameField(),
                const SizedBox(height: 8),
                _passwordField(),
                const SizedBox(height: 16),
                _loginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _loginButton() {
    return Container(
      height: 56,
      decoration: const BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: TextButton(
        onPressed: () {
          if (_formKey.currentState?.validate() == true) {
            vm.input.login
                .add((_usernameController.text, _passwordController.text));
          }
        },
        child: Text(
          "Đăng nhập",
          style: AppTheme.textStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _passwordField() {
    return SecuredField(
      controller: _passwordController,
      icon: const Icon(Icons.key),
      hintText: "Mật khẩu",
      validator: (value) {
        int length = value?.length ?? 0;
        if (length < 6) {
          return "Mật khẩu phải có ít nhất 6 ký tự";
        }
        return null;
      },
    );
  }

  Widget _usernameField() {
    return TextFormField(
      controller: _usernameController,
      decoration: const InputDecoration(
          filled: true,
          fillColor: Color(0xFFF3F3F3),
          prefixIcon: Icon(Icons.person),
          hintText: "Số điện thoại/Email",
          helperText: "",
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none),
      validator: (value) {
        bool isValidEmail = value?.ex.isValidEmail() ?? false;
        bool isValidPhone = value?.ex.isValidPhoneNumber() ?? false;
        if (isValidPhone || isValidEmail) {
          return null;
        }

        return "Số điện thoại hoặc email không hợp lệ";
      },
    );
  }
}
