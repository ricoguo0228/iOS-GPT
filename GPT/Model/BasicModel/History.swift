//
//  History.swift
//  GPT
//
//  Created by 郭睿 on 2023/12/22.
//

import Foundation

struct History: Identifiable {
    let id: Int
    let askContent: String
    let replyContent: String
    let userId: Int
    let time: Date
}
