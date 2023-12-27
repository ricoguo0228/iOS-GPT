//
//  ChatView.swift
//  GPT
//
//  Created by 郭睿 on 2023/12/22.
//

import SwiftUI

struct Chat: View {
    @ObservedObject var chatVM: ChatVM
    @ObservedObject var userVM: UserVM
    let modelID: Int
    @State private var inputText = ""
    @State private var alartMessage = ""
    @State private var isShowAlert = false
    
    var body: some View {
        
        ZStack{
            VStack{
                if let singleMsgs = chatVM.SingleMsgs[modelID] {
                    List(singleMsgs) { message in
                        Message(singleMsg: message)
                    }
                    .listStyle(.grouped)
                }else{
                    Text("暂无聊天记录")
                }
                Spacer()
                HStack{
                    Button("📎"){
                        
                    }
                    .buttonStyle(.plain)
                    TextField(
                        "在这里写下您要问的问题",
                        text: $inputText,
                        onCommit: {
                            UIApplication.shared.endEditing()
                        })
                    .padding(4)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("发送"){
                        afterCommit()
                        inputText = ""
                    }
                    .buttonStyle(.borderedProminent)
                    
                }
                .padding()
                .alert(isPresented: $isShowAlert) {
                    Alert(title: Text("提示"),
                          message: Text(alartMessage)
                    )
                }
            }
        }
        
    }
    
    func afterCommit() {
        if let user = userVM.currentUser {
            if inputText.elementsEqual("") {
                alartMessage = "您还没有输入您的问题呢"
                isShowAlert = true
                return
            }
            chatVM.chat(modelID:modelID,askContent: inputText) { success in
                if !success {
                    alartMessage = "服务器开小差了，请稍后再试"
                    isShowAlert = true
                }
            }
        } else {
            alartMessage = "您还没有登录！"
            isShowAlert = true
        }
    }
    
}

#Preview {
    Chat(chatVM: ChatVM(), userVM: UserVM(),modelID: 1)
}
