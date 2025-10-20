# CLAUDE.md

このファイルは、Claude Code (claude.ai/code) がこのリポジトリで作業する際のガイダンスを提供します。

## 言語設定

**重要: このプロジェクトでは、すべての返答を日本語で行ってください。**

コミュニケーション、ドキュメント、コミットメッセージ、レビューコメントはすべて日本語で統一します。英語の引用やコマンドは必要最小限に留め、日本語による補足説明を必ず添えます。

## プロジェクト概要

SunriseTasksは、iOS、macOS、visionOSをサポートするSwiftUIベースのマルチプラットフォームアプリケーションです。Swift 6.0、Swift Concurrency、MainActor分離などの最新のSwift機能を使用しています。

### アプリ構成
- タブビューベースのナビゲーション
  - **タスクタブ**: タスク管理機能を提供
  - **設定タブ**: アプリケーション設定を管理

## ビルドコマンド

### プロジェクトを開く
```bash
# Xcodeでプロジェクトを開く
xed SunriseTasks.xcodeproj
```

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
  - `ContentView.swift` - ルートのSwiftUIビュー（TabViewを含む）
  - `TasksView.swift` - タスク一覧を表示するビュー
  - `SettingsView.swift` - 設定画面のビュー
  - `Assets.xcassets/` - 画像とカラーのアセットカタログ
  - `Features/<機能名>/` - 将来的な機能追加はこのディレクトリ構成で
- `SunriseTasksTests/` - Swift Testingフレームワークを使用したユニットテスト
- `SunriseTasksUITests/` - XCTestを使用したUIテスト
- `SunriseTasks.xcodeproj/` - Xcode設定
- `CLAUDE.md` - このファイル。プロジェクトガイダンス
- `AGENTS.md` - AI開発エージェント向けのドキュメント

## 技術的な設定

### デプロイメントターゲット
- iOS: 26.0
- macOS: 15.6
- visionOS: 26.0

**注意**: これらは2025年時点でのベータ版バージョンです。Xcode 16.0.1以降が必要です。

### Swift設定
- Swiftバージョン: 5.0
- Swift 6の言語機能を使用:
  - `SWIFT_APPROACHABLE_CONCURRENCY = YES`
  - `SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor`
  - `SWIFT_UPCOMING_FEATURE_MEMBER_IMPORT_VISIBILITY = YES`

### テストフレームワーク
このプロジェクトは、ユニットテストにSwift Testing（XCTestではない）を使用しています。テストは`@Test`属性でマークされ、アサーションには`#expect(...)`を使用します。

### サンドボックス
アプリサンドボックスが有効で、ユーザーが選択したファイルへの読み取り専用アクセスが許可されています（`ENABLE_USER_SELECTED_FILES = readonly`）。ファイルアクセス処理では適切な権限確認を行ってください。

## コーディングスタイルと命名規約

- Swift API Design Guidelinesに従う
- インデント: スペース4個
- 型: UpperCamelCase
- 関数・変数・`@Test`メソッド: lowerCamelCase
- 非同期処理: Swift Concurrency（`async`/`await`、`Task`、`@MainActor`）を使用
- 副作用を持つUI更新コードには明示的なアクター属性を付与
- SwiftUIビューは概ね200行以内で保つ
- 共通ロジックはExtensionやヘルパーに抽出
- ローカライズ: 文字列カタログまたは`NSLocalizedString`を使用

## テスト指針

- ユニットテスト: Swift Testingフレームワークを使用
- `@Test`属性と`#expect(...)`アサーションで記述
- テストファイルは対象機能名に合わせる
- 共通セットアップは`@Suite`やヘルパー型で再利用
- UIテスト: XCTestを使用し、主要フローごとにケースを追加
- シミュレータのリセット: `xcrun simctl erase <device>`
- 新機能では最低1本のSwift Testingテストを追加
- ユーザー体験に影響する変更にはUIテストも更新

## Git管理

### ブランチ戦略
- `main` - メインブランチ（安定版）
- 機能追加やバグ修正は適切な名前のfeatureブランチで作業

### リモートリポジトリ
このプロジェクトのリモートリポジトリ設定を確認するには:
```bash
git remote -v
```

## 開発サイクル

1. 作業開始前に`main`を最新化
2. ブランチを機能単位で分岐（例: `feature/task-edit`, `fix/navigation-bug`）
3. 実装後は`xcodebuild test ...`でローカル検証
4. 必要に応じてスクリーンショットや動画を録画
5. レビュー指摘は追加コミットまたは`fixup`で対応し、`rebase`で整理
6. マージ後は不要なブランチを削除

## コミットとプルリクエスト

### コミットメッセージ
- 件名: 命令形・現在形（例: `タスク詳細画面を追加`）
- 関連チケット: `[#123]`形式で参照
- 本文: 意図、実装ポイント、副作用、検証結果を日本語で記述

### プルリクエスト
- 概要、変更点、影響範囲、テスト結果を明記
- UI変更時はスクリーンショットや動画を添付
- レビュー依頼や回答は迅速に行う
- すべてのテストが成功していることを確認してからマージ

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
