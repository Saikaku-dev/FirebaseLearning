//
//  TestDataView.swift
//  FirebaseLearning
//
//  Created by cmStudent on 2025/04/13.
//

import SwiftUI

struct UploadDataTestView: View {
    @StateObject private var ctl = UploadTextManager()
    @State private var inpuText = ""
    
    var body: some View {
        HStack {
            TextField("テキスト",text:$inpuText)
                .background(Color(.systemGray6))
                .frame(width:200)
            Button {
                //upload text
                ctl.saveText(text: inpuText) { success in
                    if success {
                        inpuText = ""
                        print("Data saved successfully")
                    }
                }
            } label: {
                Text("upload")
            }
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
