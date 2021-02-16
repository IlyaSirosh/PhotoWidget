//
//  Environment.swift
//  PhotoWidget
//
//  Created by Illya Sirosh on 16.02.2021.
//

import SwiftUI

struct ButtonWidth: EnvironmentKey {
    static var defaultValue: CGFloat = 70
}

struct ButtonCornerRadius: EnvironmentKey {
    static var defaultValue: CGFloat = 15
}

struct ButtonSpacing: EnvironmentKey {
    static var defaultValue: CGFloat = 20
}

struct ScreenWidth: EnvironmentKey {
    static var defaultValue: CGFloat = 300
}


extension EnvironmentValues {
    var buttonWidth: CGFloat {
        get { self[ButtonWidth.self] }
        set { self[ButtonWidth.self] = newValue}
    }
    
    var buttonCornerRadius: CGFloat {
        get { self[ButtonCornerRadius.self] }
        set { self[ButtonCornerRadius.self] = newValue}
    }
    
    var buttonSpacing: CGFloat {
        get { self[ButtonSpacing.self] }
        set { self[ButtonSpacing.self] = newValue }
    }
    
    var screenWidth: CGFloat {
        get { self[ScreenWidth.self] }
        set { self[ScreenWidth.self] = newValue }
    }
}
