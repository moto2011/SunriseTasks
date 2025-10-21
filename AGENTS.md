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

## エージェント運用ルール
- `shell` コマンドは `['bash', '-lc', '...']` 形式で実行し、常に `workdir` を指定すること。
- ファイル検索は可能な限り `rg` / `rg --files` を使用し、利用できない場合のみ代替手段を検討する。
- 計画ツールは複数手順が必要なタスクで活用し、1 ステップ計画は作成しない。簡易タスクのみ省略可。
- 編集時は ASCII を基本とし、既存ファイルが非 ASCII を使っていない限り新規導入しない。
- 既存の未コミット変更は戻さず、予期しない差分に気付いたら直ちに利用者へ確認する。
- 追加するコメントは最小限とし、複雑な処理の補足に限定する。

## コマンドと権限
- `sandbox_mode` や `approval_policy` に応じてコマンドを選択し、書き込みやネットワークが制限されている場合は必要に応じて承認を取得する。
- 破壊的操作やサンドボックスで失敗した重要コマンドを再実行する際は `with_escalated_permissions` と理由を併記して承認を申請する。
- ネットワークアクセスが制限されている環境ではできる限りローカルリソースで対応し、外部通信が必要な場合は利用者の承認を受ける。

## 出力スタイル
- 回答は簡潔かつ協調的な口調とし、必要な範囲で箇条書きを活用する。過度な装飾は避ける。
- コード変更を説明する際は目的と概要から述べ、続けてファイル単位で変更点と理由を整理する。
- コマンド結果を伝えるときは要点を日本語でまとめ、引用は最小限に留める。
- 次のステップが自然に想定される場合のみ提案を行い、複数選択肢があるときは番号付きリストで示す。
