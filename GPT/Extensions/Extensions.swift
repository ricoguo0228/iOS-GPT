//
//  Extensions.swift
//  GPT
//
//  Created by 郭睿 on 2023/12/26.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
      UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.endEditing(true)
    }
}
