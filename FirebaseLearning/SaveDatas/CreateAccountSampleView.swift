//
//  CreateAccountSampleView.swift
//  FirebaseLearning
//
//  Created by cmStudent on 2025/04/27.
//

import SwiftUI
import Observation

struct InfoField: Identifiable {
    let id = UUID()
    var name: String
    var mail: String
    var password: String
    var passwordCheck: String
}

@Observable
class CreateAccountSampleViewModel {
    var user:InfoField = InfoField(name: "", mail: "", password: "", passwordCheck: "")
}

struct CreateAccountSampleView: View {
    @State private var vm = CreateAccountSampleViewModel()
    let titleList: [String] = ["ニックネーム", "メール", "パスワード","パスワード確認"]
    
    var body: some View {
        VStack {
            ForEach(titleList.indices, id: \.self) { index in
                inputRow(title: titleList[index], text: binding(for: index))
            }
            
            Button(action: {
                
            }) {
                Text("作成")
                    .buttonStyle()
            }
            
            Text("または")
            
            HStack {
                
                Text("Apple")
                    .buttonStyle()
                
                Text("Google")
                    .buttonStyle()
            }
            
        }
    }
}

extension CreateAccountSampleView {
    
    func binding(for index: Int) -> Binding<String> {
        switch index {
        case 0:
            return $vm.user.name
        case 1:
            return $vm.user.mail
        case 2:
            return $vm.user.password
        case 3:
            return $vm.user.passwordCheck
        default:
            return .constant("")
        }
    }
    
    func inputRow(title: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            TextField(title, text: text)
                .textFieldStyle(.roundedBorder)
        }
        .padding(.bottom, 10)
    }
}

extension View {
    func buttonStyle() -> some View {
        self
            .foregroundColor(.white)
            .padding()
            .padding(.horizontal,28)
            .background(Color.black)
            .cornerRadius(28)
    }
}


#Preview {
    CreateAccountSampleView()
}
