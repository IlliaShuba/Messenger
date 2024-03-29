import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:future_loading_dialog/future_loading_dialog.dart';
import 'package:intl/intl.dart';
import 'package:matrix/matrix.dart';

import 'package:brigadachat/config/setting_keys.dart';
import 'package:brigadachat/utils/matrix_sdk_extensions/matrix_file_extension.dart';
import 'package:brigadachat/widgets/matrix.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../bootstrap/bootstrap_dialog.dart';
import 'settings_security_view.dart';

class SettingsSecurity extends StatefulWidget {
  const SettingsSecurity({Key? key}) : super(key: key);

  @override
  SettingsSecurityController createState() => SettingsSecurityController();
}

class SettingsSecurityController extends State<SettingsSecurity> {
  void changePasswordAccountAction() async {
    final input = await showTextInputDialog(
      useRootNavigator: false,
      context: context,
      title: L10n.of(context)!.changePassword,
      okLabel: L10n.of(context)!.ok,
      cancelLabel: L10n.of(context)!.cancel,
      textFields: [
        DialogTextField(
          hintText: L10n.of(context)!.chooseAStrongPassword,
          obscureText: true,
          minLines: 1,
          maxLines: 1,
        ),
        DialogTextField(
          hintText: L10n.of(context)!.repeatPassword,
          obscureText: true,
          minLines: 1,
          maxLines: 1,
        ),
      ],
    );
    if (input == null) return;
    final success = await showFutureLoadingDialog(
      context: context,
      future: () => Matrix.of(context)
          .client
          .changePassword(input.last, oldPassword: input.first),
    );
    if (success.error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(L10n.of(context)!.passwordHasBeenChanged)),
      );
    }
  }

  Future<void> createNewCrossSigningKey( [String? passphrase]) async {
    try {
      if(Platform.isAndroid) {
        if (await Permission.storage.request().isGranted) {
          const fileName = 'security-key.txt';
          final activeClient = Matrix.of(context).client;
          final key = await activeClient.encryption?.ssss.createKey(passphrase);

          final result = await FilePicker.platform.getDirectoryPath();
          if (result != null) {
            final directory = Directory(result);
            final file = File('${directory.path}/$fileName');
            await file.writeAsString(key?.keyId ?? '');
            print('Файл успішно збережено! Шлях: ${file.path}');
          } else {
            print('Не вибрано жодної папки.');
          }
        } else {
          print('Дозвіл на запис в файлову систему не надано.');
        }
      }
      else if(Platform.isIOS) {
        // Handle iOS file saving here
      }
    } catch (e) {
      String errorMessage = 'Помилка при збереженні файлу: $e';
      print(errorMessage);
    }
  }

  void setAppLockAction() async {
    final currentLock =
        await const FlutterSecureStorage().read(key: SettingKeys.appLockKey);
    if (currentLock?.isNotEmpty ?? false) {
      await AppLock.of(context)!.showLockScreen();
    }
    final newLock = await showTextInputDialog(
      useRootNavigator: false,
      context: context,
      title: L10n.of(context)!.pleaseChooseAPasscode,
      message: L10n.of(context)!.pleaseEnter4Digits,
      cancelLabel: L10n.of(context)!.cancel,
      textFields: [
        DialogTextField(
          validator: (text) {
            if (text!.isEmpty ||
                (text.length == 4 && int.tryParse(text)! >= 0)) {
              return null;
            }
            return L10n.of(context)!.pleaseEnter4Digits;
          },
          keyboardType: TextInputType.number,
          obscureText: true,
          maxLines: 1,
          minLines: 1,
        )
      ],
    );
    if (newLock != null) {
      await const FlutterSecureStorage()
          .write(key: SettingKeys.appLockKey, value: newLock.single);
      if (newLock.single.isEmpty) {
        AppLock.of(context)!.disable();
      } else {
        AppLock.of(context)!.enable();
      }
    }
  }

  void deleteAccountAction() async {
    if (await showOkCancelAlertDialog(
          useRootNavigator: false,
          context: context,
          title: L10n.of(context)!.warning,
          message: L10n.of(context)!.deactivateAccountWarning,
          okLabel: L10n.of(context)!.ok,
          cancelLabel: L10n.of(context)!.cancel,
        ) ==
        OkCancelResult.cancel) {
      return;
    }
    final supposedMxid = Matrix.of(context).client.userID!;
    final mxids = await showTextInputDialog(
      useRootNavigator: false,
      context: context,
      title: L10n.of(context)!.confirmMatrixId,
      textFields: [
        DialogTextField(
          validator: (text) => text == supposedMxid
              ? null
              : L10n.of(context)!.supposedMxid(supposedMxid),
        ),
      ],
      okLabel: L10n.of(context)!.delete,
      cancelLabel: L10n.of(context)!.cancel,
    );
    if (mxids == null || mxids.length != 1 || mxids.single != supposedMxid) {
      return;
    }
    final input = await showTextInputDialog(
      useRootNavigator: false,
      context: context,
      title: L10n.of(context)!.pleaseEnterYourPassword,
      okLabel: L10n.of(context)!.ok,
      cancelLabel: L10n.of(context)!.cancel,
      textFields: [
        const DialogTextField(
          obscureText: true,
          hintText: '******',
          minLines: 1,
          maxLines: 1,
        )
      ],
    );
    if (input == null) return;
    await showFutureLoadingDialog(
      context: context,
      future: () => Matrix.of(context).client.deactivateAccount(
            auth: AuthenticationPassword(
              password: input.single,
              identifier: AuthenticationUserIdentifier(
                user: Matrix.of(context).client.userID!,
              ),
            ),
          ),
    );
  }

  void showBootstrapDialog(BuildContext context) async {
    await BootstrapDialog(
      client: Matrix.of(context).client,
    ).show(context);
  }

  Future<void> dehydrateAction() => dehydrateDevice(context);

  static Future<void> dehydrateDevice(BuildContext context) async {
    final response = await showOkCancelAlertDialog(
      context: context,
      isDestructiveAction: true,
      title: L10n.of(context)!.dehydrate,
      message: L10n.of(context)!.dehydrateWarning,
    );
    if (response != OkCancelResult.ok) {
      return;
    }
    final file = await showFutureLoadingDialog(
      context: context,
      future: () async {
        final export = await Matrix.of(context).client.exportDump();
        if (export == null) throw Exception('Export data is null.');

        final exportBytes = Uint8List.fromList(
          const Utf8Codec().encode(export),
        );

        final exportFileName =
            'brigadachat-export-${DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.now())}.fluffybackup';

        return MatrixFile(bytes: exportBytes, name: exportFileName);
      },
    );
    file.result?.save(context);
  }

  @override
  Widget build(BuildContext context) => SettingsSecurityView(this);
}
