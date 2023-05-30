//
//  CustomTabView.swift
//  GanChan Network
//
//  Created by 高橋龍一 on 2023/05/26.
//

//
//  CustamTabVar.swift
//  Ganchannel
//
//  Created by 高橋龍一 on 2022/11/28.
//

import SwiftUI

struct CustomTabBarTop : View {
    @Binding var selected : Int
    @Namespace var namespace
    
    
    var body: some View {
        //ScrollView(.horizontal,showsIndicators: false) {
        HStack (spacing : 10){
            Button(action: {
                self.selected = 0
            }) {
                VStack(spacing : 5){
                    Text("ホーム")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.black)
                    if self.selected == 0 {
                        Color("iwate").frame(height: 4.0)
                            .matchedGeometryEffect(id: "underline", in: namespace, properties: .frame)
                            .padding(.top,4)
                    } else {
                        Color.clear.frame(height: 1.5).padding(.horizontal, 5)
                    }
                }.animation(.spring(), value: selected)
            }
            Button(action: {
                self.selected = 1
            }) {
                VStack(spacing : 5){
                    Text("岩大公式HP")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.black)
                    if self.selected == 1 {
                        Color("iwate").frame(height: 4.0)
                            .matchedGeometryEffect(id: "underline", in: namespace, properties: .frame)
                            .padding(.top,4)
                    } else {
                        Color.clear.frame(height: 1.5).padding(.horizontal, 5)
                    }
                }.animation(.spring(), value: selected)
            }
            Button(action: {
                self.selected = 2
            }) {
                VStack(spacing : 5){
                    Text("岩大生協")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.black)
                    if self.selected == 2 {
                        Color("iwate").frame(height: 4.0)
                            .matchedGeometryEffect(id: "underline", in: namespace, properties: .frame)
                            .padding(.top,4)
                    } else {
                        Color.clear.frame(height: 1.5).padding(.horizontal, 5)
                    }
                }.animation(.spring(), value: selected)
            }
            Button(action: {
                self.selected = 3
            }) {
                VStack(spacing : 5){
                    Text("International")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.black)
                    if self.selected == 3 {
                        Color("iwate").frame(height: 4.0)
                            .matchedGeometryEffect(id: "underline", in: namespace, properties: .frame)
                            .padding(.top,4)
                    } else {
                        Color.clear.frame(height: 1.5).padding(.horizontal, 5)
                    }
                }.animation(.spring(), value: selected)
            }
        }.padding(.top)
    }
}

struct CustomTabBarTop_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBarTop(selected: Binding.constant(1))
    }
}
