//
//  UploadImageTest.swift
//  FirebaseLearning
//
//  Created by cmStudent on 2025/04/13.
//

import FirebaseStorage
import FirebaseFirestore

struct UploadImageManager {
    func uploadImage(image: UIImage, completion: @escaping(String?) -> Void) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imageData = image.jpegData(compressionQuality: 0.8)
        
        let imageRef = storageRef.child("images/\(UUID().uuidString).jpg")
    }
}
