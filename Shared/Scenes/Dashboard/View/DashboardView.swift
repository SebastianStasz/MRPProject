//
//  DashboardView.swift
//  MRPProject
//

import Combine
import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel = DashboardVM()
    @FocusState private var numOfWeeksFocus: Bool
    @State private var isComponentsViewPresented = false
    @State private var isSummaryViewPresented = false
    @State private var isErrorPresented = false
    
    var body: some View {
        VStack(spacing: 0) {
            Group {
                NumOfWeeksTextInput(viewModel: viewModel, isFocused: $numOfWeeksFocus)

                ValidationMessage(.first_production_error_message)
                    .displayIf(!viewModel.bedData.isValid)

                WeekList(weeksData: $viewModel.bedData.weeksData)
            }
            .embedInForm()
        }
        .onTapGesture { hideKeyboard() }
        .toolbar { toolbarContent }
        .navigation(item: $viewModel.bedMRPResult) { ResultView(bedMRPResult: $0) }
        .sheet(isPresented: $isComponentsViewPresented) { ComponentsView(viewModel: viewModel) }
        .embedInNavigationView(title: .demand_label)
        .activityIndicator(showIf: viewModel.isLoading)
        .onChange(of: viewModel.errorMessage) { if $0 != nil { isErrorPresented = true } }
        .alert("Błąd", isPresented: $isErrorPresented, actions: { Button("OK") { viewModel.errorMessage = nil } }, message: { Text(viewModel.errorMessage ?? "") })
    }

    private var toolbarContent: some ToolbarContent {
        Group {
            Toolbar.leading(title: .reset_label, action: resetInputData)
            Toolbar.trailing(title: .components_label, action: presentComponentsView)
            Toolbar.bottomBar { CalculateButton(isDisabled: viewModel.isLoading, action: calculateBedMRP).disabled(!viewModel.bedData.isValid) }
        }
    }
    
    // MARK: - Interactions
    
    private func presentComponentsView() {
        isComponentsViewPresented = true
    }

    private func resetInputData() {
        numOfWeeksFocus = false
        viewModel.resetData()
    }
    
    private func calculateBedMRP() {
        viewModel.input.didTapCalculate.send(viewModel.bedData)
    }
}

// MARK: - Preview

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
