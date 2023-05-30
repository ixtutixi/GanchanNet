//
//  JobViewModel.swift
//  GanChan Network
//
//  Created by 高橋龍一 on 2023/05/24.
//

import Foundation
import Combine

class JobViewModel: ObservableObject {
    @Published var jobItems = [JobItem]()
    var cancellables = Set<AnyCancellable>()
    
    init() {
        loadData()
    }
    
    func loadData() {
        guard let url = URL(string: "http://ifive.sakura.ne.jp/scrape/iwate_coop_jobs_data.json") else {
            print("Invalid URL.")
            return
        }
        /*
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [JobItem].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: \.jobItems, on: self)
            .store(in: &cancellables)
         */
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let session = URLSession(configuration: configuration)

        session.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [JobItem].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: \.jobItems, on: self)
            .store(in: &cancellables)
    }
}
