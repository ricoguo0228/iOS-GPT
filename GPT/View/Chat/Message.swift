//
//  Message.swift
//  GPT
//
//  Created by 郭睿 on 2023/12/23.
//


import SwiftUI

struct Message: View {
    var singleMsg: SingleMsg
    var body: some View {
        VStack {
            HStack {
                if singleMsg.isUser {
                    Text("🧐 您：").font(.title3)
                }else{
                    Text("🥳 GPT：").font(.title3)
                }
                Spacer()
            }.padding(.bottom)
            HStack {
                if singleMsg.isUser {
                    Text("        "+singleMsg.content)
                        .font(.system(size: msgConstants.fontSize))
                }else{
                    Text("        "+singleMsg.content)
                        .font(.system(size: msgConstants.fontSize))
                        
                }
                Spacer()
            }
        }
    }
}
struct msgConstants {
    static let fontSize:CGFloat = 18
    static let timeInterval: TimeInterval = 0.05
}

#Preview {
    Message(singleMsg: SingleMsg(id: 12, content: "你好啊", isUser: true))
}
