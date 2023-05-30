//
//  NewsView.swift
//  GanChan Network
//
//  Created by 高橋龍一 on 2023/04/27.
//

import SwiftUI

struct NewsView: View {
    @State var selected = 1
    
    @StateObject var viewModel = NewsViewModel()
    @State private var showWebView = false
    @State private var selectedLink = ""

    var body: some View {
        List(viewModel.newsItems) { item in
            LazyVStack(alignment: .leading) {
                ZStack {
                    HStack {
                        Text("["+convertAndFormat(item.date)+"]")
                            .font(.footnote)
                        Spacer()
                    }
                    Text(item.category)
                            .font(.caption)
                            .bold()
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color("iwate"))
                            .cornerRadius(20)
                            .offset(x: 100, y: 0)
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
/*カテゴリごと
struct NewsCateView: View {
    @StateObject var viewModel = NewsViewModel()
    @State private var showWebView = false
    @State private var selectedLink = ""

    // Group news items by category
    private var groupedNewsItems: [String: [NewsItem]] {
        Dictionary(grouping: viewModel.newsItems, by: { $0.category })
    }

    var body: some View {
        List {
            ForEach(groupedNewsItems.keys.sorted(), id: \.self) { key in
                DisclosureGroup(key) {
                    ForEach(groupedNewsItems[key]!) { item in
                        VStack(alignment: .leading, spacing: 2) {
                            ZStack {
                                HStack {
                                    Text("["+convertAndFormat(item.date)+"]")
                                        .font(.footnote)
                                    Spacer()
                                }
                            }
                            Text(item.title)
                                .font(.callout)
                        }
                        .listRowSeparatorTint(Color.blue)
                        .onTapGesture {
                            selectedLink = item.link
                            showWebView = true
                        }
                    }
                }
                .textCase(nil) // Optional: Prevent SwiftUI from making the section title uppercase
            }
        }
        .listStyle(InsetGroupedListStyle())
        .scrollContentBackground(.hidden)
        .background(Color("Background"))
        .sheet(isPresented: $showWebView) {
            WebView(url: URL(string: selectedLink))
        }
    }

    //func convertAndFormat(_ date: Int) -> String {
        // Add your implementation here
    //}
}
*/

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
            //.previewLayout(.sizeThatFits)
            //.background(Color("Background"))
    }
}


// 整数値をDateへ変換し、指定の形式へフォーマット
func convertAndFormat(_ dateInt: Int) -> String {
    // 整数値をStringへ変換
    let dateString = String(dateInt)
    
    // DateFormatterを作成
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyyMMdd"

    guard let date = formatter.date(from: dateString) else {
        return "Invalid date"
    }
    
    // 日付を新たな形式にフォーマット
    formatter.dateFormat = "yyyy.MM.dd"
    return formatter.string(from: date)
}


