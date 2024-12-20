//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by tejas chaudhari on 20/12/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published private(set) var state = PageState.idle
    @Published var searchQuery: String = ""
    @Published var isCardTapped: Bool = false
    @Published private var asSeachQuery = UserDefaults.standard.string(forKey: ASKeys.searchQuery)
    // MARK: Lifecycle

    deinit {
        NetworkManager.destroy()
        debugPrint("Home ViewModel deinited")
    }
    
    // MARK:  Properties
    
    enum PageState {
        case idle
        case loading
        case failed(Int, String)
        case loaded(CurrentWeather)
    }

    // MARK: Internal

    var currentWetherModel = CurrentValueSubject<CurrentWeather?, Never>(nil)
    var disposeBag = Set<AnyCancellable>()
    private let debounceInterval: DispatchQueue.SchedulerTimeType.Stride = .seconds(1)
}

extension HomeViewModel {
    
    func listenToSearch(){
        print("textsuccess")
        $searchQuery
            .removeDuplicates()
            .debounce(for: debounceInterval, scheduler: DispatchQueue.main)
            .sink { [weak self] delayQuery in
                guard let self = self else { return }
                if !delayQuery.isEmpty {
                    self.fetchCurrentLocationWeather(searchQuery: searchQuery)
                    self.isCardTapped = false
                } else {
                    self.state = .idle
                }
            }
            .store(in: &disposeBag)
    }
    
    func fetchCurrentLocationWeather(searchQuery: String) {
        self.state = .loading
        print("test")
        NetworkManager.shared.homeServices?
            .fetchCurrentLocationWeather(searchQuery: searchQuery)
            .subscribe(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] errorCompletion in
                switch errorCompletion {
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.state = .failed(0, "")
                default:
                    break
                }
            }, receiveValue: { model in
//                if (self.asSeachQuery != searchQuery) {
//                    self.isCardTapped = false
//                }
                print(model)
                self.state = model.error == nil ? .loaded(model) : .failed(model.error?.code ?? 0, model.error?.message ?? "")
            })
            .store(in: &self.disposeBag)
        
    }
}

