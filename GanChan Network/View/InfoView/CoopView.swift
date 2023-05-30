//
//  CoopView.swift
//  GanChan Network
//
//  Created by 高橋龍一 on 2023/05/24.
//

import SwiftUI

struct CoopView: View {
    @State var selected = 2
    
    @StateObject var viewModel = CoopViewModel()
    @State private var showWebView = false
    @State private var selectedLink = ""
    
    var body: some View {
        List(viewModel.coopItems) { item in
            LazyVStack(alignment: .leading) {
                HStack {
                    Text("["+convertAndFormat(item.date)+"]")
                        .font(.footnote)
                    Spacer()
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

struct CoopView_Previews: PreviewProvider {
    static var previews: some View {
        CoopView()
    }
}
