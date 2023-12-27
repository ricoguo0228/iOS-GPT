//
//  Message.swift
//  GPT
//
//  Created by 郭睿 on 2023/12/23.
//

import Foundation

struct SingleMsg: Identifiable {
    let id: Int
    let content: String
    let isUser: Bool
}
