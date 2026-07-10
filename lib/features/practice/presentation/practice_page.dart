import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zen_practice/features/practice/application/practice_providers.dart';
import 'package:zen_practice/features/practice/application/practice_timer_controller.dart';
import 'package:zen_practice/features/practice/domain/entities/practice_type.dart';

class PracticePage extends ConsumerStatefulWidget {
  const PracticePage({super.key});

  @override
  ConsumerState<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends ConsumerState<PracticePage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.read(practiceTimerProvider.notifier).refreshElapsed();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timer = ref.watch(practiceTimerProvider);
    final todayTotal = ref.watch(todayPracticeTotalProvider);
    final recent = ref.watch(recentPracticeSessionsProvider);
    final saving = ref.watch(practiceSaveControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('修行')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('今日累積', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            todayTotal.when(
              data: _formatDuration,
              loading: () => '--:--:--',
              error: (_, __) => '讀取失敗',
            ),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final type in PracticeType.values)
                ChoiceChip(
                  label: Text(type.label),
                  selected: timer.type == type,
                  onSelected: timer.status == PracticeTimerStatus.idle
                      ? (_) => ref
                          .read(practiceTimerProvider.notifier)
                          .selectType(type)
                      : null,
                ),
            ],
          ),
          const SizedBox(height: 32),
          Center(
            child: Text(
              _formatDuration(timer.elapsed),
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton.icon(
                onPressed: timer.isRunning
                    ? () => ref.read(practiceTimerProvider.notifier).pause()
                    : () => ref.read(practiceTimerProvider.notifier).start(),
                icon: Icon(timer.isRunning ? Icons.pause : Icons.play_arrow),
                label: Text(timer.isRunning ? '暫停' : '開始'),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: timer.canComplete && !saving.isLoading
                    ? () => ref
                        .read(practiceSaveControllerProvider.notifier)
                        .completeCurrentSession()
                    : null,
                icon: const Icon(Icons.check),
                label: Text(saving.isLoading ? '儲存中' : '完成'),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Text('最近修行', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          recent.when(
            data: (sessions) {
              if (sessions.isEmpty) {
                return const Text('尚無修行紀錄');
              }
              return Column(
                children: [
                  for (final session in sessions.take(10))
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.self_improvement),
                      title: Text(session.type.label),
                      subtitle: Text(_formatDate(session.completedAt)),
                      trailing: Text(_formatDuration(session.duration)),
                    ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => const Text('讀取紀錄失敗'),
          ),
        ],
      ),
    );
  }

  static String _formatDuration(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  static String _formatDate(DateTime value) {
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '${value.year}/$month/$day $hour:$minute';
  }
}
