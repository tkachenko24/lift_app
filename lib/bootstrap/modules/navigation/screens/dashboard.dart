import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:notified_elevator/bootstrap/injectable/injectable.dart';
import 'package:notified_elevator/dashboard/export.dart';

import '../guards/export.dart';
import 'screens.dart';

class DashboardScreens extends Screens {
  static Screen dashboard = Screen(path: '/dashboard');
  static Screen house = Screen(path: '$dashboard/house');
  static Screen lift = Screen(path: '$house/lift');

  @override
  List<RouteBase> routes = [
    GoRoute(
      path: dashboard.path,
      name: dashboard.name,
      redirect: ScreenGuards([]),
      builder: (BuildContext context, GoRouterState state) {
        return DashboardScreen(
          toHouse: () => context.pushNamed(house.name),
        );
      },
    ),
    GoRoute(
      path: house.path,
      name: house.name,
      redirect: ScreenGuards([]),
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (context) => HouseBloc(
            repository: locator.get(),
          ),
          child: HouseScreen(
            toLift: (houseId) => context.pushNamed(lift.name, extra: houseId),
          ),
        );
      },
    ),
    GoRoute(
      path: lift.path,
      name: lift.name,
      redirect: ScreenGuards([]),
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (context) => LiftBloc(
            repository: locator.get(),
          ),
          child: LiftScreen(houseId: state.extra as int),
        );
      },
    ),
  ];
}
