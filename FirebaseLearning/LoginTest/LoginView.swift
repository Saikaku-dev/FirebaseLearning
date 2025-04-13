//
//  LoginView.swift
//  FirebaseLearning
//
//  Created by cmStudent on 2025/04/08.
//

import SwiftUI
import FirebaseAuth

class LoginInfo:ObservableObject {
    @Published var emailAdress:String = ""
    @Published var password:String = ""
    @Published var errorMessage:String = ""
    @Published var isSignIn:Bool = false
    
    @MainActor
    func login() {
        if emailAdress.isEmpty && password.isEmpty {
            testAction()
        } else {
            Task {
                do {
                    try await Auth.auth().signIn(withEmail: emailAdress, password: password)
                    self.isSignIn = true
                } catch {
                    print("error: \(error.localizedDescription)")
                    errorMessage = "emailもしくはpasswordが正しくありません。"
                }
            }
        }
    }
    
    func testAction() {
        emailAdress = "login_t@gmail.com"
        password = "123456"
    }
}

struct LoginView: View {
    @StateObject private var loginInfo = LoginInfo()
    let width = UIScreen.main.bounds.width/2
    
    var body: some View {
        VStack(alignment: .leading) {
            textFormat(title: "email", text: $loginInfo.emailAdress)
            textFormat(title: "password", text: $loginInfo.password)
            Text(loginInfo.errorMessage)
                .foregroundColor(.red)
        }
        .frame(width:width)
        .padding(.bottom,16)
        .fullScreenCover(isPresented:$loginInfo.isSignIn) {
            MyPageView()
        }
        Button(action: {
            loginInfo.login()
        }) {
            Text("ログイン")
        }
        
    }
}



extension LoginView {
    @ViewBuilder
    func textFormat(title:String, text:Binding<String>) -> some View {
        Text(title)
        TextField(title,text: text)
            .padding(6)
            .border(.black)
    }
}

#Preview {
    LoginView()
}
