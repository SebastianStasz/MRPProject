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
    
    struct Input {
        let didTapCalculate = PassthroughSubject<BedViewData, Never>()
    }
    
    struct Output {
        let presentResultView: Driver<Void>
    }
    
    let input = Input()
    
    init() {
        let errorTracker = SubjectDriver<Error>()

//        $bedData
//            .map { $0.numberOfWeeks }
//            .sink { [weak self] numberOfWeeks in
//                self?.bedData.weeksData = WeekData.forNumberOfWeeks(numberOfWeeks)
//            }
//            .store(in: &cancellables)
        
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
        
        errorTracker
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                print("Error: \(error)")
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }

    func resetData() {
        bedData.reset()
    }
}
