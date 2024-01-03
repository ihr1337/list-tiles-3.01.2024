import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:my_own_proj/firebase_options.dart';
import 'package:my_own_proj/pages/home/home.container.dart';
import 'package:my_own_proj/store/app.reducer.dart';
import 'package:my_own_proj/store/app.state.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final store = Store<AppState>(
    appReducer,
    initialState: AppState.initialState(),
    middleware: [thunkMiddleware],
  );

  runApp(
    MyApp(store: store),
  );
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  const MyApp({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StoreProvider<AppState>(
        store: store,
        child: const HomeContainer(title: 'Firebase App'),
      ),
    );
  }
}
