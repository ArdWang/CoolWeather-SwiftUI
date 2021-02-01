//
//  TabarView.swift
//  CoolWeather
//
//  Created by RND on 2021/1/14.
//

import SwiftUI

struct TabarView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.gray
    }
    
    // 默认为第0个选中
    @State private var selectTab = 0
    
    
    var body: some View {
        TabView(selection: $selectTab){
            NewsView(image: "")
                .tabItem {
                    VStack {
                        Image(systemName: "newspaper")
                        Text("新闻")
                    }
                }.tag(0)
            
            BView()
                .tabItem {
                    VStack {
                        Image(systemName: "cloud")
                        Text("天气")
                    }
                }.tag(1)
            
            GankView()
                .tabItem {
                    VStack {
                        Image(systemName: "heart")
                        Text("干货")
                    }
                }.tag(2)
        }
    }
}

struct TabarView_Previews: PreviewProvider {
    static var previews: some View {
        TabarView()
    }
}
