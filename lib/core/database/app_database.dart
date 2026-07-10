import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class PracticeSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get practiceType => text()();
  IntColumn get durationSeconds => integer()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get completedAt => dateTime()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
}

@DriftDatabase(tables: [PracticeSessions])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'zen_practice'));

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;
}
