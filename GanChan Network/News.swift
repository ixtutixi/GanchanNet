//
//  News.swift
//  GanChan Network
//
//  Created by 高橋龍一 on 2023/04/27.
//

struct News: Codable, Identifiable {
    let id: Int
    let date: String // この行を修正して、String型に変更します
    let category: String
    let title: String
    let link: String
}

