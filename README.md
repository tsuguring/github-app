<h1 align="center"> github-app </h1> <br>

<div align="center">
  <img src="https://github.com/tsuguring/github-app/assets/52564598/da54b4e4-6c7e-420c-81fe-5373f20bf604" alt="Simulator Screen Recording" width="300">
</div>

## 目次

- [概要](#概要)
- [アーキテクチャ](#アーキテクチャ)
- [モジュール分割](#モジュール分割)
- [コーディングルール](#コーディングルール)

## 概要
キーワードを入力してGitHubのリポジトリを検索、詳細表示できるiOSアプリ

| 検索画面 | 検索中 | 通信失敗画面 | リポジトリ一覧 | リポジトリ詳細 |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| <img width="200" src="https://github.com/tsuguring/github-app/assets/52564598/f77d4c27-5fc5-415a-8e1f-8ac107c542e0"> | <img width="200" src="https://github.com/tsuguring/github-app/assets/52564598/ecc2027b-e297-4a4a-a453-6d45fa11f0e0"> | <img width="200" src="https://github.com/tsuguring/github-app/assets/52564598/598ad889-bd22-4abd-84f7-257860b0d929"> | <img width="200" src="https://github.com/tsuguring/github-app/assets/52564598/c0a5bda4-e6a0-48b7-87ee-54fe40951f62"> | <img width="200" src="https://github.com/tsuguring/github-app/assets/52564598/6a2d2db0-bb25-4508-89c2-63ab5eaeda7d"> |

</details>

### 使用技術

- Swift
- SwiftUI
- SwiftPM
- Combine
- Swift Concurrency
- WebKit

### 必須条件

- macOS 13.5+
- Xcode 15.0 (Swift 5.9)
- make

### セットアップ

1. github-app をクローン
   ```shell
   $ git clone https://github.com/tsuguring/github-app.git
   $ cd github-app
   ```
2. `make setup` を実行

## アーキテクチャ

- MVVM+Layerd Architecture

<img width="1300" alt="architecture" src="https://github.com/tsuguring/github-app/assets/52564598/055bea55-e1c9-4247-bdc0-4c78c0f61ada">


## モジュール分割

<img width="1300" alt="modularization" src="https://github.com/tsuguring/github-app/assets/52564598/1fff41ae-ec72-4296-85ce-600ecba42a68">

## コーディングルール

[API Design Guidelines](https://www.swift.org/documentation/api-design-guidelines/)
