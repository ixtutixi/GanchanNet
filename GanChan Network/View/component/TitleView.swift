//
//  NavigationView.swift
//  GanChan Network
//
//  Created by 高橋龍一 on 2023/05/26.
//

import SwiftUI

struct TitleView: View {
    var body: some View {
        HStack{
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 170, height: 40)
                .padding()
            Spacer()
            Image(systemName: "ellipsis")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .rotationEffect(.degrees(90))
                .padding()
        }//.background(Color("iwate2"))
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }
}
