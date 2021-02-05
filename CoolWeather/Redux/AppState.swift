//
//  AppState.swift
//  CoolWeather
//
//  Created by 沉寂 on 2021/2/1.
//

import Foundation
import AVKit
import SwiftUI

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
    
    enum CurrentLeavel: Int {
        case provicneLeavel = 0
        case cityLeavel = 1
        case countryLeavel = 2
    }
    
    
    struct Weather {
        
        // 获取天气地址
        var state = StateModel()
        
        var provices = [Province]()
        
        var cities = [City]()
        
        var countries = [Country]()
        
        // 获取天气信息
        var weather =  WeatherModel()
        
        // 获取空气指数
        var air = LifeModel()
        
        // 默认为 0
        var currentLeavel:Int = 0
        
        // 获取名称
        var dataList: [String] = []
        
        var colors:[Color] = [Color("piColor"),Color("piColor"),Color("piColor"),Color("piColor"),Color("piColor"),Color("piColor"),Color("piColor")]
        
        var cityName:String = "北京"
        
        var defaultCode = "CN101010100"
        
        
    }
    
    
    struct News {
        
        var items = [Datam]()
        
        var model = NewsModel()
        
        //图片
        var images:[String] = []
        
    }
}
