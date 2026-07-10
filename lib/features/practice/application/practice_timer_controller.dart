import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zen_practice/features/practice/domain/entities/practice_type.dart';

enum PracticeTimerStatus { idle, running, paused, completed }

class PracticeTimerState {
  const PracticeTimerState({
    this.type = PracticeType.meditation,
    this.elapsed = Duration.zero,
    this.status = PracticeTimerStatus.idle,
    this.startedAt,
  });

  final PracticeType type;
  final Duration elapsed;
  final PracticeTimerStatus status;
  final DateTime? startedAt;

  bool get isRunning => status == PracticeTimerStatus.running;
  bool get canComplete => elapsed > Duration.zero;

  PracticeTimerState copyWith({
    PracticeType? type,
    Duration? elapsed,
    PracticeTimerStatus? status,
    DateTime? startedAt,
    bool clearStartedAt = false,
  }) {
    return PracticeTimerState(
      type: type ?? this.type,
      elapsed: elapsed ?? this.elapsed,
      status: status ?? this.status,
      startedAt: clearStartedAt ? null : startedAt ?? this.startedAt,
    );
  }
}

class PracticeTimerController extends StateNotifier<PracticeTimerState> {
  PracticeTimerController({DateTime Function()? now})
      : _now = now ?? DateTime.now,
        super(const PracticeTimerState());

  final DateTime Function() _now;
  Timer? _timer;
  DateTime? _runningSince;
  Duration _elapsedBeforeRun = Duration.zero;

  void selectType(PracticeType type) {
    if (state.status != PracticeTimerStatus.idle) return;
    state = state.copyWith(type: type);
  }

  void start() {
    if (state.isRunning) return;

    final currentTime = _now();
    _elapsedBeforeRun = state.elapsed;
    _runningSince = currentTime;

    state = state.copyWith(
      status: PracticeTimerStatus.running,
      startedAt: state.startedAt ?? currentTime,
    );

    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => refreshElapsed(),
    );
  }

  void refreshElapsed() {
    if (!state.isRunning || _runningSince == null) return;

    final activeDuration = _now().difference(_runningSince!);
    state = state.copyWith(elapsed: _elapsedBeforeRun + activeDuration);
  }

  void pause() {
    if (!state.isRunning) return;

    refreshElapsed();
    _timer?.cancel();
    _runningSince = null;
    _elapsedBeforeRun = state.elapsed;
    state = state.copyWith(status: PracticeTimerStatus.paused);
  }

  void markCompleted() {
    refreshElapsed();
    _timer?.cancel();
    _runningSince = null;
    state = state.copyWith(status: PracticeTimerStatus.completed);
  }

  void reset() {
    _timer?.cancel();
    _runningSince = null;
    _elapsedBeforeRun = Duration.zero;
    state = PracticeTimerState(type: state.type);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
