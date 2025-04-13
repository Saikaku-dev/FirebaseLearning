//
//  PhotoLibraryManager.swift
//  FirebaseLearning
//
//  Created by cmStudent on 2025/04/13.
//

import SwiftUI
import PhotosUI

struct PhotoLibraryManager: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator:NSObject,PHPickerViewControllerDelegate {
        let parent: PhotoLibraryManager
        init(_ parent: PhotoLibraryManager) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { img, _ in
                    DispatchQueue.main.async {
                        self.parent.image = img as? UIImage
                    }
                }
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
