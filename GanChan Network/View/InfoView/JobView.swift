//
//  JobView.swift
//  GanChan Network
//
//  Created by 高橋龍一 on 2023/05/24.
//

import SwiftUI

struct JobView: View {
    @StateObject var viewModel = JobViewModel()
    @State private var showWebView = false
    @State private var selectedLink = ""
    
    var body: some View {
        VStack(spacing: 0) {
            AdView()
            List(viewModel.jobItems) { item in
                LazyVStack(alignment: .leading) {
                    Text(item.title)
                        .font(.caption)
                        .bold()
                    Divider()
                    Text(item.content)
                    
                    HStack {
                        Text(item.wage)
                            .font(.footnote)
                        Spacer()
                        Text(item.labels[0])
                            .font(.caption)
                            .bold()
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color("iwate"))
                            .cornerRadius(20)
                    }
                }
                .onTapGesture {
                    selectedLink = item.link
                    showWebView = true
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
}

struct JobView_Previews: PreviewProvider {
    static var previews: some View {
        JobView()
    }
}
