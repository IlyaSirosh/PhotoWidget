//
//  WidgetLayout.swift
//  PhotoWidget
//
//  Created by Illya Sirosh on 13.02.2021.
//

import Foundation

enum WidgetLayout: Equatable{
    case item(Int)
    indirect case columns(WidgetLayout, WidgetLayout)
    indirect case rows(WidgetLayout, WidgetLayout)
    
    var count: Int {
        WidgetLayout.itemCount(for: self)
    }
    
    static func itemCount(for layout: WidgetLayout) -> Int {
        switch layout {
        case .item(_):
            return 1
        case .columns(let l1, let l2):
            return itemCount(for: l1) + itemCount(for: l2)
        case .rows(let l1, let l2):
            return itemCount(for: l1) + itemCount(for: l2)
        }
    }
}

extension WidgetLayout: Codable {
    
    enum CodingKeys: String, CodingKey {
        case item
        case rows
        case columns
    }
    
    enum ColumnCodingKeys: String, CodingKey {
        case col1, col2
    }
    
    enum RowCodingKeys: String, CodingKey {
        case row1, row2
    }
    
    enum CodableError: Error {
        case encoding(String), deconding(String)
    }
    
    struct Columns: Decodable {
        let col1: WidgetLayout
        let col2: WidgetLayout
    }
    
    struct Rows: Decodable {
        let row1: WidgetLayout
        let row2: WidgetLayout
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
        case .item(let index):
            try container.encode(index, forKey: .item)
        case .rows(let r1, let r2):
            var rows = container.nestedContainer(keyedBy: RowCodingKeys.self, forKey: .rows)
            try rows.encode(r1, forKey: .row1)
            try rows.encode(r2, forKey: .row2)
        case .columns(let c1, let c2):
            var cols = container.nestedContainer(keyedBy: ColumnCodingKeys.self, forKey: .columns)
            try cols.encode(c1, forKey: .col1)
            try cols.encode(c2, forKey: .col2)
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let index = try? container.decode(Int.self, forKey: .item) {
            self = .item(index)
            return
        }
        
        if let columns = try? container.decode(Columns.self, forKey: .columns) {
            self = .columns(columns.col1, columns.col2)
            return
        }
        
        if let rows = try? container.decode(Rows.self, forKey: .rows) {
            self = .rows(rows.row1, rows.row2)
            return
        }
        
        throw CodableError.deconding("Cannot decode WidgetLayout")
    }
    
    
    
}
