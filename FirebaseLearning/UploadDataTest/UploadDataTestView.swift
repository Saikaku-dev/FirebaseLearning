//
//  TestDataView.swift
//  FirebaseLearning
//
//  Created by cmStudent on 2025/04/13.
//

import SwiftUI

struct UploadDataTestView: View {
    @StateObject private var ctl = UploadTextManager()
    @StateObject private var imgctl = UploadImageManager()
    @State private var inpuText = ""
    @State private var image:UIImage?
    @State private var showLibrary:Bool = false
    
    var body: some View {
        VStack {
            if let img = image {
                Image(uiImage: img)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
            }
            
            Button {
                showLibrary = true
            } label: {
                Text("写真を選ぶ")
            }.padding(.bottom)
            
            TextField("テキスト",text:$inpuText)
                .background(Color(.systemGray6))
                .frame(width:200)
                .padding(.bottom)
            Button {
                ctl.uploadText(text: inpuText) { success in
                    if success {
                        inpuText = ""
                        print("Data saved successfully")
                    }
                }
                if let image = image {
                    imgctl.uploadImage(image: image) { urlString in
                        print(urlString ?? "Empty")
                    }
                }
                
            } label: {
                Text("upload")
            }
        }
        .sheet(isPresented: $showLibrary) {
            PhotoLibraryManager(image: $image)
                .ignoresSafeArea()
        }
        .onAppear() {
            ctl.loadText { savedMsg in
                if let savedMsg = savedMsg {
                    inpuText = savedMsg
                }
            }
        }
    }
}

#Preview {
    UploadDataTestView()
}
