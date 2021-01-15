//
//  GankModel.swift
//  CoolWeather
//
//  Created by RND on 2021/1/14.
//

import SwiftUI


struct GankModel: Codable {
    var data: [Gank] = []
    //let page, pageCount, status, totalCounts: Int
    
    var page:Int = 0
    var pageCount:Int = 0
    var status:Int = 0
    var totalCounts:Int = 0
    
    enum CodingKeys: String, CodingKey {
        case data, page
        case pageCount = "page_count"
        case status
        case totalCounts = "total_counts"
    }
}

struct Gank: Identifiable,Codable{
    var id: String = ""
    var author: String = ""
    var category: String = ""
    var createdAt:String = ""
    var desc: String = ""
    var images: [String] = []
    var likeCounts: Int = 0
    var publishedAt: String = ""
    var stars: Int = 0
    var title: String = ""
    var type: String = ""
    var url: String = ""
    var views: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case author, category, createdAt, desc, images, likeCounts, publishedAt, stars, title, type, url, views
    }
}
