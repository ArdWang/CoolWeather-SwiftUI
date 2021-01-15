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
    
    //let columns = [GridItem(.adaptive(minimum: 200))]
    
    let columns:[GridItem] = Array(repeating: .init(.flexible()), count: 1)
    
    let baseUrl = "https://gank.io/api/v2/data/category/Girl/type/Girl/page/1/count/10"
    
    //获取GankList
    @State var items = [Gank]()
    
    @State private var isShowing = true
    
    let transaction = Transaction(animation: .easeInOut(duration: 2.0))
    
    @ObservedObject var model = MyModel()
    
    
    
    init(){
        //得到头部
        //getHeader()
        
        // 网络数据请求
        //getNetwork()
        
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

            guard let gank = try? JSONDecoder().decode(GankModel.self, from: result) else{
                return
            }
            
            let items:[Gank] = gank.data
            
            DispatchQueue.main.async {
                self.items = items
            }
            
        }, error: { error in
            print("error is \(error)")
        })
    }
    
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack{
                    LazyVGrid(columns: columns, spacing:5)
                    {
                        ForEach(items){ item in
                            GankItemView(item: item)
                        }
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .onAppear{
                    self.getNetwork()
                }
                
                if isShowing {
                    LazyVStack{
                        Text("正在加载更多...")
                    }.frame(width: UIScreen.main.bounds.width, height: 50, alignment: .center).onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                            self.isShowing = true
                            self.getNetwork()
                        }
                    }
                }
            }.navigationBarTitle("干货")
        }
    }
    
    func load() {
        // Simulate async task
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            self.isShowing = false
            self.items.removeAll()
            self.getNetwork()
        }
    }
    
    
    struct GankView_Previews: PreviewProvider {
        static var previews: some View {
            GankView()
        }
    }
}


class MyModel: ObservableObject {
    @Published var loading: Bool = false {
        didSet {
            if oldValue == false && loading == true {
                self.load()
            }
        }
    }
    
    func load() {
        // Simulate async task
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            self.loading = false
            
        }
    }
}
