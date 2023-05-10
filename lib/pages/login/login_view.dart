import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/l10n.dart';

import 'package:fluffychat/widgets/layouts/login_scaffold.dart';
import 'package:fluffychat/widgets/matrix.dart';
import '../../utils/utils.dart';
import 'login.dart';

class LoginView extends StatelessWidget {
  final LoginController controller;

  const LoginView(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return LoginScaffold(
      body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.fromLTRB(19*fem, 132*fem, 20*fem, 314*fem),
              width: double.infinity,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.fromLTRB(11*fem, 0*fem, 0*fem, 48*fem),
                        child: Text(
                            L10n.of(context)!.login,
                            textAlign: TextAlign.center,
                            style: safeGoogleFont (
                                'Inter',
                                fontSize: 32*ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.2125*ffem/fem,
                                color: const Color(0xff000000)
                            )
                        )
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(1*fem, 0*fem, 0*fem, 39*fem),
                        width: 320*fem,
                        height: 1*fem,
                        decoration: const BoxDecoration (
                            color: Color(0xffc4c4c4)
                        )
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(1*fem, 0*fem, 0*fem, 40*fem),
                        width: 320*fem,
                        child: TextField(
                            readOnly: controller.loading,
                            autocorrect: false,
                            autofocus: true,
                            onChanged: controller.checkWellKnownWithCoolDown,
                            controller: controller.usernameController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            autofillHints:
                            controller.loading ? null : [AutofillHints.username],
                            decoration: InputDecoration(
                              hintText: L10n.of(context)!.username,
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xffababab)),
                                  borderRadius: BorderRadius.circular(3*fem)
                              ),
                              contentPadding: EdgeInsets.fromLTRB(12*fem, 16*fem, 12*fem, 16*fem),
                              prefixIcon: const Icon(Icons.account_box_outlined),
                              errorText: controller.usernameError,
                              errorStyle: const TextStyle(color: Colors.orange),
                            ),
                            maxLines: 1,
                            style: safeGoogleFont (
                                'Inter',
                                fontSize: 18*ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.2125*ffem/fem,
                                color: const Color(0xff7c7c7c)
                            )
                        )
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(1*fem, 0*fem, 0*fem, 40*fem),
                        width: 320*fem,
                        child: TextField(
                            readOnly: controller.loading,
                            autocorrect: false,
                            autofillHints:
                            controller.loading ? null : [AutofillHints.password],
                            controller: controller.passwordController,
                            textInputAction: TextInputAction.go,
                            obscureText: !controller.showPassword,
                            onSubmitted: (_) => controller.login(),
                            enableSuggestions: false,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.lock_outlined),
                                errorText: controller.passwordError,
                                errorStyle: const TextStyle(color: Colors.orange),
                                hintText: L10n.of(context)!.password,
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Color(0xffababab)),
                                    borderRadius: BorderRadius.circular(3*fem)
                                ),
                                contentPadding: EdgeInsets.fromLTRB(12*fem, 16*fem, 12*fem, 16*fem),
                                suffixIcon: Align(
                                  widthFactor: 1.0,
                                  heightFactor: 1.0,
                                  child: IconButton(
                                    onPressed: controller.toggleShowPassword,
                                    icon: Icon(
                                        controller.showPassword ?
                                        Icons.visibility : Icons.visibility_off
                                    ),
                                  ),
                                )
                            ),
                            maxLines: 1,
                            style: safeGoogleFont (
                                'Inter',
                                fontSize: 18*ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.2125*ffem/fem,
                                color: const Color(0xff7c7c7c)
                            )
                        )
                    ),
                    SizedBox(
                        width: 320*fem,
                        height: 42*fem,

                        child: ElevatedButton(

                            onPressed: controller.loading ? null : controller.login,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff7c7c7c),
                                elevation: 6.0,
                                textStyle: safeGoogleFont (
                                    'Inter',
                                    fontSize: 18*ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2125*ffem/fem,
                                    color: const Color(0xff7c7c7c)
                                )
                            ),
                            child: Text(L10n.of(context)!.login)
                        )
                    )
                  ]
              )
          )
      )
    );
  }
}
