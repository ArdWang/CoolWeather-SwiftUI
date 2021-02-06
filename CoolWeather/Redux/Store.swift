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
    
    
    /**获取天气的请求信息*/
    //==========================================天气处理模块========================
    func getProvince(){
        let guolin_url = "http://guolin.tech/api/china"
        
        let headers: HTTPHeaders = [
            "Content-Type":"application/json"
        ]
        
        ApiUtils.shared.netWork(url: guolin_url, method: .get, params: nil, headers: headers, ecoding: URLEncoding.default, success: {
            result in
            
            guard let province = try? JSONDecoder().decode([Province].self, from: result) else{
                return
            }
   
            DispatchQueue.main.async {
                //self.appState.weather.currentLeavel = 0
                self.appState.weather.provices = province
                
                print("items count is \(self.appState.weather.provices.count)")
                
            }
        }, error: { error in
            print("error is \(error)")
        })
    }
    
    func getCity(pid: String){
        let guolin_url = "http://guolin.tech/api/china/" + pid
        
        let headers: HTTPHeaders = [
            "Content-Type":"application/json"
        ]
        
        ApiUtils.shared.netWork(url: guolin_url, method: .get, params: nil, headers: headers, ecoding: URLEncoding.default, success: {
            result in
            
            guard let city = try? JSONDecoder().decode([City].self, from: result) else{
                return
            }
   
            DispatchQueue.main.async {
                //self.appState.weather.currentLeavel = 1
                self.appState.weather.cities = city
               
                print("items count is \(self.appState.weather.cities.count)")
                
            }
        }, error: { error in
            print("error is \(error)")
        })
    }
    
    func getCountry(pid: String, cid: String){
        let guolin_url = "http://guolin.tech/api/china/" + pid+"/" + cid
        
        let headers: HTTPHeaders = [
            "Content-Type":"application/json"
        ]
        
        ApiUtils.shared.netWork(url: guolin_url, method: .get, params: nil, headers: headers, ecoding: URLEncoding.default, success: {
            result in
            
            guard let coutry = try? JSONDecoder().decode([Country].self, from: result) else{
                return
            }
   
            DispatchQueue.main.async {
                //self.appState.weather.currentLeavel = 2
                self.appState.weather.countries = coutry
               
                print("items count is \(self.appState.weather.countries.count)")
                 
            }
        }, error: { error in
            print("error is \(error)")
        })
    }
    
    /**
        获取当前的Level数据
     */
    func getDataList() -> [String]{
        
        var dataList:[String] = []
        
        switch self.appState.weather.currentLeavel {
        case 0:
            // 移除所有数据
            //self.appState.weather.dataList.removeAll()
            for m in self.appState.weather.provices {
                dataList.append(m.name)
            }
        case 1:
            // 移除所有数据
            //self.appState.weather.dataList.removeAll()
            for m in self.appState.weather.cities {
                dataList.append(m.name)
            }
        case 2:
            // 移除所有数据
            //self.appState.weather.dataList.removeAll()
            for m in self.appState.weather.countries {
                dataList.append(m.name)
            }
        default:
            print("End")
        }
        
        return dataList
        
    }
    
    
    /**
        获取天气数据
     */
    
    func getWeather(code: String){
        
        let weatherKey = "c0d50dd43adb4a62aff5f3f728941082";

        let weather_url = "https://free-api.heweather.com/s6/weather?location="+code+"&key="+weatherKey
        
        let headers: HTTPHeaders = [
            "Content-Type":"application/json"
        ]
        
        ApiUtils.shared.netWork(url: weather_url, method: .get, params: nil, headers: headers, ecoding: URLEncoding.default, success: {
            result in

            
            guard let weather = try? JSONDecoder().decode(WeatherModel.self, from: result) else{
                return
            }
            
            DispatchQueue.main.async {
                //self.appState.weather.currentLeavel = 2
                self.appState.weather.weather = weather
               
                
                
                //print("items count is \(self.appState.weather.countries.count)")
                 
            }
            
            
        }, error: { error in
            print("error is \(error)")
        })
    }
    
    
    /**
        获取空气质量指数
     */

    func getAir(code: String){
        
        let weatherKey = "c0d50dd43adb4a62aff5f3f728941082";

        let weather_url = "https://free-api.heweather.com/s6/air?location="+code+"&key="+weatherKey
        
        let headers: HTTPHeaders = [
            "Content-Type":"application/json"
        ]
        
        ApiUtils.shared.netWork(url: weather_url, method: .get, params: nil, headers: headers, ecoding: URLEncoding.default, success: {
            result in

            //let json = String(data: result, encoding: String.Encoding.utf8)
            
            //print("json is \(String(describing: json))")
            
            
            guard let air = try? JSONDecoder().decode(LifeModel.self, from: result) else{
                return
            }
            
            DispatchQueue.main.async {
                print("air is \(air)")
                self.appState.weather.air = air
                //self.appState.weather.currentLeavel = 2
                //self.appState.weather.air = air
                //print("items count is \(self.appState.weather.air.count)")
            }
        }, error: { error in
            print("error is \(error)")
        })
    }
    
}
