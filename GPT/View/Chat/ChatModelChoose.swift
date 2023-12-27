//
//  ModelChoose.swift
//  GPT
//
//  Created by 郭睿 on 2023/12/26.
//

import SwiftUI

struct ChatModelChoose: View {
    @ObservedObject var chatVM: ChatVM
    @ObservedObject var userVM: UserVM
    var body: some View {
        NavigationView {
            let width: CGFloat = 80
            VStack{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: width))]) {
                    ForEach(chatVM.models.indices) { index in
                        NavigationLink(destination: Chat(chatVM: chatVM, 
                                                         userVM: userVM,
                                                         modelID: chatVM.models[index].modelID)) {
                            ChatModelMsg(model: chatVM.models[index])
                        }
                    }
                }
                Spacer()
            }.navigationBarTitle("选择聊天模型")
        }
    }
}

#Preview {
    ChatModelChoose(chatVM: ChatVM(),userVM: UserVM())
}
