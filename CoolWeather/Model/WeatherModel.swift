//
//  WeatherModel.swift
//  CoolWeather
//
//  Created by ardwang on 2021/2/4.
//

import SwiftUI

struct WeatherModel: Codable {
    
    /**
     
    final stateUrl = APP_CITY_SERVICE_ADDRE+"api/china";

    final cityUrl = APP_CITY_SERVICE_ADDRE+"api/china/";

    final countryUrl = APP_CITY_SERVICE_ADDRE+"api/china/{pid}/{cid}";
     
     // 获取天气的城市地址
     const String APP_CITY_SERVICE_ADDRE = "http://guolin.tech/";
     
     // 和风天气接口api
     const String APP_WEATHER_SERVICE_ADDRE = "https://free-api.heweather.com/";
     //和风天气的Key
     const String APP_WEATHER_KEY = "c0d50dd43adb4a62aff5f3f728941082";
     */
    var heWeather6: [HeWeather6] = []

    enum CodingKeys: String, CodingKey {
        case heWeather6 = "HeWeather6"
    }
}

struct HeWeather6: Codable {
    let basic: Basic
    let update: Update
    let status: String
    let now: Hourly
    let dailyForecast: [DailyForecast]
    let hourly: [Hourly]
    let lifestyle: [Lifestyle]

    enum CodingKeys: String, CodingKey {
        case basic, update, status, now
        case dailyForecast = "daily_forecast"
        case hourly, lifestyle
    }
}

struct Basic: Codable {
    let cid, location, parentCity, adminArea: String
    let cnty, lat, lon, tz: String

    enum CodingKeys: String, CodingKey {
        case cid, location
        case parentCity = "parent_city"
        case adminArea = "admin_area"
        case cnty, lat, lon, tz
    }
}

struct Hourly: Codable {
    let cloud, condCode, condTxt: String
    let dew: String?
    let hum: String
    let pop: String?
    let pres: String
    let time: String?
    let tmp, windDeg, windDir, windSc: String
    let windSpd: String
    let fl, pcpn, vis: String?

    enum CodingKeys: String, CodingKey {
        case cloud
        case condCode = "cond_code"
        case condTxt = "cond_txt"
        case dew, hum, pop, pres, time, tmp
        case windDeg = "wind_deg"
        case windDir = "wind_dir"
        case windSc = "wind_sc"
        case windSpd = "wind_spd"
        case fl, pcpn, vis
    }
}

struct Lifestyle: Codable {
    let type, brf, txt: String
}

struct Update: Codable {
    let loc, utc: String
}

struct DailyForecast: Codable {
    let cond_code_d: String?
    let cond_txt_d: String?
    let date: String?
    //"tmp_max": "12",
    //"tmp_min": "-2",
    let tmp_max: String?
    let tmp_min: String?
    let hum: String?
}






