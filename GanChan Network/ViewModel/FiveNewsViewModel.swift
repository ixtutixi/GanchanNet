//
//  ViewModel.swift
//  GanChan Network
//
//  Created by 高橋龍一 on 2023/05/29.
import SwiftUI
import Combine

class FiveNewsViewModel: ObservableObject {
    @Published var newsItems: [NewsItem] = []
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        loadData()
    }
    
    func loadData() {
        let urls = [
            URL(string: "http://ifive.sakura.ne.jp/scrape/iwate_u_data.json"),
            URL(string: "http://ifive.sakura.ne.jp/scrape/iwate_coop_data.json"),
            URL(string: "http://ifive.sakura.ne.jp/scrape/iwate_university_data.json")
        ]
        
        let publishers = urls.compactMap { $0 }
            .map { url in
                URLSession.shared.dataTaskPublisher(for: url)
                    .map(\.data)
                    .decode(type: [NewsItem].self, decoder: JSONDecoder())
                    .replaceError(with: [])
            }
        
        Publishers.MergeMany(publishers)
            .collect()
            .map { newsItems in
                newsItems
                    .flatMap { $0 }
                    .sorted(by: { $0.date > $1.date })
                    .prefix(10)
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newsItems in
                self?.newsItems = Array(newsItems)
            }
            .store(in: &cancellables)
    }
}

