# Repository Guidelines

## 言語ポリシー
このリポジトリでのコミュニケーション、ドキュメント、コミットメッセージ、レビューコメントはすべて日本語で行います。生成エージェントも含め、回答は日本語で統一してください。英語の引用やコマンドは必要最小限に留め、日本語による補足説明を必ず添えます。

## プロジェクト構成とモジュール整理
SunriseTasks は SwiftUI ベースのマルチプラットフォームアプリで、iOS / macOS / visionOS をサポートします。アプリ本体は `SunriseTasks/` に配置され、`SunriseTasksApp.swift` がエントリーポイント、`ContentView.swift` が共通ルートビューです。画像とカラーは `SunriseTasks/Assets.xcassets/` にまとめ、将来的な機能は `SunriseTasks/Features/<機能名>/` へ追加します。ユニットテストは `SunriseTasksTests/`、UI テストは `SunriseTasksUITests/` に置き、Xcode 設定は `SunriseTasks.xcodeproj/` で管理します。

## プラットフォームとビルド設定
デプロイメントターゲットは iOS 26、macOS 15.6、visionOS 26 です。Swift 5 をベースにしつつ Swift 6 の近代機能（MainActor 分離、Approachable Concurrency、Member Import Visibility）を有効化しています。自動コード署名を使用し、SwiftUI プレビューは `#Preview` マクロで有効です。アプリサンドボックスはユーザー選択ファイル読み取り専用で構成されているため、ファイルアクセス処理では適切な権限確認を行ってください。

## ビルド・テスト・開発コマンド
- `xed SunriseTasks.xcodeproj` : プロジェクトを Xcode で開く
- `xcodebuild -project SunriseTasks.xcodeproj -scheme SunriseTasks -destination 'platform=iOS Simulator,name=iPhone 15' build` : iOS 向けビルド
- `xcodebuild -project SunriseTasks.xcodeproj -scheme SunriseTasks -destination 'platform=macOS' build` : macOS 向けビルド
- `xcodebuild -project SunriseTasks.xcodeproj -scheme SunriseTasks -destination 'platform=visionOS Simulator,name=Apple Vision Pro' build` : visionOS 向けビルド
- `xcodebuild test -project SunriseTasks.xcodeproj -scheme SunriseTasks -destination 'platform=iOS Simulator,name=iPhone 15'` : すべてのテストを実行
- `xcodebuild test -project SunriseTasks.xcodeproj -scheme SunriseTasks -destination 'platform=iOS Simulator,name=iPhone 15' -only-testing:SunriseTasksUITests` : UI テストのみ実行

## コーディングスタイルと命名規約
Swift API Design Guidelines に従い、インデントはスペース 4 個を使用します。型は UpperCamelCase、関数や変数、`@Test` メソッドは lowerCamelCase で統一します。非同期処理は Swift Concurrency（`async` / `await`、`Task`、`@MainActor`）を採用し、副作用を持つ UI 更新コードには明示的なアクター属性を付与します。SwiftUI ビューは概ね 200 行以内で保ち、共通ロジックは Extension やヘルパーに抽出します。ローカライズは文字列カタログまたは `NSLocalizedString` を使用し、翻訳差分が発生した場合は Assets フォルダに変更を反映します。

## テスト指針
ユニットテストは Swift Testing フレームワークを使用し、`@Test` 属性と `#expect(...)` アサーションで記述します。テストファイルは対象機能名に合わせ、共通セットアップは `@Suite` やヘルパー型で再利用可能に設計します。UI テストは XCTest を利用し、主要フローごとにケースを追加してください。シミュレータの状態は `xcrun simctl erase <device>` でリセットし、ネットワークやデータ保存の副作用が残らないようにします。新機能では最低 1 本の Swift Testing テストを追加し、ユーザー体験に影響する変更には UI テストも更新してください。

## 開発サイクル
作業開始前に `main` を最新化し、ブランチを機能単位で分岐させます。実装後は `xcodebuild test ...` でローカル検証し、必要ならばスクリーンショットや動画を録画しておきます。レビューで指摘された箇所はコミットを追加するか、`fixup` で再コミットしてから `rebase` で整理します。マージ後は不要なブランチを削除し、次のタスクでも日本語ガイドラインを継続してください。

## コミットとプルリクエスト
コミットは小さく保ち、件名は命令形・現在形（例: `タスク詳細画面を追加`）で書きます。関連チケットは `[#123]` 形式で参照し、本文では意図、実装ポイント、副作用、検証結果を日本語で記述します。プルリクエストでは概要、変更点、影響範囲、テスト結果（`xcodebuild test`、simulator 手動検証など）を明記し、UI 変更時はスクリーンショットや動画を添付してください。レビュー依頼や回答は迅速に行い、すべてのテストが成功していることを確認してからマージします。
