//
//  StateModel.swift
//  CoolWeather
//
//  Created by ardwang on 2021/2/4.
//

import SwiftUI

// 获取国家名称
struct StateModel:Codable {
    var data: [Province] = []
}

struct ProvinceModel:Codable {
    var data:[City] = []
}

struct Province: Codable, Identifiable{
    var id:Int = 0
    var name:String = ""
}

struct City: Codable, Identifiable {
    var id = 0
    var name = ""
}

struct Country: Codable, Identifiable {
    var id = 0
    var name = ""
    var weatherId = ""
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case weatherId = "weather_id"
    }
    
}

