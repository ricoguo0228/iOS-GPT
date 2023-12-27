//
//  AFModel.swift
//  GPT
//
//  Created by 郭睿 on 2023/12/25.
//

import Foundation
import Alamofire

enum MethodType {
    case get
    case post
}

class AlamofireLayer{
    static func getRequest(URLString: String, parameters: [String : Any]?, callback: @escaping (Any) -> ()) {
        AlamofireLayer.requestData(MethodType.get, URLString: URLString, parameters: parameters) { callback($0) }
    }
    
    static func postRequest(URLString: String, parameters: [String : Any]?, callback: @escaping (Any) -> ()) {
        AlamofireLayer.requestData(MethodType.post, URLString: URLString, parameters: parameters) { callback($0) }
    }
    
    static func requestData(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil,
                            finishedCallback :@escaping (_ result : Any) -> ()) {
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        let headers: HTTPHeaders = [
            "Content-Type": "application/json;charset=utf-8",
        ]
        if method == .get {
            Alamofire.AF
                .request(URLString, method: method, parameters: parameters,headers:headers)
                .responseJSON { (response) in
                    debugPrint(response)
                    switch response.result {
                    case .success(let json):
                        finishedCallback(json)
                        break
                    case .failure(let error):
                        finishedCallback(error)
                        break
                    }
                    
                }
        } else {
            Alamofire.AF
                .request(URLString, method: method, parameters: parameters,encoding: JSONEncoding.default,headers:headers)
                .responseJSON { (response) in
                    debugPrint(response)
                    switch response.result {
                    case .success(let json):
                        finishedCallback(json)
                        break
                    case .failure(let error):
                        finishedCallback(error)
                        break
                    }
                    
                }
        }
        
    }

}

