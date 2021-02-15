//
//  SettingsNavigationController.swift
//  PhotoWidget
//
//  Created by Illya Sirosh on 14.02.2021.
//

import Foundation
import SwiftUI

class SettingsNavigationController: ObservableObject {
    var viewStack: [(String, AnyView)] = []
    @Published var currentView: (title: String, view: AnyView)?
    
    func push(title: String, view: AnyView ) {
        let value = (title, AnyView(view))
        viewStack.append(value)
        currentView = value
    }
    
    func pop() {
        switch viewStack.count {
        case 0:
            currentView = nil
        case 1:
            viewStack.removeLast()
            currentView = nil
        default:
            currentView = viewStack.removeLast()
        }
        
    }
}
