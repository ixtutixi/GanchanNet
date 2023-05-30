//
//  JobInfoView.swift
//  GanChan Network
//
//  Created by 高橋龍一 on 2023/04/27.
//

import SwiftUI

struct JobInfoView: View {
    let jobItems = [
        "アルバイト1",
        "アルバイト2",
        "アルバイト3",
        "アルバイト4",
        "アルバイト5"
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(jobItems, id: \.self) { item in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(item)
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(Color("ThemeGreen"))
                            Text("カテゴリ: バイト")
                                .font(.caption)
                                .foregroundColor(Color.gray)
                            Text("時給: 1,000円")
                                .font(.caption)
                                .foregroundColor(Color.gray)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                        .padding(.horizontal)
                    }
                }
            }
            .background(Color("Background").edgesIgnoringSafeArea(.all))
            .navigationTitle("バイト情報")
        }
    }
}

struct JobInfoView_Previews: PreviewProvider {
    static var previews: some View {
        JobInfoView()
            .previewLayout(.sizeThatFits)
            .background(Color("Background"))
    }
}
