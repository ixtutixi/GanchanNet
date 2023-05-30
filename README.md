# GanchanNet
iOS版がんちゃんねるの大幅アップデート(by ixtutixi)

カンパニーリポジトリをpublicにするのはアレなので、個人開発の記録としてここにuploadする。(全部自分のコードなので多分大丈夫)

## 概要
・SwiftUI+Combine

・iOS16.0以上を対象

## 内容
- News(公式HP,生協,国際課), 生協バイト, 就活情報, 学内・学外掲示板

- 各jsonから得たニュースをList表示(タップで対象ブラウザへモーダル遷移)
  - [取得jsonはPHPによる対象URLのスクレイピング](https://github.com/ixtutixi/Ganchan_PHP)
  - Homeでは(公式HP,生協,国際課)の中の最新10件をRecentry Newsとして絞り込み表示

- サーバー側で変更可能な広告の差し込み

- Tabが上下に1個ずつ欲しいため、両方カスタムタブバーを自作

- Combine,async-imageで非同期処理
  - [ios-ached-async-image](https://github.com/lorenzofiamingo/swiftui-cached-async-image)<-(画像キャッシュのためのライブラリ)
      

## 画面スクショ
<img width="200" alt="スクリーンショット 2023-05-30 19 44 23" src="https://github.com/ixtutixi/GanchanNet/assets/57790443/98d468e8-01ae-4e0c-9c91-5f6ccddc684e">
<img width="200" alt="スクリーンショット 2023-05-30 19 44 58" src="https://github.com/ixtutixi/GanchanNet/assets/57790443/2ec91243-a8dd-499c-8209-70a10aa0868a">
<img width="200" alt="スクリーンショット 2023-05-30 19 56 42" src="https://github.com/ixtutixi/GanchanNet/assets/57790443/2afe7a41-27e7-42b7-abe3-e785aa40e747">

### 現在配信中のC#(Xamarin)ベースのがんちゃんねる画面
<img width="200" alt="スクリーンショット 2023-05-12 4 11 52" src="https://github.com/ixtutixi/GanchanNet/assets/57790443/4b530d9f-e2c5-40de-8e42-260c668c128b">
<img width="200" alt="IMG_5EA123C1A039-1" src="https://github.com/ixtutixi/GanchanNet/assets/57790443/9da30064-0dda-4963-9d45-5cf4afc803f8">

## その他
- 就活情報と学内・学外掲示板は、現在絶賛 外部組織とのmeeting & バックエンド開発中
- 端末ごとのUI差異はまだ考慮させてない
