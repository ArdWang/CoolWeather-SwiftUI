//
//  GankModel.swift
//  CoolWeather
//
//  Created by RND on 2021/1/14.
//

import SwiftUI


struct GankModel: Codable {
    let data: [Gank]
    let page, pageCount, status, totalCounts: Int
    
    enum CodingKeys: String, CodingKey {
        case data, page
        case pageCount = "page_count"
        case status
        case totalCounts = "total_counts"
    }
}

struct Gank: Identifiable,Codable{
    let id: String
    let author: String
    let category: String
    let createdAt, desc: String
    let images: [String]
    let likeCounts: Int
    let publishedAt: String
    let stars: Int
    let title: String
    let type: String
    let url: String
    let views: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case author, category, createdAt, desc, images, likeCounts, publishedAt, stars, title, type, url, views
    }
}
