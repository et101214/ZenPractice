import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/home',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => _AppShell(shell: shell),
        branches: [
          _branch('/home', '首頁', Icons.home_outlined),
          _branch('/practice', '修行', Icons.self_improvement_outlined),
          _branch('/tasks', '功課', Icons.checklist_outlined),
          _branch('/scriptures', '經書', Icons.menu_book_outlined),
          _branch('/achievements', '成就', Icons.emoji_events_outlined),
        ],
      ),
    ],
  );
});

StatefulShellBranch _branch(String path, String title, IconData icon) {
  return StatefulShellBranch(
    routes: [
      GoRoute(
        path: path,
        builder: (context, state) => _PlaceholderPage(
          title: title,
          icon: icon,
        ),
      ),
    ],
  );
}

class _AppShell extends StatelessWidget {
  const _AppShell({required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    const destinations = [
      NavigationDestination(
        icon: Icon(Icons.home_outlined),
        label: '首頁',
      ),
      NavigationDestination(
        icon: Icon(Icons.self_improvement_outlined),
        label: '修行',
      ),
      NavigationDestination(
        icon: Icon(Icons.checklist_outlined),
        label: '功課',
      ),
      NavigationDestination(
        icon: Icon(Icons.menu_book_outlined),
        label: '經書',
      ),
      NavigationDestination(
        icon: Icon(Icons.emoji_events_outlined),
        label: '成就',
      ),
    ];

    return Scaffold(
      body: shell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex,
        destinations: destinations,
        onDestinationSelected: (index) => shell.goBranch(
          index,
          initialLocation: index == shell.currentIndex,
        ),
      ),
    );
  }
}

class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 56),
                const SizedBox(height: 16),
                Text(title, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                const Text('ZenPractice MVP 功能建置中'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
