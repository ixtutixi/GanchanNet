//
//  adVIewModel.swift
//  GanChan Network
//
//  Created by 高橋龍一 on 2023/05/29.
//

import SwiftUI
import Combine
import Foundation

class AdViewModel: ObservableObject {
   @Published var adItems = [AdItem]()
   var cancellables = Set<AnyCancellable>()
    
   // タイマー
   private var timer: AnyCancellable?
   // 各itemの幅
   private let ITEM_PADDING: CGFloat = 14
   // offset移動アニメーション時間
   private let OFFSET_X_ANIMATION_TIME: Double = 0.2
   private var cancellableSet: Set<AnyCancellable> = []
   
   // 加工前の配列
   private var examples = ["custom", "SUMMER-01", "banner"]
   // 無限カルーセル用に加工した配列
   @Published var infinityArray: [String] = []
   // 初期位置は2に設定する
   @Published var currentIndex = 2
   // アニメーションの有無を操作
   @Published private var isOffsetAnimation: Bool = true
   // アニメーション
   @Published var dragAnimation: Animation? = nil
   
   init() {
       loadData()
       self.infinityArray = createInfinityArray(examples)
       
       $currentIndex
           .receive(on: RunLoop.main)
           .sink { index in
               // 2要素未満の場合は、無限スクロールにしないため処理は必要なし
               if self.examples.count < 2 {
                   return
               }
               
               // 無限スクロールを実現させるため、オフセット移動アニメーション後（0.2s後）にcurrentIndexをリセットする
               DispatchQueue.main.asyncAfter(deadline: .now() + self.OFFSET_X_ANIMATION_TIME) {
                   if index <= 1 {
                       self.isOffsetAnimation = false
                       self.currentIndex = 1 + self.examples.count
                   } else if index >= 2 + self.examples.count {
                       self.isOffsetAnimation = false
                       self.currentIndex = 2
                   }
               }
           }
           .store(in: &cancellableSet)
       
       $isOffsetAnimation
           .receive(on: RunLoop.main)
           .map { isAnimation in
               return isAnimation ? .linear(duration: self.OFFSET_X_ANIMATION_TIME) : .none
           }
           .assign(to: \.dragAnimation, on: self)
           .store(in: &cancellableSet)
       
       // タイマーの設定
       self.timer = Timer.publish(every: 6, on: .main, in: .common)
           .autoconnect()
           .sink { _ in
               // 指定した間隔で実行する処理
               self.updateCurrentIndexForAutomaticSlide()
           }
       
   }
    
    // 自動スライドのための現在のインデックス更新
    func updateCurrentIndexForAutomaticSlide() {
        DispatchQueue.main.async {
            withAnimation(.easeInOut(duration: 1.5)) {
                if self.currentIndex >= self.infinityArray.count - 1 {
                    self.currentIndex = 2
                } else {
                    self.currentIndex += 1
                }
            }
        }
    }


   
    func loadData() {
        guard let url = URL(string: "http://ifive.sakura.ne.jp/advertisement/ad.json") else {
            print("Invalid URL.")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [AdItem].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: \.adItems, on: self)
            .store(in: &cancellables)
    }
   /// 擬似無限スクロール用の配列を生成：ex) [1,2,3]→[2,3,1,2,3,1,2]
   private func createInfinityArray(_ targetArray: [String]) -> [String] {
       if targetArray.count > 1 {
           var result: [String] = []
           // 最後の2要素
           result += targetArray.suffix(2)
           // 本来の配列
           result += targetArray
           // 最初の2要素
           result += targetArray.prefix(2).map { $0 }

           return result
       } else {
           return targetArray
       }
   }
}

/// 各種メソッド
extension AdViewModel {
   /// itemPadding
   func carouselItemPadding() -> CGFloat {
       return ITEM_PADDING
   }
   
   /// カルーセル各要素のWidth
   func carouselItemWidth(bodyView: GeometryProxy) -> CGFloat {
       return bodyView.size.width * 0.8
   }
   
    // itemを中央に配置するためにカルーセルのleading paddingを返す
    func carouselLeadingPadding(index: Int, bodyView: GeometryProxy) -> CGFloat {
        let totalPadding = CGFloat(adItems.count - 1) * ITEM_PADDING
        let totalItemWidth = CGFloat(adItems.count) * carouselItemWidth(bodyView: bodyView) + totalPadding
        let leadingPadding = (bodyView.size.width - totalItemWidth) / 3
        
        return index == 0 ? leadingPadding : 0
    }
    
    // カルーセルのOffsetのX値を返す
    func carouselOffsetX(bodyView: GeometryProxy) -> CGFloat {
        let totalItemWidth = CGFloat(adItems.count) * carouselItemWidth(bodyView: bodyView)
        let totalPadding = CGFloat(adItems.count - 1) * ITEM_PADDING
        let totalWidth = totalItemWidth + totalPadding
        
        return (bodyView.size.width - totalWidth) / 2 - CGFloat(currentIndex) * (carouselItemWidth(bodyView: bodyView) + ITEM_PADDING)
    }
   
   /// ドラッグ操作
   func onChangedDragGesture() {
       // ドラッグ時にはアニメーション有効
       if self.isOffsetAnimation == false {
           self.isOffsetAnimation = true
       }
   }
   
   /// ドラッグ操作によるcurrentIndexの操作
   func updateCurrentIndex(dragGestureValue: _ChangedGesture<GestureStateGesture<DragGesture, CGFloat>>.Value, bodyView: GeometryProxy) {
       var newIndex = currentIndex
       // ドラッグ幅からページングを判定
       if abs(dragGestureValue.translation.width) > bodyView.size.width * 0.3 {
           newIndex = dragGestureValue.translation.width > 0 ? self.currentIndex - 1 : self.currentIndex + 1
       }
       
       // 最小ページ、最大ページを超えないようチェック
       if newIndex < 0 {
           newIndex = 0
       } else if newIndex > (self.infinityArray.count - 1) {
           newIndex = self.infinityArray.count - 1
       }
       
       self.isOffsetAnimation = true
       self.currentIndex = newIndex
   }
}
