//
//  HomeView.swift
//  GanChan Network
//
//  Created by 高橋龍一 on 2023/05/29.
//

import SwiftUI

struct HomeView: View {
    @State var selected = 0
    
    @StateObject var viewModel = FiveNewsViewModel()
    @State private var showWebView = false
    @State private var selectedLink = ""

    var body: some View {
        VStack(spacing: 0) {
            AdView()
            HStack {
                Text("Recently News")
                    .bold()
                    .font(.title2)
                    .padding(.horizontal,25)
                    .padding(.vertical,5)
                    .underline()
                    .foregroundColor(Color("iwate"))
                Spacer()
            } .background(Color("iwate2"))
            List(viewModel.newsItems) { item in
                LazyVStack(alignment: .leading) {
                    Text("["+convertAndFormat(item.date)+"]")
                        .font(.footnote)
                    Spacer()
                    Text(item.title)
                        .font(.body)
                }.listRowBackground(Color("iwate2"))
                .padding()
                .background(Color("iwate3"))
                .cornerRadius(20)
                .shadow(radius: 1, x: 0, y: 0)
                .listRowSeparator(.hidden)
                .onTapGesture {
                    selectedLink = item.link
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
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
