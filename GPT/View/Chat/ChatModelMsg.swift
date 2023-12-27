//
//  ChatModelMsg.swift
//  GPT
//
//  Created by 郭睿 on 2023/12/26.
//

import SwiftUI

struct ChatModelMsg: View {
    let model: ModelMsg
    
    var body: some View {
        VStack{
            Text(model.modelEmoji)
                .font(.system(size: 48))
            Text(model.modelMsg)
                .font(.system(size: 16))
        }
        
    }
}

#Preview {
    ChatModelMsg(model: ModelMsg(id: 1, modelEmoji: "😄", modelMsg: "芜湖",modelID: 1))
}
