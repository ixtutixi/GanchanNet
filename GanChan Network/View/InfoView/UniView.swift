//
//  UniView.swift
//  GanChan Network
//
//  Created by 高橋龍一 on 2023/05/24.
//

import SwiftUI

struct UniView: View {
    @State var selected = 3
    
    @StateObject var viewModel = UniViewModel()
    @State private var showWebView = false
    @State private var selectedLink = ""

    var body: some View {
        List(viewModel.uniItems) { item in
            LazyVStack(alignment: .leading,spacing: 5) {
                ZStack {
                    HStack {
                        Text("["+convertAndFormat(item.date)+"]")
                            .font(.footnote)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        if !item.category.isEmpty {
                            Text(item.category + "     ")
                                .font(.caption)
                                .bold()
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color("Background"))
                                .cornerRadius(20)
                        }
                    }.offset(x: 35, y: -10)
                }
                Text(item.title)
                    .font(.body)
            }.padding(.vertical)
                .listRowSeparatorTint(Color.blue)
                .onTapGesture {
                    selectedLink = item.link
                    showWebView = true
                }
        }
        .listStyle(InsetListStyle())
        .scrollContentBackground(.hidden)
        //.background(Color("Background"))
        .sheet(isPresented: $showWebView) {
            WebView(url: URL(string: selectedLink))
        }
    }
}

struct UniView_Previews: PreviewProvider {
    static var previews: some View {
        UniView()
    }
}
