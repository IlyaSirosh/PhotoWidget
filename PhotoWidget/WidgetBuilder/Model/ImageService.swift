//
//  ImageService.swift
//  PhotoWidget
//
//  Created by Illya Sirosh on 16.02.2021.
//

import Foundation

class ImageService {
    
    
    func saveImage(url: URL, completion: @escaping (Result<URL, Error>) -> Void) {
        
        func sendResult(_ result: Result<URL, Error>) {
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        DispatchQueue.global(qos: .utility).async {
            guard let imageData = try? Data(contentsOf: url) else {
                sendResult(.failure(ServiceError.loadError))
                return
            }
            guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                sendResult(.failure(ServiceError.directoryError))
                return
            }
            
            let fileName = url.pathComponents.last!
            let fileURL = documentsDirectory.appendingPathComponent(fileName)
            do {
                try imageData.write(to: fileURL)
                sendResult(.success(fileURL))
            } catch {
                sendResult(.failure(ServiceError.saveError))
            }
        }
    }
    
    
    func removeImage(url: URL) {
        DispatchQueue.global(qos: .utility).async {
            do {
                try FileManager.default.removeItem(at: url)
            } catch {
                print(ServiceError.removeError.rawValue)
            }
        }
    }
    
    
    enum ServiceError: String, Error {
        case saveError = "Cannot save image locally"
        case loadError = "Cannot load data from URL"
        case directoryError = "Cannot get directory to save image"
        case removeError = "Cannot remove image"
    }
}
