import 'package:drift/drift.dart';
import 'package:zen_practice/core/database/app_database.dart';
import 'package:zen_practice/features/practice/domain/entities/practice_session.dart';
import 'package:zen_practice/features/practice/domain/entities/practice_type.dart';
import 'package:zen_practice/features/practice/domain/repositories/practice_repository.dart';

class DriftPracticeRepository implements PracticeRepository {
  DriftPracticeRepository(this._database);

  final AppDatabase _database;

  @override
  Future<int> saveSession(PracticeSession session) {
    return _database.into(_database.practiceSessions).insert(
          PracticeSessionsCompanion.insert(
            practiceType: session.type.name,
            durationSeconds: session.duration.inSeconds,
            startedAt: session.startedAt,
            completedAt: session.completedAt,
            isSynced: Value(session.isSynced),
          ),
        );
  }

  @override
  Stream<List<PracticeSession>> watchRecentSessions({int limit = 20}) {
    final query = _database.select(_database.practiceSessions)
      ..orderBy([(row) => OrderingTerm.desc(row.completedAt)])
      ..limit(limit);

    return query.watch().map(
          (rows) => rows.map(_mapRow).toList(growable: false),
        );
  }

  @override
  Stream<Duration> watchTodayTotal(DateTime day) {
    final start = DateTime(day.year, day.month, day.day);
    final end = start.add(const Duration(days: 1));
    final query = _database.select(_database.practiceSessions)
      ..where(
        (row) =>
            row.completedAt.isBiggerOrEqualValue(start) &
            row.completedAt.isSmallerThanValue(end),
      );

    return query.watch().map(
          (rows) => Duration(
            seconds: rows.fold<int>(
              0,
              (total, row) => total + row.durationSeconds,
            ),
          ),
        );
  }

  @override
  Future<List<PracticeSession>> getPendingSyncSessions({int limit = 50}) async {
    final query = _database.select(_database.practiceSessions)
      ..where((row) => row.isSynced.equals(false))
      ..orderBy([(row) => OrderingTerm.asc(row.completedAt)])
      ..limit(limit);

    final rows = await query.get();
    return rows.map(_mapRow).toList(growable: false);
  }

  @override
  Future<void> markSessionsSynced(Iterable<int> sessionIds) async {
    final ids = sessionIds.toList(growable: false);
    if (ids.isEmpty) return;

    await (_database.update(_database.practiceSessions)
          ..where((row) => row.id.isIn(ids)))
        .write(const PracticeSessionsCompanion(isSynced: Value(true)));
  }

  PracticeSession _mapRow(PracticeSessionRow row) {
    return PracticeSession(
      id: row.id,
      type: PracticeType.values.byName(row.practiceType),
      duration: Duration(seconds: row.durationSeconds),
      startedAt: row.startedAt,
      completedAt: row.completedAt,
      isSynced: row.isSynced,
    );
  }
}
