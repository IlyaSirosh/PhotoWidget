//
//  WidgetFamilySelector.swift
//  PhotoWidget
//
//  Created by Illya Sirosh on 13.02.2021.
//

import SwiftUI
import WidgetKit

struct WidgetFamilySelector: View {
    @Binding var family: WidgetFamily
    var body: some View {
        Button(action: {
            family = WidgetFamily(rawValue: (family.rawValue + 1)%3 )!
        }, label: {
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
        WidgetFamilySelector(family: .constant(.systemSmall))
    }
}
