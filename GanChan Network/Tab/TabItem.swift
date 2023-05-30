//
//  TabModel.swift
//  GanChan Network
//
//  Created by 高橋龍一 on 2023/05/29.
//

enum Tab: CaseIterable {
    case news
    case job
    case recruit
    case board
}
// MARK: - SF Symbols Name
extension Tab {
    func symbolName() -> String {
        switch self {
        case .news:
            return "newspaper"
        case .job:
            return "briefcase"
        case .recruit:
            return "person.3"
        case .board:
            return "message"
        }
    }
}
