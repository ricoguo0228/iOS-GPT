//
//  ChatModel.swift
//  GPT
//
//  Created by 郭睿 on 2023/12/23.
//

import Foundation

struct ChatModel {
    private(set) var SingleMsgs: [Int : [SingleMsg]]
    private(set) var models: [ModelMsg]
    
    mutating func addSingleMsg(singleMsg: SingleMsg,modelID: Int){
        SingleMsgs[modelID]?.append(singleMsg)
    }
}
