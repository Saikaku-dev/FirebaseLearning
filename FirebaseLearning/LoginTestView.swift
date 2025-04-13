//
//  LoginTestView.swift
//  FirebaseLearning
//
//  Created by cmStudent on 2025/04/08.
//

import SwiftUI
import FirebaseAuth

class FireAuth:ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isSignIn: Bool = false
    @Published var userEmail = ""
    
    func login() {
        Task {
            do {
                try await Auth.auth().createUser(withEmail: email, password: password)
                try await Auth.auth().signIn(withEmail: email, password: password)
                print("succes")
            } catch {
                print("error \(error.localizedDescription)")
            }
        }
    }
    func getCurrentUser() {
        guard let currentUser = Auth.auth().currentUser else {return}
        userEmail = currentUser.email ?? ""
    }
    
    func SignOut() {
        userEmail = ""
    }
}


struct LoginTestView: View {
    @StateObject var vm = FireAuth()
    
    var body: some View {
        VStack {
            textField(title: "EMAIL", text: $vm.email)
            textField(title: "PASSWORD", text: $vm.password)
            
            Button {
                vm.login()
                vm.isSignIn = true
            } label: {
                Text("ログイン")
            }
            
            Button {
                vm.SignOut()
            } label: {
                Text("SignOut")
            }
            
        }
        .frame(width: 300)
        .fullScreenCover(isPresented: $vm.isSignIn) {
            MyPageView()
        }
        Text("アカウント：\(vm.userEmail)")
        
        
            .onAppear {
                vm.getCurrentUser()
            }
    }
    
    @ViewBuilder
    func textField(title: String, text: Binding<String>) -> some View {
        Text(title)
            .font(.title)
        TextField(title,text: text)
            .padding(6)
            .border(.gray)
    }
}

struct MyPageTestView: View {
    let list:[String] = ["email","ニックネーム","性別"]
    
    var body: some View {
        VStack {
            ForEach(list, id: \.self) { info in
                Text(info)
            }
        }
    }
}

#Preview {
    LoginTestView()
}
