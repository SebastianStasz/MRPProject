//
//  DashboardVM.swift
//  MRPProject
//

import Combine
import Foundation

final class DashboardVM: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private lazy var service = BedMRPService()

    @Published private(set) var isLoading = false
    @Published var bedMRPResult: BedMRPResult?
    @Published var bedData = BedViewData()
    @Published var errorMessage: String?
    
    struct Input {
        let didTapCalculate = PassthroughSubject<BedViewData, Never>()
    }
    
    struct Output {
        let presentResultView: Driver<Void>
    }
    
    let input = Input()
    
    init() {
        input.didTapCalculate
        //            .removeDuplicates()
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.bedMRPResult = nil
                self?.isLoading = true
            })
            .compactMap { [weak self] model in
                self?.service.calculateBedMRP(for: self!.bedData.bedMRPModel)
                    .receive(on: DispatchQueue.main)
                    .catch { error -> Empty in
                        print("Error: \(error)")
                        self?.isLoading = false
                        self?.errorMessage = error.description
                        return Empty()
                    }
            }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] reposense in
                self?.isLoading = false
                self?.bedMRPResult = reposense
            }
            .store(in: &cancellables)
    }

    func resetData() {
        bedData.reset()
    }
}
