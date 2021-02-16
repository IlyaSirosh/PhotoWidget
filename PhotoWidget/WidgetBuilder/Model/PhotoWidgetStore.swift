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
        guard let data = store.data(forKey: Const.family) else {
            print(StoreError.noFamilyError)
            return nil
        }
        
        do {
            let family = try JSONDecoder().decode(WidgetFamily.self, from: data)
            return family
        } catch {
            print(StoreError.familyDecodeError)
        }
        
        return nil
    }
    
    func loadWidget() -> [WidgetFamily: PhotoWidgetData] {
        guard let data = store.data(forKey: Const.configuration) else {
            print(StoreError.noConfigurationError)
            return [:]
        }
        
        do {
            let conf = try JSONDecoder().decode([WidgetFamily: PhotoWidgetData].self, from: data)
            return conf
        } catch {
            print(StoreError.configurationDecodeError)
        }
        
        return [:]
    }
    
    func save(configuration: [WidgetFamily: PhotoWidgetData]) {
        DispatchQueue.global(qos: .utility).async {
            do {
                let data = try JSONEncoder().encode(configuration)
                store.setValue(data, forKey: Const.configuration)
            } catch {
                print(StoreError.configurationSaveError)
            }
        }
    }
    
    func save(family: WidgetFamily) {
        DispatchQueue.global(qos: .utility).async {
            do {
                let data = try JSONEncoder().encode(family)
                store.setValue(data, forKey: Const.family)
            } catch {
                print(StoreError.familySaveError)
            }
        }
    }
    
    struct Const {
        static let configuration = "configuration"
        static let family = "family"
    }
    
    enum StoreError: String, Error {
        case configurationSaveError = "Cannot save configuration"
        case familySaveError = "Cannot save widget family"
        case noConfigurationError = "Cannot load configuration: no data available"
        case noFamilyError = "Cannot load family: no data available"
        case configurationDecodeError = "Cannot decode configuration"
        case familyDecodeError = "Cannot decode widget family"
    }
}

extension WidgetFamily: Codable {}
