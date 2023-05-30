//
//  CategoryNewsView.swift
//  GanChan Network
//
//  Created by 高橋龍一 on 2023/05/30.
//

import SwiftUI

struct CategoryNewsView: View {
    var category: String
    @ObservedObject var viewModel: NewsViewModel
    @State private var showWebView = false
    @State private var selectedLink = ""

    var body: some View {
        List(viewModel.newsItems.filter { $0.category == category }) { item in
            
            LazyVStack(alignment: .leading) {
                ZStack {
                    HStack {
                        Text("["+convertAndFormat(item.date)+"]")
                            .font(.footnote)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text(item.category)
                            .font(.caption)
                            .bold()
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color("iwate"))
                            .cornerRadius(20)
                    }.offset(x: 0, y: -5)
                }
                Text(item.title)
                    .font(.body)
            }.listRowBackground(Color("iwate2"))
                .padding()
                .background(Color("iwate3"))
                .cornerRadius(20)
                .shadow(radius: 1, x: 0, y: 0)
                .listRowSeparator(.hidden)
            //.listRowSeparatorTint(Color.blue)
                .onTapGesture {
                    selectedLink = item.link
                    print(selectedLink)
                    showWebView = true
                }
        }
        .listStyle(PlainListStyle())
        .scrollContentBackground(.hidden)
        .background(Color("iwate2"))
        .sheet(isPresented: $showWebView) {
            WebView(url: URL(string: selectedLink))
            
        }
    }
}


struct CategoryNewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
