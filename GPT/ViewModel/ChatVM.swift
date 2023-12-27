//
//  ChatVM.swift
//  GPT
//
//  Created by 郭睿 on 2023/12/23.
//

import Foundation
import Alamofire
import SwiftyJSON
import SwiftUI

class ChatVM: ObservableObject {
    @Published private var chatModel: ChatModel
    private let modelEmojis: [String] = ["😀","🧐"]
    private let modelMsgs: [String] = ["畅聊专家","博学者"]
    private let modelIDs: [Int] = [1,2]
    
    var SingleMsgs: [Int : [SingleMsg]] {
        chatModel.SingleMsgs
    }
    var models: [ModelMsg] {
        chatModel.models
    }
    
    init() {
        var models: [ModelMsg] = []
        for index in modelEmojis.indices {
            let model: ModelMsg = ModelMsg(id: index, modelEmoji: modelEmojis[index], modelMsg: modelMsgs[index],modelID: modelIDs[index])
            models.append(model)
        }
        self.chatModel = ChatModel(SingleMsgs:[1:[SingleMsg(id: 1, content: "你好", isUser: true)],2:[]], models: models)
    }
    
    func chat(modelID: Int,askContent: String,completion: @escaping (Bool) -> Void){
        let url = Constants.backendUrl+"/chat/gen"
        AlamofireLayer.postRequest(URLString: url,
                                   parameters:["id":modelID,"askContent":askContent]) {(response) in
            
            let responseData = JSON(response)
            let code: Int = responseData["code"].intValue
            if code==20000 {
                let id: Int = responseData["data"]["id"].intValue
                let askContent: String = responseData["data"]["askContent"].stringValue
                let replyContent: String = responseData["data"]["replyContent"].stringValue
                self.divideAndAddToSingleMsg(id: id, askContent: askContent, replyContent: replyContent,modelID: modelID)
            } else {
                //修改线程UI，显示失败
                completion(false)
            }
        }
    }
    
    func divideAndAddToSingleMsg(id: Int, askContent: String, replyContent: String,modelID: Int){
        let singleMsgAsk: SingleMsg = SingleMsg(id: id, content: askContent, isUser: true)
        let singleMsgRep: SingleMsg = SingleMsg(id: id + 1, content: replyContent, isUser: false)
        chatModel.addSingleMsg(singleMsg: singleMsgAsk,modelID: modelID)
        chatModel.addSingleMsg(singleMsg: singleMsgRep,modelID: modelID)
    }
}
