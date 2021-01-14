//
//  NavigationBar.swift
//  CoolWeather
//
//  Created by RND on 2021/1/14.
//

import SwiftUI

struct NavigationBar: View {
    
    @State var text = "新闻"
    
    var body: some View {
        HStack(alignment:.top, spacing: 0){
            Text(text).foregroundColor(.white)
        }.background(Color.black)
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar(text: "新闻")
    }
}
