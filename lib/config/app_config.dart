import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';

abstract class AppConfig {
  static String _applicationName = 'brigadachat';
  static String get applicationName => _applicationName;
  static String? _applicationWelcomeMessage;
  static String? get applicationWelcomeMessage => _applicationWelcomeMessage;
  static String _defaultHomeserver = '107brigada.top';
  static String get defaultHomeserver => _defaultHomeserver;
  static double bubbleSizeFactor = 1;
  static double fontSizeFactor = 1;
  static const Color chatColor = primaryColor;
  static Color? colorSchemeSeed = primaryColor;
  static const double messageFontSize = 15.75;
  static const bool allowOtherHomeservers = false;
  static const bool enableRegistration = true;
  static const Color primaryColor = Color.fromRGBO(117, 112, 78, 1);
  static const Color primaryColorLight = Colors.lightGreen/*Color(0xFFCCBDEA)*/;
  static const Color secondaryColor = Color(0xFF41a2bc);
  static String _privacyUrl =
      'https://gitlab.com/famedly/brigadachat/-/blob/main/PRIVACY.md';
  static String get privacyUrl => _privacyUrl;
  static const String enablePushTutorial =
      'https://gitlab.com/famedly/brigadachat/-/wikis/Push-Notifications-without-Google-Services';
  static const String encryptionTutorial =
      'https://gitlab.com/famedly/brigadachat/-/wikis/How-to-use-end-to-end-encryption-in-brigadachat';
  static const String appId = 'im.brigadachat.brigadachat';
  static const String appOpenUrlScheme = 'im.brigadachat';
  static String _webBaseUrl = 'https://brigadachat.im/web';
  static String get webBaseUrl => _webBaseUrl;
  static const String sourceCodeUrl = 'https://gitlab.com/famedly/brigadachat';
  static const String supportUrl =
      'https://gitlab.com/famedly/brigadachat/issues';
  static const bool enableSentry = true;
  static const String sentryDns =
      'https://8591d0d863b646feb4f3dda7e5dcab38@o256755.ingest.sentry.io/5243143';
  static bool renderHtml = true;
  static bool hideRedactedEvents = false;
  static bool hideUnknownEvents = true;
  static bool hideUnimportantStateEvents = true;
  static bool showDirectChatsInSpaces = true;
  static bool separateChatTypes = false;
  static bool autoplayImages = true;
  static bool sendOnEnter = false;
  static bool experimentalVoip = false;
  static const bool hideTypingUsernames = false;
  static const bool hideAllStateEvents = false;
  static const String inviteLinkPrefix = 'https://matrix.to/#/';
  static const String deepLinkPrefix = 'im.brigadachat://chat/';
  static const String schemePrefix = 'matrix:';
  static const String pushNotificationsChannelId = 'brigadachat_push';
  static const String pushNotificationsChannelName = 'brigadachat push channel';
  static const String pushNotificationsChannelDescription =
      'Push notifications for brigadachat';
  static const String pushNotificationsAppId = 'chat.fluffy.brigadachat';
  static const String pushNotificationsGatewayUrl =
      'https://push.brigadachat.im/_matrix/push/v1/notify';
  static const String pushNotificationsPusherFormat = 'event_id_only';
  static const String emojiFontName = 'Noto Emoji';
  static const String emojiFontUrl =
      'https://github.com/googlefonts/noto-emoji/';
  static const double borderRadius = 16.0;
  static const double columnWidth = 360.0;

  static void loadFromJson(Map<String, dynamic> json) {
    if (json['chat_color'] != null) {
      try {
        colorSchemeSeed = Color(json['chat_color']);
      } catch (e) {
        Logs().w(
          'Invalid color in config.json! Please make sure to define the color in this format: "0xffdd0000"',
          e,
        );
      }
    }
    if (json['application_name'] is String) {
      _applicationName = json['application_name'];
    }
    if (json['application_welcome_message'] is String) {
      _applicationWelcomeMessage = json['application_welcome_message'];
    }
    if (json['default_homeserver'] is String) {
      _defaultHomeserver = json['default_homeserver'];
    }
    if (json['privacy_url'] is String) {
      _webBaseUrl = json['privacy_url'];
    }
    if (json['web_base_url'] is String) {
      _privacyUrl = json['web_base_url'];
    }
    if (json['render_html'] is bool) {
      renderHtml = json['render_html'];
    }
    if (json['hide_redacted_events'] is bool) {
      hideRedactedEvents = json['hide_redacted_events'];
    }
    if (json['hide_unknown_events'] is bool) {
      hideUnknownEvents = json['hide_unknown_events'];
    }
  }
}
