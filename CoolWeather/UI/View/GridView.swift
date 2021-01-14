//
//  GridView.swift
//  CoolWeather
//
//  Created by RND on 2021/1/14.
//  自定义GridView

import SwiftUI

struct GridView: View {
    
    // 默认是3个
    var itemRow = 3
    
    // 默认当前的内容View
    var contentView:[AnyView] = []
    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}
