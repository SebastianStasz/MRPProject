//
//  View+Ext.swift
//  MRPProject
//

import SwiftUI

extension View {
    func embedInForm() -> some View {
        Form { self }
    }
    
    func embedInHorizontalScrollView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) { self }
    }
    
    func navigation<Item, Destination: View>(item: Binding<Item?>, @ViewBuilder destination: (Item) -> Destination) -> some View {
        let isActive = Binding(
            get: { item.wrappedValue != nil },
            set: { if !$0 { item.wrappedValue = nil } }
        )
        return navigation(isActive: isActive) {
            item.wrappedValue.map(destination)
        }
    }

    func navigation<Destination: View>(isActive: Binding<Bool>, @ViewBuilder destination: () -> Destination) -> some View {
        overlay(NavigationLink(destination: destination(), isActive: isActive) {})
    }

    @ViewBuilder
    func displayIf(_ condition: Bool) -> some View {
        if condition { self }
    }
    
    func activityIndicator(showIf isLoading: Bool) -> some View {
        self.disabled(isLoading)
            .overlay(presentActivityIndicator(if: isLoading).animation(.easeInOut(duration: 0.3)))
    }
    
    @ViewBuilder
    private func presentActivityIndicator(if isLoading: Bool) -> some View {
        if isLoading {
            ProgressView().transition(.opacity)
        }
    }

    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
