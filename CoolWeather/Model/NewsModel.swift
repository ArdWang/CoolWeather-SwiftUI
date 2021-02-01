//
//  NewsModel.swift
//  CoolWeather
//
//  Created by RND on 2021/2/1.
//

import SwiftUI

struct NewsModel: Codable {
    var code:Int = 0
    var message:String = ""
    var data:[Datam] = []
}


struct Datam: Codable,Identifiable {
    var news:[News] = []
    var id: Int = 0
    var address:String = ""
    var title:String = ""
    var fname:String = ""
}


struct News : Codable{
    var c: String = ""
    var j: String = ""
    var jn: String = ""
    var p: Int = 0
}

extension News: Hashable{
    
}
