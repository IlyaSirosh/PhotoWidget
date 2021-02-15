//
//  WidgetFamilySelector.swift
//  PhotoWidget
//
//  Created by Illya Sirosh on 13.02.2021.
//

import SwiftUI
import WidgetKit

struct DotsButton: View {
    let action: () -> Void
    
    init(action: @escaping () -> Void){
        self.action = action
    }
    
    var body: some View {
        Button(action: action, label: {
            HStack {
                Circle()
                Circle()
                Circle()
            }
            .frame(width: 30)
            .foregroundColor(.primary)
            .padding(10)
        })
    }
}

struct WidgetFamilySelector_Previews: PreviewProvider {
    static var previews: some View {
        DotsButton(action: {})
    }
}
