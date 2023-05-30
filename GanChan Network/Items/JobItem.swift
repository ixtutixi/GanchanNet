//
//  JobItem.swift
//  GanChan Network
//
//  Created by 高橋龍一 on 2023/05/24.
//

import Foundation

struct JobItem: Identifiable, Decodable {
    let id = UUID()
    let link: String
    let title: String
    let content: String
    let wage: String
    let labels: [String]
}
