//
//  WidgetLayout.swift
//  PhotoWidget
//
//  Created by Illya Sirosh on 13.02.2021.
//

import Foundation

enum WidgetLayout {
    case item(Int)
    indirect case columns(WidgetLayout, WidgetLayout)
    indirect case rows(WidgetLayout, WidgetLayout)
}
