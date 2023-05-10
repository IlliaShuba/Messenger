import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

import 'package:matrix/matrix.dart';
import 'package:universal_html/html.dart' as html;


import 'package:brigadachat/utils/client_manager.dart';
import 'package:brigadachat/utils/platform_infos.dart';
import 'utils/background_push.dart';
import 'widgets/brigada_chat_app.dart';
import 'widgets/lock_screen.dart';

void main() async {
  // Our background push shared isolate accesses flutter-internal things very early in the startup proccess
  // To make sure that the parts of flutter needed are started up already, we need to ensure that the
  // widget bindings are initialized already.
  WidgetsFlutterBinding.ensureInitialized();

  Logs().nativeColors = !PlatformInfos.isIOS;
  final clients = await ClientManager.getClients();

  // Preload first client
  final firstClient = clients.firstOrNull;
  await firstClient?.roomsLoading;
  await firstClient?.accountDataLoading;

  //Screenshot
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);


  if (PlatformInfos.isMobile) {
    BackgroundPush.clientOnly(clients.first);
  }

  final queryParameters = <String, String>{};
  if (kIsWeb) {
    queryParameters
        .addAll(Uri.parse(html.window.location.href).queryParameters);
  }

  runApp(
    PlatformInfos.isMobile
        ? AppLock(
            builder: (args) => brigadachatApp(
              clients: clients,
              queryParameters: queryParameters,
            ),
            lockScreen: const LockScreen(),
            enabled: false,
          )
        : brigadachatApp(
            clients: clients,
            queryParameters: queryParameters,
          ),
  );
}
