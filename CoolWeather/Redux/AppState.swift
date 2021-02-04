//
//  AppState.swift
//  CoolWeather
//
//  Created by 沉寂 on 2021/2/1.
//

import Foundation
import AVKit

struct AppState {
    
    // 干货
    var gank = Gank()
    
    // 天气
    var weather = Weather()
    
    // 新闻
    var news = News()
    
}

extension AppState{
    
    struct Gank {
        
        var selection: String? = nil

        //获取GankList
        var items = [Gankum]()
        
        // 获取model
        var model = GankModel()
        
        var isShowing = false
        
        var noMore = false
        
        var page = 1
        
        //默认为10
        var count = 10
    }
    
    struct Weather {
        
        // 获取天气地址
        var state = StateModel()
        
        var provice = [Province]()
        
        // 获取天气信息
        var weather = WeatherModel()
    }
    
    
    struct News {
        
        var items = [Datam]()
        
        var model = NewsModel()
        
        //图片
        var images:[String] = []
        
    }
}
