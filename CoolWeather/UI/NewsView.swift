//
//  NewsView.swift
//  CoolWeather
//
//  Created by RND on 2021/2/1.
//

import SwiftUI
import Alamofire
import Kingfisher

struct NewsView: View {
    
    var image: String
    
    @EnvironmentObject var content: Content
    
    let news_url = "https://383659fe-4e5a-4616-923e-83ca7a6242c5.bspapp.com/http/api/v1/news?args=getNews"
    
    // 获取model
    @State private var items = [Datam]()
    

    var body: some View {
        NavigationView{
            ScrollView{
                ForEach(items){ item in
                    VStack(alignment:.leading, spacing: 10){
                        
                        Text(item.title).font(.title)
                            
                        // 如果当前的count>0 执行操作
                        /*if item.news.count > 0 {
                            item.news[0].c != "" ?
                            Text(item.news[0].c) : Text("")
                        }else{
                            Text("")
                        }
                        */
                        //self.content.handlerImage(news: item.news)
                        
                        //分割线
                        Divider()
                        
                        
                        NewsImageCell(images: self.content.handlerImage(news: item.news), width: UIScreen.main.bounds.width-30)
                        
                    }
                }
                
            }.navigationBarTitle("新闻")
            .onAppear{
                print("我执行了几次")
                self.getNews()
            }
        }
    }
    
    
    /**
     得到新闻列表
     */
    func getNews(){
        let headers: HTTPHeaders = [
            "Content-Type":"application/json"
        ]
        
        ApiUtils.shared.netWork(url: news_url, method: .get, params: nil, headers: headers, ecoding: URLEncoding.default, success: {
            result in
            
            guard let news = try? JSONDecoder().decode(NewsModel.self, from: result) else{
                return
            }
   
            DispatchQueue.main.async {
                self.items = news.data
                print("items count is \(self.items.count)")
            }
        }, error: { error in
            print("error is \(error)")
        })
    }
}

struct NewsView_Previews: PreviewProvider {
    
    static let content = Content()
    
    static var previews: some View {
        NewsView(image: self.content.images[0]).environmentObject(content)
    }
}
