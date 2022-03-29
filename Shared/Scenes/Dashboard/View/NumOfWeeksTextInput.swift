//
//  NumOfWeeksTextInput.swift
//  MRPProject (iOS)
//
//  Created by sebastianstaszczyk on 29/03/2022.
//

import Combine
import SwiftUI

struct NumOfWeeksTextInput: View {

    @State private var lastValue: Int = 6
    @ObservedObject var viewModel: DashboardVM
    var isFocused: FocusState<Bool>.Binding

    var body: some View {
        TextInput(title: "Ilość tygodni", value: $viewModel.bedData.numberOfWeeks)
            .onReceive(Just(viewModel.bedData.numberOfWeeks)) {
                guard $0 != lastValue else { return }
                lastValue = $0
                if $0 < 1 {
                    isFocused.wrappedValue = false
                    viewModel.bedData.numberOfWeeks = 1
                }
            }
            .focused(isFocused)
            .keyboardType(.numberPad)
    }
}
