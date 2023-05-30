//
//  CustomTabBarBottom.swift
//  GanChan Network
//
//  Created by 高橋龍一 on 2023/05/29.
//
import SwiftUI

struct CustomTabBarBottom: View {

    @Binding var currentTab: Tab
    
    //微調整用
    var height: CGFloat = 80
    var width: CGFloat = UIScreen.main.bounds.width// - 32

    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.hashValue) { tab in
                    Button {
                        currentTab = tab
                    } label: {
                        Image(systemName: tab.symbolName())
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 30)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? .black : .gray)
                    }
                }
            }
            .frame(width: width, height: height)
                    .background(Color.white)
                    .cornerRadius(30)
                    .shadow(radius: 4, x: 3, y: 2)
        }
        .frame(height: 50)
        .padding(.bottom, 0)
        //.padding([.horizontal, .top])
    }
}

struct CustomTabBarBottom_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBarBottom(currentTab: Binding.constant(.news))
    }
}
