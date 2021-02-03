//
//  CoolWeatherApp.swift
//  CoolWeather
//
//  Created by RND on 2021/1/14.
//
import SwiftUI

@main
struct CoolWeatherApp: App {
    
    var content = Content()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Store.shared)
                //.environmentObject(content)
        }
    }
}
