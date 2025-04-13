//
//  UploadTextTest.swift
//  FirebaseLearning
//
//  Created by cmStudent on 2025/04/13.
//

import FirebaseFirestore

class UploadTextManager:ObservableObject {
    
    func uploadText(text: String, completation: @escaping(Bool) -> Void) {
        let db = Firestore.firestore()
        
        db.collection("Collection").document("Text").setData(["message": text]) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completation(false)
            } else {
                completation(true)
            }
        }
    }
    
    func loadText(completion: @escaping (String?) -> Void) {
        let db = Firestore.firestore()
        
        db.collection("Collection").document("Text").getDocument { msg,error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
            } else {
                if let document = msg, document.exists {
                    let text = document.data()?["message"] as? String
                    completion(text)
                } else {
                    completion(nil)
                }
            }
        }
    }
}


