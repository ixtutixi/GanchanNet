//
//  NewsViewModel.swift
//  GanChan Network
//
//  Created by 高橋龍一 on 2023/04/27.
//

import Foundation
import Combine
/*
class NewsViewModel: ObservableObject {
    @Published var newsItems: [News] = []
    @Published var selectedCategory: String?
    
    private var cancellables: Set<AnyCancellable> = []

    func fetchNews() {
        guard let url = URL(string: "http://ifive.sakura.ne.jp/scrape/iwate_u_data.json") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [News].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching news items: \(error.localizedDescription)")
                }
            } receiveValue: { newsItems in
                self.newsItems = newsItems
                print("Fetched \(newsItems.count) news items")
            }
            .store(in: &cancellables)
    }

    
    /*
    func filteredNewsItems() -> [News] {
        guard let selectedCategory = selectedCategory else {
            return newsItems
        }
        return newsItems.filter { $0.category == selectedCategory }
    }
     */
    func filteredNewsItems() -> [News] {
        let filteredItems: [News]
        if let selectedCategory = selectedCategory {
            filteredItems = newsItems.filter { $0.category == selectedCategory }
        } else {
            filteredItems = newsItems
        }
        print("Filtered \(filteredItems.count) news items for category: \(selectedCategory ?? "All")") // この行を追加します。
        return filteredItems
    }

    
}
*/
class NewsViewModel: ObservableObject {
    @Published var newsItems = [NewsItem]()
    var cancellables = Set<AnyCancellable>()
    
    init() {
        loadData()
    }
    
    func loadData() {
        guard let url = URL(string: "http://ifive.sakura.ne.jp/scrape/iwate_u_data.json") else {
            print("Invalid URL.")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [NewsItem].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: \.newsItems, on: self)
            .store(in: &cancellables)
    }
     /*
    func loadData() -> Future<[NewsItem], Error> {
        return Future { promise in
            guard let url = URL(string: "http://ifive.sakura.ne.jp/scrape/iwate_u_data.json") else {
                print("Invalid URL.")
                return
            }

            URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: [NewsItem].self, decoder: JSONDecoder())
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        promise(.failure(error))
                    case .finished:
                        break
                    }
                },
                receiveValue: { items in
                    self.newsItems = items
                    promise(.success(items))
                })
                .store(in: &self.cancellables)
        }
    }
     
    func loadData() -> AnyPublisher<[NewsItem], Error> {
        guard let url = URL(string: "http://ifive.sakura.ne.jp/scrape/iwate_u_data.json") else {
            print("Invalid URL.")
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [NewsItem].self, decoder: JSONDecoder())
            .mapError { $0 as Error }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }*/
}


