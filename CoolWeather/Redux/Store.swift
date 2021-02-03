//
//  Store.swift
//  CoolWeather
//
//  Created by 沉寂 on 2021/2/1.
//

import Foundation
import Combine
import Alamofire

class Store: ObservableObject {
    static let shared = Store()
    private init(){}
    
    @Published var appState = AppState()

}

extension Store{
    
    //获取网络数据
    func getNetwork(page:Int){
        
        
        self.appState.gank.isShowing = true
        
        let headers: HTTPHeaders = [
            "Content-Type":"application/json"
        ]
        
        let baseUrl = "https://gank.io/api/v2/data/category/Girl/type/Girl/"
        
        ApiUtils.shared.netWork(url: baseUrl+"page/\(page)/count/10", method: .get, params: nil, headers: headers, ecoding: URLEncoding.default, success: { result in

            guard let gank = try? JSONDecoder().decode(GankModel.self, from: result) else{
                return
            }

            DispatchQueue.main.async {
                //self.items.append(contentsOf: self.model.data)
                //self.items.removingDuplicates()
                self.appState.gank.model = gank
                //self.appState.gank.items = self.appState.gank.model
                //self.appState.gank.items.append(contentsOf: self.appState.gank.model.data)
                self.appState.gank.items += self.appState.gank.model.data
                self.appState.gank.isShowing = false
            }
            
        }, error: { error in
            print("error is \(error)")
        })
    }
    
    /**
        加载更多的Gank数据
     */
    func loadMoreGank(){
        self.appState.gank.isShowing = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            
            self.getNetwork(page: self.appState.gank.page)
            
            self.appState.gank.items += self.appState.gank.model.data
            self.appState.gank.isShowing = false
        }
    }
    

    
}
