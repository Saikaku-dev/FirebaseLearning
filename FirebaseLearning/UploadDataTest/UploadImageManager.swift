//
//  UploadImageTest.swift
//  FirebaseLearning
//
//  Created by cmStudent on 2025/04/13.
//

import FirebaseStorage
import FirebaseFirestore

class UploadImageManager:ObservableObject {
    func uploadImage(image: UIImage, completion: @escaping(String?) -> Void) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(nil)
            return
        }
        
        let imageRef = storageRef.child("images/\(UUID().uuidString).jpg")
        
        imageRef.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("上传失败: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            imageRef.downloadURL { url, error in
                if let url = url {
                    completion(url.absoluteString) //urlを返す
                } else {
                    completion(nil)
                }
            }
        }
    }
}
