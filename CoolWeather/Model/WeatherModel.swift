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
    var heweather6:[HeWeather6] = []
}

// 获取天气的 model
struct HeWeather6: Codable {
    var basic: Basic
    var update:Update
    var status = ""
    var now: Now
    var daily_forecast:[DailyForecast] = []
    var hourly:[Houry] = []
    var lifestyle:[LifeStyle] = []
}

struct Basic: Codable {
    var cid = ""
    var location = ""
    var parent_city = ""
    var admin_area = ""
    var cnty = ""
    var lat = ""
    var lon = ""
    var tz = ""
}

struct Update: Codable {
    var loc = ""
    var utc = ""
}

struct Now: Codable {
    var cloud = ""
    var cond_code = ""
    var cond_txt = ""
    var fl = ""
    var hum = ""
    var pcpn = ""
    var pres = ""
    var vis = ""
    var wind_deg = ""
    var wind_dir = ""
    var wind_sc = ""
    var wind_spd = ""
}

struct DailyForecast: Codable {
    var cond_code_d = ""
    var cond_code_n = ""
    var cond_txt_d = ""
    var cond_txt_n = ""
    var date = ""
    var hum = ""
    var hr = ""
    var mr = ""
    var ms = ""
    var pcpn = ""
    var pop = ""
    var pres = ""
    var sr = ""
    var ss = ""
    var tmp_max = ""
    var tmp_min = ""
    var uv_index = ""
    var vis = ""
    var wind_deg = ""
    var wind_dir = ""
    var wind_sc = ""
    var wind_spd = ""
}

struct Houry:Codable {
    var cloud = ""
    var cond_code = ""
    var cond_txt = ""
    var dew = ""
    var hum = ""
    var pop = ""
    var pres = ""
    var time = ""
    var tmp = ""
    var wind_deg = ""
    var wind_dir = ""
    var wind_sc = ""
    var wind_spd = ""
}

struct LifeStyle: Codable {
    var type = ""
    var brf = ""
    var txt = ""
}





