//
//  SettingsNavigationViewModel.swift
//  PhotoWidget
//
//  Created by Illya Sirosh on 14.02.2021.
//

import Foundation

class SettingsNavigationController<SettingsSubview: SettingsView>: ObservableObject {
    private var viewStack: [SettingsSubview] = []
    @Published var currentView: SettingsSubview?
    
    func push(view: SettingsSubview) {
        viewStack.append(view)
        currentView = view
    }
    
    func pop() {
        if viewStack.isEmpty {
            currentView = nil
        } else {
            currentView = viewStack.removeLast()
        }
    }
}
