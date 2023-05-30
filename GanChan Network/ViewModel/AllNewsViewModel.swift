//
//  AllNewsViewModel.swift
//  GanChan Network
//
//  Created by 高橋龍一 on 2023/05/29.
//
import Combine
import Foundation
/*
class AllNewsViewModel: ObservableObject {
    @Published var allNewsItems = [NewsItem]()

    private var cancellables = Set<AnyCancellable>()

    init() {
        loadData()
    }

    private func loadData() {
        let publishers = [
            NewsViewModel().loadData(),
            CoopViewModel().loadData(),
            UniViewModel().loadData()
        ]

        Publishers.MergeMany(publishers)
            .collect()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] items in
                    self?.allNewsItems = items.flatMap { $0 }
                })
            .store(in: &cancellables)
    }
}
class AllNewsViewModel: ObservableObject {
    @Published var allNewsItems = [NewsItem]()

    private var cancellables = Set<AnyCancellable>()

    init() {
        loadData()
    }

    private func loadData() {
        let urls = [
            URL(string: "http://ifive.sakura.ne.jp/scrape/iwate_u_data.json"),
            URL(string: "http://ifive.sakura.ne.jp/scrape/iwate_coop_data.json"),
            URL(string: "http://ifive.sakura.ne.jp/scrape/iwate_university_data.json")
        ]

        let publishers = urls.compactMap { url -> AnyPublisher<[NewsItem], Error>? in
            guard let url = url else { return nil }
            return URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: [NewsItem].self, decoder: JSONDecoder())
                .replaceError(with: [])
                .setFailureType(to: Error.self) // エラー型を指定する
                .eraseToAnyPublisher()
        }


        Publishers.MergeMany(publishers)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] items in
                    let filteredItems = items.filter { self?.isTodayOrYesterday($0.date) ?? false }
                    self?.allNewsItems.append(contentsOf: filteredItems)
            })
            .store(in: &cancellables)
    }

    private func isTodayOrYesterday(_ dateInt: Int) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        guard let date = formatter.date(from: String(dateInt)) else {
            return false
        }
        
        let calendar = Calendar.current
        let now = Date()
        
        if calendar.isDateInToday(date) || calendar.isDateInYesterday(date) {
            return true
        }
        
        return false
    }
}*/

  import Combine

  class AllNewsViewModel: ObservableObject {
      @Published var newsItems: [NewsItem] = []
      private var cancellables: Set<AnyCancellable> = []
      
      func loadData() {
          let urls = [
              URL(string: "http://ifive.sakura.ne.jp/scrape/iwate_u_data.json"),
              URL(string: "http://ifive.sakura.ne.jp/scrape/iwate_coop_data.json"),
              URL(string: "http://ifive.sakura.ne.jp/scrape/iwate_university_data.json")
          ]
          
          let publisher = Publishers.MergeMany(
              urls.compactMap { $0 }
                  .map { URLSession.shared.dataTaskPublisher(for: $0).map { $0.data } }
          )
          
          publisher
              .decode(type: [NewsItem].self, decoder: JSONDecoder())
              .replaceError(with: [])
              .receive(on: DispatchQueue.main)
              .sink { [weak self] newsItems in
                  self?.filterAndDisplayNews(newsItems)
              }
              .store(in: &cancellables)
      }
      
      private func filterAndDisplayNews(_ newsItems: [NewsItem]) {
          let tokyo = TimeZone(identifier: "Asia/Tokyo")!
          let calendar = Calendar.current
          let currentDate = Date()
          
          let filteredNewsItems = newsItems.filter { newsItem in
              let newsDate = convertAndFormat(newsItem.date)
              
              let formatter = DateFormatter()
              formatter.dateFormat = "yyyy.MM.dd"
              formatter.timeZone = tokyo
              
              guard let formattedDate = formatter.date(from: newsDate) else {
                  return false
              }
              
              let isToday = calendar.isDate(formattedDate, inSameDayAs: currentDate)
              let isYesterday = calendar.isDate(formattedDate, inSameDayAs: calendar.date(byAdding: .day, value: -1, to: currentDate)!)
              
              return isToday || isYesterday
          }
          
          DispatchQueue.main.async {
              self.newsItems = filteredNewsItems
          }
      }
      
      private func convertAndFormat(_ dateInt: Int) -> String {
          let dateString = String(dateInt)
          
          let formatter = DateFormatter()
          formatter.dateFormat = "yyyyMMdd"
          
          guard let date = formatter.date(from: dateString) else {
              return "Invalid date"
          }
          
          formatter.dateFormat = "yyyy.MM.dd"
          return formatter.string(from: date)
      }
  }

