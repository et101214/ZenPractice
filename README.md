# ZenPractice（禪院修行）

結合禪修、功課、經書、成就、手抄經、AI 佛學助理、小沙彌養成與寺院經營的修行 App。

## 技術架構

- Flutter
- Riverpod
- GoRouter
- Drift / SQLite
- Supabase
- GitHub Actions

## 分支策略

- `main`：正式穩定版本
- `develop`：整合測試版本
- `feature/*`：功能開發分支

## 本機啟動

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
flutter run
```

Supabase 使用 compile-time environment 啟動：

```bash
flutter run \
  --dart-define=SUPABASE_URL=your-url \
  --dart-define=SUPABASE_ANON_KEY=your-anon-key
```

## MVP

1. 首頁
2. 修行
3. 功課
4. 經書
5. 成就

後續版本將加入手抄經、AI 法師、AI 解經、小沙彌養成與寺院經營。
