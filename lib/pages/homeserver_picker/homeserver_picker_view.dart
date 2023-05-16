import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:brigadachat/config/app_config.dart';
import 'package:brigadachat/widgets/layouts/login_scaffold.dart';
import '../../config/themes.dart';
import 'homeserver_app_bar.dart';
import 'homeserver_picker.dart';
import '../../utils/utils.dart';

class HomeserverPickerView extends StatelessWidget {
  final HomeserverPickerController controller;

  const HomeserverPickerView(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double baseHeight = 800;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double fvm = MediaQuery.of(context).size.height / baseHeight;
    double ffem = fem * 0.97;

    return Scaffold(
      body: SizedBox(
        width: baseHeight * fem,
        height: baseHeight * fvm,
        child: Column(
          mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(18*fem, 28.74*fem, 18*fem, 22*fvm),
              width: 300*fem,
              decoration: BoxDecoration (
                color: const Color(0x72af9e2c),
                borderRadius: BorderRadius.circular(20*fem),
              ),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur (
                    sigmaX: 10*fem,
                    sigmaY: 10*fem,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0.24*fem, 15.43*fem),
                        width: 148.37*fem,
                        height: 174.83*fem,
                        child: Image.asset(
                          'assets/dark107brigada-2.png',
                          width: 148.37*fem,
                          height: 174.83*fem,
                        ),
                      ),
                      Container(
                        // fyo (6:12)
                        constraints: BoxConstraints (
                          maxWidth: 264*fem,
                        ),
                        child: Text(
                          '107 окрема бригада Сил територіальної оборони Буковини\n',
                          textAlign: TextAlign.center,
                          style: SafeGoogleFont (
                            'Inter',
                            fontSize: 14*ffem,
                            fontWeight: FontWeight.w800,
                            height: 1.2102272851*ffem/fem,
                            letterSpacing: 0.98*fem,
                            color: const Color(0xff75704e),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
                constraints: BoxConstraints (
                  maxWidth: 263*fem,
                  maxHeight: 66*fvm,
                ),
                child: Text(
                  'ТЕРИТОРІАЛЬНА ОБОРОНА БУКОВИНИ\nГОТОВІ ДО СПРОТИВУ',
                  textAlign: TextAlign.center,
                  style: SafeGoogleFont (
                    'Inter',
                    fontSize: 15*ffem,
                    fontWeight: FontWeight.w800,
                    height: 1.2102272034*ffem/fem,
                    letterSpacing: 1.05*fem,
                    color: const Color(0xff3c371c),
                  ),
                ),
              ),
            ElevatedButton.icon(
              onPressed: controller.isLoading
                  ? null
                  : controller.checkHomeserverAction,
              style:ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff75704e),
                minimumSize: const Size(291, 42),
                elevation: 6.0,
              ),
              icon:  Image.asset('assets/primeng-icons-v500.png', width: 16*fem, height: 16*fvm,),
              label:Text(
                // 8RT (7:17)
                L10n.of(context)!.start,
                style: SafeGoogleFont (
                  'Inter',
                  fontSize: 15*ffem,
                  fontWeight: FontWeight.w600,
                  height: 1.2102272034*ffem/fem,
                  letterSpacing: 0.45*fem,
                  color: const Color(0xffffffff),
                ),
              ),
            ),

              /*Container(
                // startTRo (12:1044)
                padding: EdgeInsets.fromLTRB(4.25*fem, 3*fem, 0*fem, 3*fem),
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                  ],
                ),
              ),
            ),*/
         ],
        ),
      ),
    );
  }
}
