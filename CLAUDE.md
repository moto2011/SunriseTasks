# CLAUDE.md

このファイルは、Claude Code (claude.ai/code) がこのリポジトリで作業する際のガイダンスを提供します。

## 言語設定

**重要: このプロジェクトでは、すべての返答を日本語で行ってください。**

## プロジェクト概要

SunriseTasksは、iOS、macOS、visionOSをサポートするSwiftUIベースのマルチプラットフォームアプリケーションです。Swift 6.0、Swift Concurrency、MainActor分離などの最新のSwift機能を使用しています。

## ビルドコマンド

### プロジェクトのビルド
```bash
# 注意: フルバージョンのXcodeが必要です（Command Line Toolsのみでは不可）
xcodebuild -project SunriseTasks.xcodeproj -scheme SunriseTasks -configuration Debug build
```

### テストの実行
```bash
# ユニットテストの実行
xcodebuild test -project SunriseTasks.xcodeproj -scheme SunriseTasks -destination 'platform=iOS Simulator,name=iPhone 15'

# UIテストの実行
xcodebuild test -project SunriseTasks.xcodeproj -scheme SunriseTasks -destination 'platform=iOS Simulator,name=iPhone 15' -only-testing:SunriseTasksUITests
```

### 特定プラットフォームでの実行
```bash
# iOS Simulator
xcodebuild -project SunriseTasks.xcodeproj -scheme SunriseTasks -destination 'platform=iOS Simulator,name=iPhone 15' build

# macOS
xcodebuild -project SunriseTasks.xcodeproj -scheme SunriseTasks -destination 'platform=macOS' build

# visionOS Simulator
xcodebuild -project SunriseTasks.xcodeproj -scheme SunriseTasks -destination 'platform=visionOS Simulator,name=Apple Vision Pro' build
```

## プロジェクト構成

- `SunriseTasks/` - メインアプリケーションコード
  - `SunriseTasksApp.swift` - @main属性を持つアプリのエントリーポイント
  - `ContentView.swift` - ルートのSwiftUIビュー
  - `Assets.xcassets/` - 画像とカラーのアセットカタログ
- `SunriseTasksTests/` - Swift Testingフレームワークを使用したユニットテスト
- `SunriseTasksUITests/` - XCTestを使用したUIテスト

## 技術的な設定

### デプロイメントターゲット
- iOS: 26.0
- macOS: 15.6
- visionOS: 26.0

### Swift設定
- Swiftバージョン: 5.0
- Swift 6の言語機能を使用:
  - `SWIFT_APPROACHABLE_CONCURRENCY = YES`
  - `SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor`
  - `SWIFT_UPCOMING_FEATURE_MEMBER_IMPORT_VISIBILITY = YES`

### テストフレームワーク
このプロジェクトは、ユニットテストにSwift Testing（XCTestではない）を使用しています。テストは`@Test`属性でマークされ、アサーションには`#expect(...)`を使用します。

### サンドボックス
アプリサンドボックスが有効で、ユーザーが選択したファイルへの読み取り専用アクセスが許可されています（`ENABLE_USER_SELECTED_FILES = readonly`）。

## 開発に関する注意事項

### プレビュー
SwiftUIプレビューが有効です。ビュープレビューには`#Preview`マクロを使用してください。

### コード署名
自動コード署名が設定されています（`CODE_SIGN_STYLE = Automatic`）。

### 文字列カタログ
プロジェクトはローカライゼーションに文字列カタログを使用しています（`LOCALIZATION_PREFERS_STRING_CATALOGS = YES`）。

### ビルドシステム
- 並列ビルド実行を使用（`BuildIndependentTargetsInParallel = 1`）
- ユーザースクリプトサンドボックスが有効
