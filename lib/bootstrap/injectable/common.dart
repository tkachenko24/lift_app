import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:notified_elevator/dashboard/domain/repositories/export.dart';

import 'package:notified_elevator/dashboard/infrastructure/export.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'injectable.dart';

class CommonInjectable extends Injectable {
  @override
  Future<void> register(
    GetIt it,
  ) async {
    it.registerSingletonAsync<Database>(
      () async => openDatabase(
        Platform.isAndroid
            ? '${await getDatabasesPath()}/data_base.db'
            : await getLibraryDirectory()
                .then((directory) => "${directory.path}/data_base.db"),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE Houses (id INTEGER PRIMARY KEY, name TEXT, floors INTEGER, currentFloor INTEGER, targetFloor INTEGER)'),
        version: 1,
      ),
    );

    it.registerLazySingleton<HousesDataBase>(
      () => HousesDataBaseSqLiteImplementation(
        database: it.get(),
        mapper: HouseModelToHouseEntityMapper(),
      ),
    );

    it.registerLazySingleton<HousesRepository>(
      () => HousesRepositoryImplementation(
        dataBase: it.get(),
        mapper: HouseModelToHouseEntityMapper(),
      ),
    );

    it.registerLazySingleton<NotificationSource>(
      () => const NotificationMethodChanelImplementation(
        channel: MethodChannel('localNotification'),
      ),
    );

    it.registerLazySingleton<LiftRepository>(
      () => LiftRepositoryImplementation(
        dataBase: it.get(),
        mapper: HouseModelToHouseEntityMapper(),
        notification: it.get(),
      ),
    );
  }
}
