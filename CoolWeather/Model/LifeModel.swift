//
//  LifeModel.swift
//  CoolWeather
//
//  Created by RND on 2021/2/5.
//

import SwiftUI

// MARK: - LifeModel
struct LifeModel: Codable {
    var heWeather6: [HeWeatherAir6] = []

    enum CodingKeys: String, CodingKey {
        case heWeather6 = "HeWeather6"
    }
}

// MARK: - HeWeather6
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

// MARK: - AirNowCity
struct AirNowCity: Codable {
    let aqi: String
    let qlty: String
    let main: String
    let pm25, pm10, no2, so2: String
    let co, o3: String
    let pubTime: String

    enum CodingKeys: String, CodingKey {
        case aqi, qlty, main, pm25, pm10, no2, so2, co, o3
        case pubTime = "pub_time"
    }
}

//enum Main: String, Codable {
//    case empty = "-"
//    case pm10 = "PM10"
//}
//
//enum PubTime: String, Codable {
//    case the202102060900 = "2021-02-06 09:00"
//}
//
//enum Qlty: String, Codable {
//    case 良 = "良"
//}

// MARK: - AirNowStation
struct AirNowStation: Codable {
    let airSta, aqi, asid, co: String
    let lat, lon: String
    let main: String
    let no2, o3, pm10, pm25: String
    let pubTime: String
    let qlty: String
    let so2: String

    enum CodingKeys: String, CodingKey {
        case airSta = "air_sta"
        case aqi, asid, co, lat, lon, main, no2, o3, pm10, pm25
        case pubTime = "pub_time"
        case qlty, so2
    }
}

// MARK: - Basic
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

// MARK: - Update
struct AirUpdate: Codable {
    let loc, utc: String
}
