//
//  CoopViewModel.swift
//  GanChan Network
//
//  Created by 高橋龍一 on 2023/05/24.
//

import Foundation
import Combine

class CoopViewModel: ObservableObject {
    @Published var coopItems = [CoopItem]()
    var cancellables = Set<AnyCancellable>()
    
    init() {
        loadData()
    }
    
    func loadData() {
        guard let url = URL(string: "http://ifive.sakura.ne.jp/scrape/iwate_coop_data.json") else {
            print("Invalid URL.")
            return
        }
        /*
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [CoopItem].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: \.coopItems, on: self)
            .store(in: &cancellables)*/
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let session = URLSession(configuration: configuration)

        session.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [CoopItem].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: \.coopItems, on: self)
            .store(in: &cancellables)

    }/*
    func loadData() -> Future<[CoopItem], Error> {
        return Future { promise in
            guard let url = URL(string: "http://ifive.sakura.ne.jp/scrape/iwate_coop_data.json") else {
                print("Invalid URL.")
                return
            }

            URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: [CoopItem].self, decoder: JSONDecoder())
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        promise(.failure(error))
                    case .finished:
                        break
                    }
                },
                receiveValue: { items in
                    self.coopItems = items
                    promise(.success(items))
                })
                .store(in: &self.cancellables)
        }
    }
    func loadData() -> AnyPublisher<[NewsItem], Error> {
        guard let url = URL(string: "http://ifive.sakura.ne.jp/scrape/iwate_coop_data.json") else {
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
