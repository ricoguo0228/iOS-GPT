//
//  LoginView.swift
//  GPT
//
//  Created by 郭睿 on 2023/12/22.
//


import SwiftData
import SwiftUI
struct Login: View {
    @ObservedObject var userVM: UserVM
    @State private var userPassword: String = ""
    @State private var userAccount: String = ""
    @State private var isShowAlert: Bool = false
    @State private var alertMessage: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    VStack{
                        TextField("输入账户", text: $userAccount)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("输入密码", text: $userPassword)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }.onSubmit {
                        UIApplication.shared.endEditing()
                    }
                    HStack {
                        Button(action: {
                            userVM.userLogin(userAccount: userAccount, userPassword: userPassword) { success in
                                if success {
                                    showAlert(message: "登录成功")
                                    dismiss()
                                } else {
                                    showAlert(message: "登录失败，请检查信息")
                                }
                            }
                        }, label: {
                            Text("登录")
                        })
                        .buttonStyle(.bordered)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        Button(action: {
                            dismiss()
                        }, label: {
                            Text("取消")
                        })
                    }
                    Spacer()
                }
                .padding()
                .navigationTitle("登录")
                .alert(isPresented: $isShowAlert) {
                    Alert(title: Text("登录信息"), message: Text(alertMessage))
                }
            }
        }
    }
    
    func showAlert(message: String) {
        alertMessage = message
        isShowAlert = true
    }
}

// 在预览模式下添加一个按钮来模拟登录
struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login(userVM: UserVM())
    }
}
