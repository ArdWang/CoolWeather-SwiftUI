//
//  GankModel.swift
//  CoolWeather
//
//  Created by RND on 2021/1/14.
//

import UIKit
import HandyJSON

class GankModel: HandyJSON {
    
    var data:[Gank] = []
    
    required init() {}
}


class Gank: HandyJSON{
    
    var _id:String?
    var author:String?
    var category:String?
    var createdAt:String?
    var desc:String?
    var images:[String] = []
    var likeCounts:String?
    var publishedAt:String?
    var stars:String?
    var title:String?
    var type:String?
    var url:String?
    var views:String?
    
    required init() {}
}
