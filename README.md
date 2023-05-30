# GanchanNet
iOS版がんちゃんねるの大幅アップデート(by ixtutixi)

カンパニーリポジトリをpublicにするのはアレなので、個人開発の記録としてここにuploadする。(全部自分のコードなので多分大丈夫)

## 概要
・SwiftUI+Combine

・iOS16.0以上を対象

## 内容
- 各jsonから得たニュースをList表示(タップで対象ブラウザへモーダル遷移)
  - 取得jsonはPHPによる対象URLのスクレイピング     

- サーバー側で変更可能な広告の差し込み

- Tabが上下に1個ずつ欲しいため、両方カスタムタブバーを自作

- Combine,async-imageで非同期処理
  - [ached-async-image](https://github.com/lorenzofiamingo/swiftui-cached-async-image)<-(画像キャッシュのためのライブラリ)
      

## 画面スクショ
<img width="300" alt="スクリーンショット 2023-05-30 19 44 23" src="https://github.com/ixtutixi/GanchanNet/assets/57790443/98d468e8-01ae-4e0c-9c91-5f6ccddc684e">
<img width="301" alt="スクリーンショット 2023-05-30 19 44 58" src="https://github.com/ixtutixi/GanchanNet/assets/57790443/2ec91243-a8dd-499c-8209-70a10aa0868a">

## その他
- 就活情報と学内・学外掲示板は、現在絶賛 外部組織とのmeeting & バックエンド開発中
