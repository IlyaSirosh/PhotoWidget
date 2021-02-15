//
//  UpslashImagePicker.swift
//  PhotoWidget
//
//  Created by Illya Sirosh on 15.02.2021.
//

import SwiftUI
import UnsplashPhotoPicker

struct UpsplashImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var url: URL?
    
    let accessKey = "8sRN9fsTYSb_8wRAbGMqToBeWoJHcjxQA78-l_g0tN0"
    let secretKey = "2tlJT_r80uyjDAggjfFV__VCF-Dv43WHLBuh9oJMJJo"
    
    func makeUIViewController(context: Context) -> UnsplashPhotoPicker {
        let configuration = UnsplashPhotoPickerConfiguration(accessKey: accessKey, secretKey: secretKey)
        
        let picker: UnsplashPhotoPicker  = UnsplashPhotoPicker(configuration: configuration)
        picker.photoPickerDelegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UnsplashPhotoPicker, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: UnsplashPhotoPickerDelegate {
        var parent: UpsplashImagePicker
        
        init(_ parent: UpsplashImagePicker){
            self.parent = parent
        }
        
        func unsplashPhotoPicker(_ photoPicker: UnsplashPhotoPicker, didSelectPhotos photos: [UnsplashPhoto]) {
            print("Unsplash photo picker did select \(photos.count) photo(s)")
            
            if let photo = photos.first {
                parent.url = photo.urls[.full]
                print(photo)
            }

            parent.presentationMode.wrappedValue.dismiss()
        }

        func unsplashPhotoPickerDidCancel(_ photoPicker: UnsplashPhotoPicker) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

}
