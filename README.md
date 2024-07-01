<h1 align="center"> github-app </h1> <br>

<div align="center">
  <img src="https://github.com/tsuguring/github-app/assets/52564598/da54b4e4-6c7e-420c-81fe-5373f20bf604" alt="Simulator Screen Recording" width="300">
</div>

## 目次

- [概要](#概要)
- [モジュール分割](#モジュール分割)
- [アーキテクチャ](#アーキテクチャ)
- [コーディングルール](#コーディングルール)

## 概要
キーワードを入力してGitHubのリポジトリを検索、詳細表示できるiOSアプリ

| 検索画面 | 検索中 | 通信失敗画面 | リポジトリ一覧 | リポジトリ詳細 |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| <img width="200" src="https://github.com/tsuguring/github-app/assets/52564598/f77d4c27-5fc5-415a-8e1f-8ac107c542e0"> | <img width="200" src="https://github.com/tsuguring/github-app/assets/52564598/ecc2027b-e297-4a4a-a453-6d45fa11f0e0"> | <img width="200" src="https://github.com/tsuguring/github-app/assets/52564598/598ad889-bd22-4abd-84f7-257860b0d929"> | <img width="200" src="https://github.com/tsuguring/github-app/assets/52564598/c0a5bda4-e6a0-48b7-87ee-54fe40951f62"> | <img width="200" src="https://github.com/tsuguring/github-app/assets/52564598/6a2d2db0-bb25-4508-89c2-63ab5eaeda7d"> |

### 使用技術

- Swift
- SwiftUI
- SwiftPM
- Combine
- Swift Concurrency
- WebKit
- XCTest

### 必須条件

- macOS 13.5+
- Xcode 15.0 (Swift 5.9)

### セットアップ

1. github-app をクローン
   ```shell
   $ git clone https://github.com/tsuguring/github-app.git
   $ cd github-app
   ```
2. Xcodeで GitHubApp.xcworkspace　を開く
   ```shell
   $ xed GitHubApp.xcworkspace
   ```

## モジュール分割

<img width="1300" alt="modularization" src="https://github.com/tsuguring/github-app/assets/52564598/7e5bd160-15c8-44c3-9c91-9f14ed50cf4e">

### Appモジュール
- **役割**: アプリケーションのエントリポイントとして機能し、全体的なナビゲーションと設定を管理。
- **依存関係**: Featureモジュールに依存。

### Featureモジュール
- **役割**: 特定の機能をカプセル化し、それに対応するUIとViewModelを提供。
- **重要性**: 各機能を独立して開発およびテストするため、モジュール化が重要。
- **依存関係**: データモジュールに依存。

### Dataモジュール
- **役割**: アプリケーションのデータ管理を担当し、リポジトリ、モデルクラスを提供。
- **重要性**: データの一貫性とセキュリティを確保するために重要。
- **依存関係**: リポジトリがAPIClientを用いてデータを取得するため、Coreモジュール(NetworkCore)に依存。

### Coreモジュール
- **役割**: アプリケーション全体で共通して使用されるコードを提供し、カスタムUI要素、ネットワーククライアントなどが含まれる。
- **重要性**: アプリの一貫性と効率性を保つために不可欠。
- **依存関係**: すべてのモジュールに依存。

### 参考
[Android モジュール化](https://developer.android.com/topic/modularization/patterns?hl=ja&_gl=1*v48wl3*_up*MQ..*_ga*MTg1MTg0MDgzNy4xNzE5ODQyOTE3*_ga_6HH9YJMN9M*MTcxOTg0MjkxNi4xLjAuMTcxOTg0MjkxNi4wLjAuMA..#types-of-modules)

## アーキテクチャ

- MVVM+Layerd Architecture

<img width="1300" alt="architecture" src="https://github.com/tsuguring/github-app/assets/52564598/344b5dd2-737f-4dd1-b876-3aee446ce69a">

### MVVM
#### View
- 画面表示を担当。ユーザーインターフェースを構築し、ユーザーからの入力を受け取る。
- ViewModelとの通信を通じてデータを表示する。
- SwiftUIで実装。

#### ViewModel
- ViewとModelの間の橋渡し役。
- ユーザー操作に応じたビジネスロジックを処理し、Viewに表示するデータを準備。
- 画面状態の管理を行い、Viewに対してバインディング(Combine)を通じてデータの変化を通知。

#### Model
- アプリケーションのデータやビジネスロジックを管理。
- データの取得、更新などを行う。
- API通信でネットワークからデータ取得。

### Layered Architecture
#### UILayer
以下の2つの要素を持つ。
- 画面にデータを表示する要素。SwiftUIを用いてViewModelが持つ画面の状態(UiState)を画面に表示。
- 画面状態の管理 および ユーザー操作に対してのロジック処理 を行う要素。ViewModelでそれらを行う。

#### DataLayer
- 主にアプリデータやビジネスロジックが含まれている。データモデルの定義やネットワークリクエストなどの要素を持つ。

#### 参考
- [Android アーキテクチャ ガイド](https://developer.android.com/topic/architecture?hl=ja&_gl=1*9nqjrw*_up*MQ..*_ga*NjUxMjk3MzY1LjE3MTk4NDI3NDU.*_ga_6HH9YJMN9M*MTcxOTg0Mjc0NS4xLjAuMTcxOTg0Mjc0NS4wLjAuMA..#recommended-app-arch)

## コーディングルール

[API Design Guidelines](https://www.swift.org/documentation/api-design-guidelines/)
