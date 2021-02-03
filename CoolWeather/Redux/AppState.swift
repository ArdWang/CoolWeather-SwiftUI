//
//  AppState.swift
//  CoolWeather
//
//  Created by 沉寂 on 2021/2/1.
//

import Foundation

struct AppState {
    
    var a = A()
    var b = B()
    var c = C()
    var gank = Gank()
    
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
        
        var page = 1
        
        //默认为10
        var count = 10
    }
}
