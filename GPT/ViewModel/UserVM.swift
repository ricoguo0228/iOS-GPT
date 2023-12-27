//
//  UserVM.swift
//  GPT
//
//  Created by 郭睿 on 2023/12/22.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserVM: ObservableObject {
    @Published private var userModel: UserModel = UserModel()
    
    var currentUser: User? {
        userModel.currentUser
    }
    
    func userLogin(userAccount: String,userPassword: String,completion: @escaping (Bool) -> Void){
        //向后端发送请求
        let url = Constants.backendUrl+"/user/login"
        AlamofireLayer.postRequest(URLString: url,
                                   parameters:["userAccount":userAccount,
                                               "userPassword":userPassword]) {(response) in
            
            let responseData = JSON(response)
            let code: Int = responseData["code"].intValue
            if code==20000 {
                self.getLoginUser(){ result in
                    completion(result)
                }
            } else {
                //修改线程UI，显示失败
                completion(false)
            }
        }
    }
    
    func userRegister(userAccount: String,userPassword: String,conformPassword: String,completion: @escaping (Bool) -> Void){
        //向后端发送请求
        let url = Constants.backendUrl+"/user/register"
        AlamofireLayer.postRequest(URLString: url,
                                   parameters:["userAccount":userAccount,
                                               "userPassword":userPassword,
                                               "conformPassword":conformPassword]) { (response) in
            let responseData = JSON(response)
            let code: Int = responseData["code"].intValue
            if code==20000 {
                //修改线程UI，显示注册成功，即将登录
                self.userLogin(userAccount: userAccount, userPassword: userPassword){ result in
                    completion(result)
                }
            } else {
                //修改线程UI，显示失败
                completion(false)
            }
        }
    }
    
    func getLoginUser(completion: @escaping (Bool) -> Void){
        //向后端发送请求
        let url = Constants.backendUrl+"/user/get/login"
        AlamofireLayer.getRequest(URLString: url, parameters: [:]) { (response) in
            let responseData = JSON(response)
            let code: Int = responseData["code"].intValue
            if code==20000 {
                self.userModel.setCurrentUser(id: responseData["data"]["id"].intValue, username: responseData["data"]["userName"].stringValue)
                completion(true)
            } else {
                //修改线程UI，显示获取用户失败
                completion(false)
            }
        }
    }
}
