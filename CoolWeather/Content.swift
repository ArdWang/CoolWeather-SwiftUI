//
//  Content.swift
//  CoolWeather
//
//  Created by RND on 2021/2/1.
//

import SwiftUI

class Content: ObservableObject {
    
    var news_url = "https://383659fe-4e5a-4616-923e-83ca7a6242c5.bspapp.com/http/api/v1/news?args=getNews"
    
    @Published var images = [String]()
    
    // 处理图片数据
    func handlerImage(news: [News])->[String]{
        images.removeAll()
        for m in news{
            if m.j != ""{
                images.append(m.j)
            }
        }
        
        return images
    }
}


