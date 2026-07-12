import 'dart:math' as math;

import 'package:flutter/material.dart';

class IosHomePage extends StatelessWidget {
  const IosHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final horizontalPadding = width < 360 ? 16.0 : 20.0;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                12,
                horizontalPadding,
                120,
              ),
              sliver: SliverList.list(
                children: [
                  _Header(theme: theme),
                  const SizedBox(height: 18),
                  const _ZenHeroCard(),
                  const SizedBox(height: 14),
                  const _DailyVerseCard(),
                  const SizedBox(height: 18),
                  Text('今日功課', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 10),
                  const _PracticeActions(),
                  const SizedBox(height: 18),
                  Text('修行足跡', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 10),
                  const _ProgressCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('禪院修行', style: theme.textTheme.headlineMedium),
              const SizedBox(height: 4),
              Text(
                '清晨安好，願今日心如止水',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        IconButton.filledTonal(
          onPressed: () {},
          tooltip: '修行提醒',
          icon: const Icon(Icons.notifications_none_rounded),
        ),
      ],
    );
  }
}

class _ZenHeroCard extends StatelessWidget {
  const _ZenHeroCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 270,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.12),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(painter: _ZenLandscapePainter()),
          Positioned(
            left: 22,
            right: 22,
            top: 20,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.72),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Text('第 15 日'),
                ),
                const Spacer(),
                Icon(
                  Icons.wb_sunny_outlined,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ],
            ),
          ),
          Positioned(
            left: 22,
            right: 22,
            bottom: 20,
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.82),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('今日修行', style: theme.textTheme.titleMedium),
                        const SizedBox(height: 4),
                        Text(
                          '42 / 60 分鐘',
                          style: theme.textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ),
                  FilledButton.tonalIcon(
                    onPressed: () {},
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: const Text('開始'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DailyVerseCard extends StatelessWidget {
  const _DailyVerseCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: theme.colorScheme.secondaryContainer,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.spa_outlined),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('今日一念', style: theme.textTheme.labelLarge),
                  const SizedBox(height: 6),
                  Text(
                    '心無所住，隨處自在。',
                    style: theme.textTheme.titleMedium?.copyWith(height: 1.45),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '把注意力帶回此刻的呼吸。',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PracticeActions extends StatelessWidget {
  const _PracticeActions();

  @override
  Widget build(BuildContext context) {
    const actions = [
      (Icons.self_improvement_rounded, '靜坐', '20 分鐘'),
      (Icons.menu_book_rounded, '誦經', '心經一遍'),
      (Icons.edit_note_rounded, '手抄經', '15 分鐘'),
    ];

    return Row(
      children: [
        for (var index = 0; index < actions.length; index++) ...[
          if (index > 0) const SizedBox(width: 10),
          Expanded(
            child: _ActionCard(
              icon: actions[index].$1,
              title: actions[index].$2,
              subtitle: actions[index].$3,
            ),
          ),
        ],
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          child: Column(
            children: [
              Icon(icon, size: 29, color: theme.colorScheme.primary),
              const SizedBox(height: 10),
              Text(title, maxLines: 1, style: theme.textTheme.titleSmall),
              const SizedBox(height: 3),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.local_fire_department_outlined),
                const SizedBox(width: 8),
                Text('連續修行 15 天', style: theme.textTheme.titleMedium),
                const Spacer(),
                Text(
                  '本週 5/7',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const LinearProgressIndicator(value: 5 / 7, minHeight: 8),
          ],
        ),
      ),
    );
  }
}

class _ZenLandscapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final background = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFE7EFE6), Color(0xFFF4E9D7)],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, background);

    final sun = Paint()..color = const Color(0xFFE4C68A).withValues(alpha: 0.72);
    canvas.drawCircle(Offset(size.width * 0.76, size.height * 0.25), 34, sun);

    _drawMountain(
      canvas,
      size,
      baseY: size.height * 0.61,
      peakX: size.width * 0.28,
      peakY: size.height * 0.19,
      color: const Color(0xFF9CAD98).withValues(alpha: 0.55),
    );
    _drawMountain(
      canvas,
      size,
      baseY: size.height * 0.7,
      peakX: size.width * 0.7,
      peakY: size.height * 0.3,
      color: const Color(0xFF73846E).withValues(alpha: 0.5),
    );

    final mist = Paint()
      ..color = Colors.white.withValues(alpha: 0.46)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round;
    final mistPath = Path()
      ..moveTo(-20, size.height * 0.55)
      ..quadraticBezierTo(
        size.width * 0.28,
        size.height * 0.46,
        size.width * 0.56,
        size.height * 0.55,
      )
      ..quadraticBezierTo(
        size.width * 0.8,
        size.height * 0.63,
        size.width + 20,
        size.height * 0.51,
      );
    canvas.drawPath(mistPath, mist);

    _drawTemple(canvas, size);
  }

  void _drawMountain(
    Canvas canvas,
    Size size, {
    required double baseY,
    required double peakX,
    required double peakY,
    required Color color,
  }) {
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(-20, baseY)
      ..quadraticBezierTo(peakX * 0.5, peakY * 1.25, peakX, peakY)
      ..quadraticBezierTo(
        peakX + size.width * 0.22,
        peakY * 1.2,
        size.width + 20,
        baseY,
      )
      ..lineTo(size.width + 20, size.height)
      ..lineTo(-20, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  void _drawTemple(Canvas canvas, Size size) {
    final center = Offset(size.width * 0.52, size.height * 0.51);
    final body = Paint()..color = const Color(0xFF584B3F).withValues(alpha: 0.88);
    final roof = Paint()..color = const Color(0xFF35443A).withValues(alpha: 0.95);

    canvas.drawRect(
      Rect.fromCenter(center: center, width: 42, height: 26),
      body,
    );

    final roofPath = Path()
      ..moveTo(center.dx - 34, center.dy - 12)
      ..quadraticBezierTo(center.dx, center.dy - 31, center.dx + 34, center.dy - 12)
      ..quadraticBezierTo(center.dx, center.dy - 20, center.dx - 34, center.dy - 12)
      ..close();
    canvas.drawPath(roofPath, roof);

    final bell = Paint()..color = const Color(0xFFB4945A);
    canvas.drawCircle(
      Offset(center.dx, center.dy + 5 + math.sin(0) * 2),
      3,
      bell,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
