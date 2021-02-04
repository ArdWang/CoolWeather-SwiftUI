//
//  WeatherView.swift
//  CoolWeather
//
//  Created by ardwang on 2021/2/4.
//

import SwiftUI

struct WeatherView: View {
    
    @EnvironmentObject var store: Store
    var binding: Binding<AppState.Weather>{
        $store.appState.weather
    }
    
    var body: some View {
        NavigationView{
            LazyVStack{
                Text("获取天气")
            }
            .navigationBarTitle("天气")
            .onAppear{
                self.store.getState()
            }
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
