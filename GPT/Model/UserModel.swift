//
//  UserModel.swift
//  GPT
//
//  Created by 郭睿 on 2023/12/25.
//

import Foundation
import Alamofire
import SwiftyJSON

struct UserModel {
    var currentUser: User?
    mutating func setCurrentUser(id: Int,username: String){
        self.currentUser = User(id: id,
                           username: username,
                           userAccount: "",
                           userPassword: "")
    }
}
