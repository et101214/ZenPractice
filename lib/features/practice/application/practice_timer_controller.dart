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
  PracticeTimerController() : super(const PracticeTimerState());

  Timer? _timer;

  void selectType(PracticeType type) {
    if (state.status != PracticeTimerStatus.idle) return;
    state = state.copyWith(type: type);
  }

  void start() {
    if (state.isRunning) return;
    final startedAt = state.startedAt ?? DateTime.now();
    state = state.copyWith(
      status: PracticeTimerStatus.running,
      startedAt: startedAt,
    );
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      state = state.copyWith(
        elapsed: state.elapsed + const Duration(seconds: 1),
      );
    });
  }

  void pause() {
    if (!state.isRunning) return;
    _timer?.cancel();
    state = state.copyWith(status: PracticeTimerStatus.paused);
  }

  void markCompleted() {
    _timer?.cancel();
    state = state.copyWith(status: PracticeTimerStatus.completed);
  }

  void reset() {
    _timer?.cancel();
    state = PracticeTimerState(type: state.type);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
