<h1 align="center"> github-app </h1> <br>

## 目次

- [概要](#概要)
- [アーキテクチャ](#アーキテクチャ)
- [モジュール分割](#モジュール分割)
- [コーディングルール](#コーディングルール)
- [パッケージ管理](#パッケージ管理)

## 概要

<details><summary>スクリーンショット</summary>
</details>

### 使用技術

- Swift
- SwiftUI
- SwiftPM
- Combine
- Swift Concurrency

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

## モジュール分割

<img src="https://github.com/tsuguring/github-app/assets/52564598/ca7ec1fc-de8f-49b8-86d8-94aa3c462fce" width=1300>


## コーディングルール

[API Design Guidelines](https://www.swift.org/documentation/api-design-guidelines/)
