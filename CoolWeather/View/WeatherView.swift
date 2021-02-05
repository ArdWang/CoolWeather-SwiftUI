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

    @State private var isPresent = false
    
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVStack(alignment:.leading){
                    
                    HStack{
                        Button(action:{
                            self.isPresent.toggle()
                        }){
                            Text(self.binding.cityName.wrappedValue).font(.largeTitle).bold()
                        }
                        .buttonStyle(PlainButtonStyle())
                        .sheet(isPresented: $isPresent, content: {
                            // 进行显示操作 天气列表显示
                            SelectCityView()
                        })
                        
                        Spacer()
                       
                        if let data = self.binding.weather.heWeather6.wrappedValue, self.binding.weather.heWeather6.wrappedValue.count > 0 {
                            Text(data[0].now.tmp+"°").font(.system(size: 105)).bold()
                        }
                    }.padding(15)
                    
                    // 获取7天气数据
                    Text("最近7天天气").font(.title2).bold()
                    Divider()
                    ForecastView()
                    
                    // 生活建议
                    Text("生活建议").font(.title2).bold()
                    Divider()
                    LifeStyleView()
                }
                .padding(10)
                .navigationBarTitle("天气")
                .onAppear{
                    Store.shared.getWeather(code: self.binding.defaultCode.wrappedValue)
                }
            }
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView().environmentObject(Store.shared)
    }
}


// 天气选择的View
struct SelectCityView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var store: Store
    var binding: Binding<AppState.Weather>{
        $store.appState.weather
    }
    
    var body: some View{
        
        // 获取数据的时候判断
        NavigationView{
            List(0..<Store.shared.getDataList().count, id:\.self){ (index) in
                
                SelectCityViewCell(presentationMode: self._presentationMode, cityName: Store.shared.getDataList()[index], indexPath: index)
                //SelectCityViewCell(cityName: Store.shared.getDataList()[index], indexPath:index)
            }
            .navigationBarTitle("城市", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action:{
                    self.binding.currentLeavel.wrappedValue = 0
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Image(systemName: "xmark.circle.fill")
                        .imageScale(.large)
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color(.white))
                        .cornerRadius(12)
                        .padding(10)
                        .colorMultiply(.blue)
                })
            .navigationViewStyle(StackNavigationViewStyle())
            .onAppear{
                // 默认是获取所有的天气数据
                Store.shared.getProvince()
            }
        }
    }
}

struct SelectCityViewCell: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var store: Store
    var binding: Binding<AppState.Weather>{
        $store.appState.weather
    }
    
    var cityName: String
    
    var indexPath: Int
    
    var body: some View{
        Button(action:{
            //点击事件
            switch self.binding.currentLeavel.wrappedValue {
            case 0 :
                let provicne = self.binding.provices[indexPath].wrappedValue
                Store.shared.getCity(pid: String(provicne.id))
                self.binding.currentLeavel.wrappedValue = 1
            case 1 :
                let provicne = self.binding.provices[indexPath].wrappedValue
                let city = self.binding.cities[indexPath].wrappedValue
                Store.shared.getCountry(pid: String(provicne.id), cid: String(city.id))
                self.binding.currentLeavel.wrappedValue = 2
            case 2 :
                print("当前的地址为 \(self.binding.countries.wrappedValue.count)")
                // 获取当前天气数据
                self.presentationMode.wrappedValue.dismiss()
                self.binding.currentLeavel.wrappedValue = 0
                
                // 获取天气网络请求数据
                let c = self.binding.countries[indexPath].wrappedValue
                Store.shared.getWeather(code: c.weatherId)
                self.binding.cityName.wrappedValue = c.name
                
            default: print("End")
            }
            
        }){
            HStack{
                Text(cityName).font(.system(size: 15))
                Spacer()
                Image(systemName: "chevron.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color(.secondaryLabel))
                    .frame(width: 8, height: 14)
            }.frame(height:44)
        }.foregroundColor(Color(.label))
    }
    
}

// 最近7天的数据
struct ForecastView: View {
    
    @EnvironmentObject var store: Store
    var binding: Binding<AppState.Weather>{
        $store.appState.weather
    }
    
    @State private var currentPage = 0
    
    var body: some View{
        VStack{
            if let data = self.binding.weather.heWeather6.wrappedValue, self.binding.weather.heWeather6.wrappedValue.count > 0 {
                TabView(selection: $currentPage){
                    ForEach(0..<data[0].dailyForecast.count){ (index) in
                        ForecastViewCell(forecast:data[0].dailyForecast[index] , indexPath: index)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }.tabViewStyle(PageTabViewStyle())
                .padding(10)
            }
        }.frame(width: UIScreen.main.bounds.width-20, height: 200)
    }
}

struct ForecastViewCell: View {

    @EnvironmentObject var store: Store
    var binding: Binding<AppState.Weather>{
        $store.appState.weather
    }
    
    var forecast: DailyForecast
    
    var indexPath: Int = 0
    
    var body: some View{
        
        ZStack{
            VStack{
                Text(forecast.date!).font(.system(size: 17))
                    .frame(maxWidth:.infinity, alignment: .leading)
                
                HStack{
                    Image(forecast.cond_code_d!).frame(width: 50, height: 50)
                    
                    Spacer().frame(width:30)
                    
                    Text(forecast.cond_txt_d!).font(.system(size: 22))
                        .frame(maxWidth:.infinity, alignment: .leading)
                    Spacer()
                    
                    VStack{
                        Text("湿度").font(.system(size: 17))
                            .frame(maxWidth:.infinity, alignment: .trailing)
                        Text(forecast.hum!+"%").font(.system(size: 27))
                            .frame(maxWidth:.infinity, alignment: .trailing)
                    }.frame(maxWidth:.infinity,alignment: .trailing)
                    
                }
                
                HStack{
                    VStack{
                        Text("max").font(.system(size: 17)).bold()
                        Text(forecast.tmp_max!+"°").font(.system(size: 27))
                    }
                    
                    Spacer()
                    
                    VStack{
                        Text("min").font(.system(size: 17)).bold()
                        Text(forecast.tmp_min!+"°").font(.system(size: 27))
                    }
                }
            }
        }.padding(10)
        .foregroundColor(Color(.white))
        .background(self.binding.colors.wrappedValue[indexPath])
        .cornerRadius(12)
    }
}


struct LifeStyleView: View {
    
    @EnvironmentObject var store: Store
    var binding: Binding<AppState.Weather>{
        $store.appState.weather
    }
    
    var body: some View{
        VStack{
            ScrollView{
                if let data = self.binding.weather.heWeather6.wrappedValue, self.binding.weather.heWeather6.wrappedValue.count > 0 {
                    
                    ForEach(0..<data[0].lifestyle.count){ (index) in
                        LifeStyleViewCell(item: data[0].lifestyle[index])
                    }
                }
            }
        }
    }
}


struct LifeStyleViewCell: View {
    
    var item: Lifestyle
    
    var body: some View{
        VStack{
            Text(item.brf).font(.system(size: 17)).bold().frame(alignment:.leading)
            Text(item.txt).font(.system(size: 17))
        }.padding(10)
        .foregroundColor(Color(.white))
        .background(Color("piColor"))
        .cornerRadius(12)
        .frame(width: UIScreen.main.bounds.width-20, height: 100)
    }
}






