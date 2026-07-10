import 'package:flutter/material.dart';

class HomeDemoPage extends StatelessWidget {
  const HomeDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          children: [
            Text('禪院修行', style: theme.textTheme.headlineMedium),
            const SizedBox(height: 6),
            Text(
              '願日日精進，念念清明',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            _HeroPracticeCard(theme: theme),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _MetricCard(
                    icon: Icons.local_fire_department_outlined,
                    value: '15 天',
                    label: '連續修行',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _MetricCard(
                    icon: Icons.schedule_outlined,
                    value: '42 分',
                    label: '今日累積',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text('今日建議', style: theme.textTheme.titleLarge),
            const SizedBox(height: 12),
            const _SuggestionTile(
              icon: Icons.self_improvement,
              title: '靜坐 20 分鐘',
              subtitle: '讓呼吸慢下來，回到當下',
            ),
            const _SuggestionTile(
              icon: Icons.menu_book_outlined,
              title: '誦讀心經 1 遍',
              subtitle: '以清明之心開始今日功課',
            ),
            const _SuggestionTile(
              icon: Icons.edit_note_outlined,
              title: '抄經 15 分鐘',
              subtitle: '一筆一畫，安住身心',
            ),
            const SizedBox(height: 24),
            Text('最近修行', style: theme.textTheme.titleLarge),
            const SizedBox(height: 12),
            const _RecentPracticeCard(),
          ],
        ),
      ),
    );
  }
}

class ScripturesDemoPage extends StatelessWidget {
  const ScripturesDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const scriptures = [
      ('心經', '260 字・約 5 分鐘', Icons.favorite_outline),
      ('金剛經', '般若智慧・約 45 分鐘', Icons.auto_stories_outlined),
      ('阿彌陀經', '淨土法門・約 25 分鐘', Icons.spa_outlined),
      ('地藏經', '孝親報恩・分卷閱讀', Icons.volunteer_activism_outlined),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('經文')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          Text('選一部經，安住片刻', style: theme.textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            '閱讀、誦持與手抄功能將逐步開放。',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 20),
          for (final scripture in scriptures)
            Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                contentPadding: const EdgeInsets.all(18),
                leading: CircleAvatar(child: Icon(scripture.$3)),
                title: Text(scripture.$1),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(scripture.$2),
                ),
                trailing: const Icon(Icons.chevron_right),
              ),
            ),
        ],
      ),
    );
  }
}

class AiDemoPage extends StatelessWidget {
  const AiDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('AI 佛學助理')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Spacer(),
            Container(
              width: 112,
              height: 112,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.brightness_7_outlined,
                size: 56,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 24),
            Text('今天想修什麼？', style: theme.textTheme.headlineSmall),
            const SizedBox(height: 10),
            Text(
              '可詢問修行安排、佛學名相與經文入門。\nDemo 階段先展示對話入口。',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 28),
            TextField(
              enabled: false,
              decoration: InputDecoration(
                hintText: '例如：今晚適合做什麼修行？',
                filled: true,
                suffixIcon: const Icon(Icons.send_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

class ProfileDemoPage extends StatelessWidget {
  const ProfileDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('我的修行')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: theme.colorScheme.primaryContainer,
                    child: const Icon(Icons.person_outline, size: 34),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('修行者', style: theme.textTheme.titleLarge),
                        const SizedBox(height: 4),
                        Text(
                          '願心清淨，日日精進',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: const [
              Expanded(
                child: _MetricCard(
                  icon: Icons.calendar_month_outlined,
                  value: '36 天',
                  label: '累積天數',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _MetricCard(
                  icon: Icons.timelapse_outlined,
                  value: '18.5 小時',
                  label: '總修行時間',
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text('設定', style: theme.textTheme.titleLarge),
          const SizedBox(height: 12),
          const Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.notifications_none),
                  title: Text('修行提醒'),
                  trailing: Icon(Icons.chevron_right),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.cloud_outlined),
                  title: Text('雲端同步'),
                  subtitle: Text('Demo 階段尚未啟用'),
                  trailing: Icon(Icons.chevron_right),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text('關於 ZenPractice'),
                  trailing: Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroPracticeCard extends StatelessWidget {
  const _HeroPracticeCard({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primaryContainer,
            theme.colorScheme.secondaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('今日修行', style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          Text('42 / 60 分鐘', style: theme.textTheme.headlineMedium),
          const SizedBox(height: 18),
          const LinearProgressIndicator(value: 0.7, minHeight: 8),
          const SizedBox(height: 22),
          FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.play_arrow),
            label: const Text('開始修行'),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon),
            const SizedBox(height: 14),
            Text(value, style: theme.textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(label, style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class _SuggestionTile extends StatelessWidget {
  const _SuggestionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        leading: CircleAvatar(child: Icon(icon)),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

class _RecentPracticeCard extends StatelessWidget {
  const _RecentPracticeCard();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.self_improvement),
            title: Text('坐禪'),
            subtitle: Text('今天 07:30'),
            trailing: Text('30 分'),
          ),
          Divider(height: 1),
          ListTile(
            leading: Icon(Icons.menu_book_outlined),
            title: Text('誦讀心經'),
            subtitle: Text('昨天 21:10'),
            trailing: Text('1 遍'),
          ),
          Divider(height: 1),
          ListTile(
            leading: Icon(Icons.edit_note_outlined),
            title: Text('抄經'),
            subtitle: Text('昨天 20:35'),
            trailing: Text('15 分'),
          ),
        ],
      ),
    );
  }
}
