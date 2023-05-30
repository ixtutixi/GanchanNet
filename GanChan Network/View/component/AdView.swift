//
//  AdView.swift
//  GanChan Network
//
//  Created by 高橋龍一 on 2023/05/29.
//

import SwiftUI
import CachedAsyncImage

struct AdView: View {
   
   @ObservedObject private var viewModel = AdViewModel()
   @GestureState private var dragOffset: CGFloat = 0
   @State private var showWebView = false
   @State private var selectedLink = ""
   
   var body: some View {
       GeometryReader { bodyView in
           LazyHStack(spacing: viewModel.carouselItemPadding()) {
               ForEach(viewModel.infinityArray.indices, id: \.self) { index in
                   if let firstItem = viewModel.adItems.first,
                      let imageURL = URL(string: firstItem.image) {
                       CachedAsyncImage(url: imageURL) { image in
                           image.resizable()
                               .aspectRatio(contentMode: .fill).offset(x:-30)
                               .frame(width: viewModel.carouselItemWidth(bodyView: bodyView), height: 35)
                               .onTapGesture {
                                   selectedLink = viewModel.adItems[0].link
                                   showWebView = true
                               }
                       } placeholder: {
                           ProgressView()
                           //Text("~　広告読み込み中　~")
                       }
                   } else {
                       Image("banner")
                           .resizable()
                           .aspectRatio(contentMode: .fill).offset(x:-30)
                           .frame(width: viewModel.carouselItemWidth(bodyView: bodyView), height: 35)
                           .onTapGesture {
                               selectedLink = "https://ifive.sakura.ne.jp/ifive/index.php#contact"
                               showWebView = true
                           }
                   }

                   Image("SUMMER-01")
                       .resizable()
                       .aspectRatio(contentMode: .fill).offset(x:-30)
                       .frame(width: viewModel.carouselItemWidth(bodyView: bodyView), height: 35)
                       .padding(.leading, viewModel.carouselLeadingPadding(index: index, bodyView: bodyView))
                   Image("banner")
                       .resizable()
                       .aspectRatio(contentMode: .fill).offset(x:-30)
                       .frame(width: viewModel.carouselItemWidth(bodyView: bodyView), height: 35)
                       .onTapGesture {
                           selectedLink = "https://ifive.sakura.ne.jp/ifive/index.php#contact"
                           print("Selected link: \(selectedLink)")
                           showWebView = true
                       }
               }.sheet(isPresented: $showWebView) {
                   WebView(url: URL(string:selectedLink))
               }
           }
           .offset(x: dragOffset)
           .offset(x: viewModel.carouselOffsetX(bodyView: bodyView))
           .animation(viewModel.dragAnimation)
           
           .gesture(
               DragGesture()
                   .updating($dragOffset, body: { (value, state, _) in
                       state = value.translation.width
                   })
                   .onChanged({ value in
                       viewModel.onChangedDragGesture()
                   })
                   .onEnded({ value in
                       viewModel.updateCurrentIndex(dragGestureValue: value, bodyView: bodyView)
                   })
           )
            
       }.frame(height: 80)
           .background(Color("iwate2"))
   }
}

struct AdView_Previews: PreviewProvider {
    static var previews: some View {
        AdView()
    }
}
