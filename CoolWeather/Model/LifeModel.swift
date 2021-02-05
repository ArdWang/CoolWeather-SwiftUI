//
//  LifeModel.swift
//  CoolWeather
//
//  Created by RND on 2021/2/5.
//

import SwiftUI

struct LifeModel: Codable {
    
    let heWeather6: [HeWeatherAir6]

    enum CodingKeys: String, CodingKey {
        case heWeather6 = "HeWeather6"
    }
}

struct HeWeatherAir6: Codable {
    let basic: AirBasic
    let update: AirUpdate
    let status: String
    let airNowCity: AirNowCity
    let airNowStation: [AirNowStation]

    enum CodingKeys: String, CodingKey {
        case basic, update, status
        case airNowCity = "air_now_city"
        case airNowStation = "air_now_station"
    }
}

struct AirNowCity: Codable {
    let aqi, qlty, main, pm25: String
    let pm10, no2, so2, co: String
    let o3, pubTime: String

    enum CodingKeys: String, CodingKey {
        case aqi, qlty, main, pm25, pm10, no2, so2, co, o3
        case pubTime = "pub_time"
    }
}

struct AirNowStation: Codable {
    let airSta, aqi, asid, co: String
    let lat, lon: String
    let main: Main
    let no2, o3, pm10, pm25: String
    let pubTime: PubTime
    let qlty: Qlty
    let so2: String

    enum CodingKeys: String, CodingKey {
        case airSta = "air_sta"
        case aqi, asid, co, lat, lon, main, no2, o3, pm10, pm25
        case pubTime = "pub_time"
        case qlty, so2
    }
}

enum Main: String, Codable {
    case empty = "-"
    case pm10 = "PM10"
    case pm25 = "PM2.5"
}

enum PubTime: String, Codable {
    case the202102051500 = "2021-02-05 15:00"
}

enum Qlty: String, Codable {
    case 优 = "优"
    case 良 = "良"
}

struct AirBasic: Codable {
    let cid, location, parentCity, adminArea: String
    let cnty, lat, lon, tz: String

    enum CodingKeys: String, CodingKey {
        case cid, location
        case parentCity = "parent_city"
        case adminArea = "admin_area"
        case cnty, lat, lon, tz
    }
}

struct AirUpdate: Codable {
    let loc, utc: String
}
