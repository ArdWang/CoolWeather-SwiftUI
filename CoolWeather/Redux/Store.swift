//
//  Store.swift
//  CoolWeather
//
//  Created by 沉寂 on 2021/2/1.
//

import Foundation
import Combine
import Alamofire
import AVKit

class Store: ObservableObject {
    static let shared = Store()
    private init(){}
    
    @Published var appState = AppState()

}

extension Store{
    
    //获取网络数据
    func getGank(page:Int){
        
        self.appState.gank.isShowing = true
        
        let headers: HTTPHeaders = [
            "Content-Type":"application/json"
        ]
        
        let baseUrl = "https://gank.io/api/v2/data/category/Girl/type/Girl/"
        
        ApiUtils.shared.netWork(url: baseUrl+"page/\(page)/count/10", method: .get, params: nil, headers: headers, ecoding: URLEncoding.default, success: { result in

            guard let gank = try? JSONDecoder().decode(GankModel.self, from: result) else{
                return
            }

            DispatchQueue.main.async {
                self.appState.gank.model = gank
                if self.appState.gank.page == 1 {
                    self.appState.gank.items = self.appState.gank.model.data
                }else{
                    self.appState.gank.items += self.appState.gank.model.data
                }
                self.appState.gank.isShowing = false
                
                // 没有更多了
                if self.appState.gank.model.pageCount == self.appState.gank.page {
                    self.appState.gank.noMore = true
                }
                
            }
            
        }, error: { error in
            print("error is \(error)")
        })
    }
    
    /**
        加载更多的Gank数据
     */
    func loadMoreGank(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.appState.gank.page += 1
            self.getGank(page: self.appState.gank.page)
        }
    }
    
    
    /**
        获取当前的新闻数据
     */
    func getNews(){
        
        let news_url = "https://383659fe-4e5a-4616-923e-83ca7a6242c5.bspapp.com/http/api/v1/news?args=getNews"
        
        let headers: HTTPHeaders = [
            "Content-Type":"application/json"
        ]
        
        ApiUtils.shared.netWork(url: news_url, method: .get, params: nil, headers: headers, ecoding: URLEncoding.default, success: {
            result in
            
            guard let news = try? JSONDecoder().decode(NewsModel.self, from: result) else{
                return
            }
   
            DispatchQueue.main.async {
                self.appState.news.items = news.data
                print("items count is \(self.appState.news.items.count)")
                
                //self.combineImage(news: self.appState.news.items.)
                
            }
        }, error: { error in
            print("error is \(error)")
        })
    }
    
    // 图片处理
    func combineImage(news: [News]) -> [String]{
        var images:[String] = []
        for m in news{
            if m.j != ""{
                images.append(m.j)
            }
        }
        return images
    }
    
    // 播放视频
    func startPlayer(_ item: String) -> AVPlayer{
        var player = AVPlayer(url: URL(string: "https://vt1.doubanio.com/202102041554/9f4a07f6e4e46ee29456d6b9674f6bd5/view/movie/M/402640955.mp4")!)
        if(item != ""){
            player = AVPlayer(url: URL(string: item)!)
        }
        return player
    }
}
