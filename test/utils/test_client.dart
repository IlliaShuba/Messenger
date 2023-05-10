// ignore_for_file: depend_on_referenced_packages

import 'package:matrix/encryption/utils/key_verification.dart';
import 'package:matrix/matrix.dart';
import 'package:matrix_api_lite/fake_matrix_api.dart';

import 'package:brigadachat/utils/matrix_sdk_extensions/flutter_hive_collections_database.dart';

Future<Client> prepareTestClient({
  bool loggedIn = false,
  Uri? homeserver,
  String id = 'brigadachat Widget Test',
}) async {
  homeserver ??= Uri.parse('https://fakeserver.notexisting');
  final client = Client(
    'brigadachat Widget Tests',
    httpClient: FakeMatrixApi(),
    verificationMethods: {
      KeyVerificationMethod.numbers,
      KeyVerificationMethod.emoji,
    },
    importantStateEvents: <String>{
      'im.ponies.room_emotes', // we want emotes to work properly
    },
    databaseBuilder: FlutterHiveCollectionsDatabase.databaseBuilder,
    supportedLoginTypes: {
      AuthenticationTypes.password,
      AuthenticationTypes.sso
    },
  );
  await client.checkHomeserver(homeserver);
  if (loggedIn) {
    await client.login(
      LoginType.mLoginToken,
      identifier: AuthenticationUserIdentifier(user: '@alice:example.invalid'),
      password: '1234',
    );
  }
  return client;
}
