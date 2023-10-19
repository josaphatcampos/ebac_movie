import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pre_projeto/common/component/alerts/custom_alert.dart';
import 'package:pre_projeto/common/component/buttons/custom_button.dart';
import 'package:pre_projeto/common/component/buttons/custom_outline_button.dart';
import 'package:pre_projeto/common/component/inputs/custom_text_input.dart';
import 'package:pre_projeto/common/sistem/animaitons.dart';
import 'package:pre_projeto/common/sistem/colors.dart';
import 'package:pre_projeto/common/sistem/images.dart';
import 'package:pre_projeto/common/sistem/routes.dart';
import 'package:pre_projeto/common/sistem/values.dart';
import 'package:pre_projeto/login/controller/login_controller.dart';

import '../../common/component/loading_component.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late LoginController _controller;

  @override
  void initState() {
    super.initState();

    _controller = LoginController();

    _controller.animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: CustomColors.darkNavy,
                image: DecorationImage(
                    image: AssetImage(CustomImages.loginBg), fit: BoxFit.cover)
                // gradient: LinearGradient(
                //   begin: Alignment.topCenter,
                //   end: Alignment.bottomCenter,
                //   colors: [
                //     CustomColors.darkPurple,
                //     CustomColors.darkNavy,
                //   ]
                // )
                ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(CustomValues.paddingBorder),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 1,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: Image.asset(
                          CustomImages.logo,
                        )),
                    Column(
                      children: [
                        const Text("Olá bem-vindo!"),
                        SizedBox(
                          height: CustomValues.marginComponent,
                        ),
                        CustomButton(
                            title: 'Login',
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: CustomColors.darkNavy,
                                  title: Center(
                                    child: Lottie.asset(CustomAnimation.ticket,
                                        height: 75,
                                        fit: BoxFit.contain,
                                        controller:
                                            _controller.animationController,
                                        onLoaded: (composition) {
                                      _controller.animationController
                                        ..duration = composition.duration
                                        ..repeat();
                                    }),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomTextInput(
                                          controller:
                                              _controller.usercontroller,
                                          label: 'Usuário',
                                          placeholder: 'Digite seu usuário'),
                                      SizedBox(
                                        height: CustomValues.marginComponent,
                                      ),
                                      CustomTextInput(
                                          controller:
                                              _controller.passcontroller,
                                          label: 'Senha',
                                          placeholder: 'Digite sua senha',
                                          isObscured: true),
                                      SizedBox(
                                        height: CustomValues.marginComponent,
                                      ),
                                      ValueListenableBuilder(
                                        valueListenable:
                                            _controller.isEnableLogin,
                                        builder: (context, value, child) {
                                          return CustomButton(
                                            title: "Entrar",
                                            onPressed: !value
                                                ? null
                                                : () async {
                                                    Navigator.of(context).pop();
                                                    goToHome();
                                                  },
                                            color: CustomColors.lightNavy,
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                        SizedBox(
                          height: CustomValues.marginComponent,
                        ),
                        CustomOutlineButton(
                            title: 'Registrar',
                            onPressed: () {
                              debugPrint('action');
                            }),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          LoadingComponent(isLoading: _controller.isLoading)
        ],
      ),
    );
  }

  void goToHome() async {
    if (await _controller.tryLogin()) {
      // Navigator.of(context).pushReplacementNamed(Routes.home);
      CustomAlert.showMessage(context, 'Usuário Logado com Sucesso!');
    }else{
      CustomAlert.errorMessage(context, 'Usuário ou Senha incorretos!');
    }
  }
}
