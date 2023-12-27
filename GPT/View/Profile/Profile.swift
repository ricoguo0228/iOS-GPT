//
//  ProfileView.swift
//  GPT
//
//  Created by 郭睿 on 2023/12/22.
//

import SwiftData
import SwiftUI

struct Profile: View {
    @ObservedObject var userVM: UserVM
    @State private var isLoginSheetPresented = false
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    if let user = userVM.currentUser {
                        Text("欢迎,"+user.username)
                            .font(.system(size: 32))
                    }else{
                        Button("登录") {
                            isLoginSheetPresented = true
                        }
                        .buttonStyle(.bordered)
                        .sheet(isPresented: $isLoginSheetPresented) {
                            ScrollView{
                                Login(userVM: userVM)
                            }
                        }
                    }
                    Spacer()
                }
                Spacer()
            }.padding()
        }
    }
}




#Preview {
    Profile(userVM: UserVM())
}
