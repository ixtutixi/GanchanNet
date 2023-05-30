//
//  AdItem.swift
//  GanChan Network
//
//  Created by 高橋龍一 on 2023/05/29.
//

import Foundation

struct AdItem: Identifiable, Decodable {
    let id = UUID()
    let image: String
    let link: String
}
