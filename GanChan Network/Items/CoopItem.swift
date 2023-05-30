//
//  CoopItem.swift
//  GanChan Network
//
//  Created by 高橋龍一 on 2023/05/24.
//

import Foundation

struct CoopItem: Identifiable, Decodable {
    let id = UUID()
    let date: Int
    let category: String
    let title: String
    let link: String
}
