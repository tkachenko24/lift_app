import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'injectable/export.dart';
import 'package:notified_elevator/common/export.dart';

import 'modules/export.dart';

Future<void> setup() async {
  final injector = Injector(
    injectable: [
      CommonInjectable(),
    ],
  );

  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    injector.setup(),
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]),
  ]);

  final preferences = PreferencesBloc((PreferencesState state) async {});
  final providers = [
    BlocProvider.value(value: preferences),
  ];

  preferences.add(const Initialization());

  runApp(
    MultiProvider(
      providers: providers,
      child: Navigation(
        builder: (
          context,
          routerDelegate,
          routeInformationParser,
          routeInformationProvider,
        ) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerDelegate: routerDelegate,
            routeInformationParser: routeInformationParser,
            routeInformationProvider: routeInformationProvider,
          );
        },
      ),
    ),
  );
}
