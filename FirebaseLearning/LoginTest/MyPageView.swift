//
//  MyPageView.swift
//  FirebaseLearning
//
//  Created by cmStudent on 2025/04/08.
//

import SwiftUI
import FirebaseAuth

class UserInfo:ObservableObject {
    @Published var userEmail:String = ""
    @Published var userNickName:String = ""
    
    func getCurrentUser() {
        guard let currentUser = Auth.auth().currentUser else { return }
        userEmail = currentUser.email ?? ""
    }
}

struct MyPageView: View {
    @StateObject private var userInfo = UserInfo()
    var body: some View {
        infoFormat(email: $userInfo.userEmail, name: $userInfo.userNickName)
    }
}

extension MyPageView {
    @ViewBuilder
    func infoFormat(email:Binding<String>, name:Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            
            HStack(alignment: .center) {
                Text("メール")
                    .frame(width: 100, alignment: .leading)
                    .foregroundColor(.gray)
                Text(email.wrappedValue)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.bottom, 4)
            
            HStack(alignment: .center) {
                Text("ニックネーム")
                    .frame(width: 100, alignment: .leading)
                    .foregroundColor(.gray)
                TextField("ニックネームを入力", text: name)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: .infinity)
            }
            .padding(.bottom, 4)
            
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
        )
        .onAppear() {
            userInfo.getCurrentUser()
        }
    }
}
#Preview {
    MyPageView()
}

