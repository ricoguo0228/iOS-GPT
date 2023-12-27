//
//  ContentView.swift
//  GPT
//
//  Created by 郭睿 on 2023/12/22.
//

import SwiftUI
import SwiftData
import Foundation

struct MainView: View {
    @ObservedObject var chatVM: ChatVM = ChatVM()
    @ObservedObject var userVM: UserVM = UserVM()
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            // 第一个标签
            NavigationView {
                VStack{
                    ChatModelChoose(chatVM: chatVM, userVM: userVM)
                }
            }.tabItem {
                Image(systemName: "message")
                Text("聊天")
            }.tag(0)
            
            NavigationView {
                Profile(userVM: userVM)
                    .navigationBarTitle(userVM.currentUser?.username ?? "未登录")
            }.tabItem {
                Image(systemName: "person.crop.circle")
                Text("我")
            }.tag(1)
        }
    }
}

#Preview {

    return MainView()
}
