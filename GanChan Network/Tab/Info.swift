//
//  Info.swift
//  GanChan Network
//
//  Created by 高橋龍一 on 2023/05/26.
//

import SwiftUI

struct Info: View {
    @State var selected = 0
    
    init() {
       UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack(spacing:0) {
            CustomTabBarTop(selected: $selected)
            TabView (selection: $selected){
                HomeView()
                    .tag(0)
                NewsView()
                    .tag(1)
                CoopView()
                    .tag(2)
                UniView()
                    .tag(3)
            }
        }
    }
}


struct Info_Previews: PreviewProvider {
    static var previews: some View {
        Info()
    }
}
