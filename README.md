# GanchanNet
iOS版がんちゃんねるの大幅アップデート(by ixtutixi)

カンパニーリポジトリをpublicにするのはアレなので、個人開発の記録としてここにuploadする。(全部自分のコードなので多分大丈夫)

概要
・SwiftUI+Combine
・iOS16.0以上を対象
内容
・各jsonから得たニュースをList表示(タップで対象ブラウザへモーダル遷移)
・サーバー側で変更可能な広告の差し込み
・Tabが上下に1個ずつ欲しいため、両方カスタムタブバーを自作
・Combine,async-imageで非同期処理
      :ached-async-image(画像のキャッシュのためのライブラリ)
      :https://github.com/lorenzofiamingo/swiftui-cached-async-image
取得jsonはPHPによる対象URLのスクレイピング

