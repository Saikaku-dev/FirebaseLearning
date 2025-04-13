//
//  ContentView.swift
//  FirebaseLearning
//
//  Created by cmStudent on 2025/04/08.
//


class TryLearningClass {
    
    
    func throwFunc(error: Bool) throws -> String {
        if error {
            throw URLError(.unknown)
        } else {
            return "Success"
        }
    }
    
    
    func callThrowsfunc() {
        
        let successString = try? throwFunc(error: true)
        
        
        do {
            let successString = try throwFunc(error: true)
        } catch {
            print("Error\(error.localizedDescription)")
        }
    }
    
    
}

import SwiftUI
import FirebaseFirestore

struct ContentView: View {
    var body: some View {
        VStack {
            Button {
                getData()
            } label: {
                Text("Add data")
            }
            
        }
        .padding()
    }
    
    
    func getData() {
        Task {
            let snapshot = try? await Firestore.firestore().collection("Collection").document("31098401234-581").getDocument()
            guard let data = snapshot?.data() else {return}
            let name = data["name"] as? String
            print(name ?? "Can't get data.")
            
        }
        
    }
    
    func writeData() {
        
    }
    
}

#Preview {
    ContentView()
}
