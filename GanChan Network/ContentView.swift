//
//  ContentView.swift
//  GanChan Network
//
//  Created by 高橋龍一 on 2023/04/27.
//

import SwiftUI
//import ComposableArchitecture

struct ContentView: View {/*
    @EnvironmentObject var viewStore: ViewStore<AppState, AppAction>
                           */
    init() {
       UITabBar.appearance().isHidden = true
    }
    
    @State var currentTab: Tab = .news
    var body: some View {
        VStack(spacing: 0) {
            TitleView()
            Divider()
            TabView(selection: $currentTab) {
                Info()
                    .tag(Tab.news)
                JobView()
                    .tag(Tab.job)
                Text("就活情報.開発中")
                    .tag(Tab.recruit)
                Text("掲示板.開発中")
                    .tag(Tab.board)
            }
            //Divider()
        }.overlay(alignment: .bottom){
            CustomTabBarBottom(currentTab: $currentTab)
                .padding(.vertical)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
