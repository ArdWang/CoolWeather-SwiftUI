//
//  GankView.swift
//  CoolWeather
//
//  Created by RND on 2021/1/14.
//

import SwiftUI
import Alamofire
import Kingfisher

struct GankView: View {
    
    @State private var selection: String? = nil
    
    let columns = [GridItem(.adaptive(minimum: 160))]
    
    let baseUrl = "https://gank.io/api/v2/data/category/Girl/type/Girl/page/1/count/10"
    
    //获取GankList
    @State var gankList = [Gank]()
    
    
    init(){
        //得到头部
        getHeader()
        
        // 网络数据请求
        getNetwork()
        
    }
    
    func getHeader(){
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "ArialRoundedMTBold", size: 35)!]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "ArialRoundedMTBold", size: 20)!]
        navBarAppearance.backgroundColor = UIColor(hexString: "#353535", transparency: 1.0)
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
    }
    
    //获取网络数据
    func getNetwork(){
        
        let headers: HTTPHeaders = [
            "Content-Type":"application/json"
        ]
        
        ApiUtils.shared.netWork(url: baseUrl, method: .get, params: nil, headers: headers, ecoding: URLEncoding.default, success: { result in
            
            if let model = GankModel.deserialize(from: result){
                if model.data.count > 0 {
                    self.gankList = model.data
                }
            }
            
        }, error: { error in
            print("error is \(error)")
        })
    }
    
    
    var body: some View {
        NavigationView {
            ScrollView{
                LazyVGrid(columns: columns, spacing:20)
                {
                    ForEach(0..<self.gankList.count){ i in
                        
                        KFImage(URL(string: self.gankList[i].images[0])!).resizable()
                            .aspectRatio(contentMode: .fill)
                        
                        //Image("\(self.gankList[i].images[0])").resizable().aspectRatio(contentMode: .fill)                    }
                    }
                    .navigationBarTitle("干货", displayMode: .inline)
                }
            }
        }
    }
    
    struct GankView_Previews: PreviewProvider {
        static var previews: some View {
            GankView()
        }
    }
}
