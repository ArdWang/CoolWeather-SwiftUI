//
//  AppState.swift
//  CoolWeather
//
//  Created by 沉寂 on 2021/2/1.
//

import Foundation
import AVKit

struct AppState {
    
    var a = A()
    var b = B()
    var c = C()
    
    // 干货
    var gank = Gank()
    
    // 新闻
    var news = News()
    
}

extension AppState{
    
    struct A {
        
    }
    
    struct B {
        
    }
    
    struct C {
        
    }
    
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
    
    
    struct News {
        
        var items = [Datam]()
        
        var model = NewsModel()
        
        //图片
        var images:[String] = []
        
    }
}
