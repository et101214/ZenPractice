# ZenPractice iOS-first 開發規範

## 產品方向

ZenPractice 以 iPhone App 為第一優先平台。Windows 與 Web 僅用於快速預覽，不作為主要產品體驗標準。

## 第一階段支援

- iPhone 直式介面
- iOS Safe Area 與底部 Home Indicator
- iPhone 15／16 尺寸作為主要設計基準
- Material 3 共用元件，但互動與間距以 iOS 使用感受調整
- iOS Simulator 可編譯
- 後續接入實體 iPhone 與 TestFlight

## 預設識別

- App 名稱：ZenPractice 禪院修行
- Bundle ID：`com.zenpractice.zenPractice`
- 版本：`0.1.0+1`
- 最低 iOS 版本：先依 Flutter stable 預設，正式上架前再鎖定

## Demo v0.1 驗收

1. 首頁、修行、經文、AI、我的五個分頁可切換。
2. 修行計時器可開始、暫停、完成並寫入本地資料。
3. iOS Simulator Debug Build 成功。
4. UI 在窄版 iPhone 螢幕不溢位。
5. GitHub Actions 通過 Analyze、Test 與 iOS Simulator Build。

## 發布路線

1. iOS Simulator Demo
2. 實體 iPhone Development Build
3. App Icon、Launch Screen、權限文案
4. Apple Developer 簽章
5. TestFlight Internal Testing
6. App Store 上架準備
