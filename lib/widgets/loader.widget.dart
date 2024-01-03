import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';

import 'package:my_own_proj/store/app.state.dart';

class LoaderWidget extends StatelessWidget {
  final Widget child;

  const LoaderWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, int>(
      converter: (store) => store.state.loaderCount,
      builder: (context, loaderCount) {
        return Stack(
          children: [
            child,
            loaderCount > 0
                ? Container(
                    decoration: const BoxDecoration(
                      color: Colors.black38,
                    ),
                    child: const Center(
                      child: SizedBox(
                        height: 60,
                        width: 60,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                : const SizedBox.shrink()
          ],
        );
      },
    );
  }
}
