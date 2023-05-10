import 'package:flutter/material.dart';

import 'package:matrix/matrix.dart';
import 'package:vrouter/vrouter.dart';

import 'package:brigadachat/utils/update_checker_no_store.dart';
import 'package:brigadachat/widgets/layouts/empty_page.dart';
import 'package:brigadachat/widgets/matrix.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await UpdateCheckerNoStore(context).checkUpdate();
        VRouter.of(context).to(
          Matrix.of(context).widget.clients.any(
                    (client) =>
                        client.onLoginStateChanged.value == LoginState.loggedIn,
                  )
              ? '/rooms'
              : '/home',
          queryParameters: VRouter.of(context).queryParameters,
        );
      },
    );
    return const EmptyPage(loading: true);
  }
}
