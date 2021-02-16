//
//  PhotoWidgetConfiguration.swift
//  PhotoWidget
//
//  Created by Illya Sirosh on 15.02.2021.
//

import Foundation
import WidgetKit

struct PhotoWidgetStore {
    private let store = UserDefaults(suiteName: "group.sirosh.photowidget.widgets")!
    
    func loadCurrentWidgetFamily() -> WidgetFamily? {
        guard let data = store.data(forKey: Const.family) else { return nil }
        
        do {
            let family = try JSONDecoder().decode(WidgetFamily.self, from: data)
            return family
        } catch {
            print("Cannot load widget family \n \(error)")
        }
        
        return nil
    }
    
    func loadWidget() -> [WidgetFamily: PhotoWidgetData] {
        guard let data = store.data(forKey: Const.configuration) else {
            print("no data saved for widget")
            return [:]
        }
        
        do {
            let conf = try JSONDecoder().decode([WidgetFamily: PhotoWidgetData].self, from: data)
            return conf
        } catch {
            print("Cannot load configuration \n \(error)")
        }
        
        return [:]
    }
    
    func save(configuration: [WidgetFamily: PhotoWidgetData]) {
        DispatchQueue.global(qos: .utility).async {
            do {
                let data = try JSONEncoder().encode(configuration)
                store.setValue(data, forKey: Const.configuration)
            } catch {
                print("Cannot save configuration \n \(error)")
            }
        }
    }
    
    func save(family: WidgetFamily) {
        DispatchQueue.global(qos: .utility).async {
            do {
                let data = try JSONEncoder().encode(family)
                store.setValue(data, forKey: Const.family)
            } catch {
                print("Cannot save widget family \n \(error)")
            }
        }
    }
    
    struct Const {
        static let configuration = "configuration"
        static let family = "family"
    }
}

extension WidgetFamily: Codable {}
