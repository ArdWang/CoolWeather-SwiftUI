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
    
    let baseUrl = "https://gank.io/api/v2/data/category/Girl/type/Girl/"
    
    //获取GankList
    @State var items = [Gank]()
    
    // 获取model
    @State var model = GankModel()
    
    @State private var isShowing = true
    
    @State var page = 1
    
    //默认为10
    @State var count = 10
    
    let transaction = Transaction(animation: .easeInOut(duration: 2.0))
    
    //@ObservedObject var model = MyModel()
    
    
    
    init(){
        //得到头部
        //getHeader()
        
        // 网络数据请求
        //getNetwork()
        print("我会执行嘛")
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
    func getNetwork(page:Int){
        
        let headers: HTTPHeaders = [
            "Content-Type":"application/json"
        ]
        
        ApiUtils.shared.netWork(url: baseUrl+"page/\(page)/count/10", method: .get, params: nil, headers: headers, ecoding: URLEncoding.default, success: { result in

            guard let gank = try? JSONDecoder().decode(GankModel.self, from: result) else{
                return
            }
   
            self.model = gank
            
            DispatchQueue.main.async {
                self.items.append(contentsOf: self.model.data)
                //self.items.removingDuplicates()
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
                
                if !self.model.isComplete {
                    LazyVStack{
                        Text("正在加载更多...")
                    }.frame(width: UIScreen.main.bounds.width, height: 50, alignment: .center).onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                            self.model.isComplete = false
                            //每次页面增加1
                            self.page += 1
                            self.getNetwork(page: self.page)
                        }
                    }
                }
            }.navigationBarTitle("干货")
            .onAppear{
                print("我执行了几次")
                self.getNetwork(page: self.page)
            }
            
        }
    }
    
    func load() {
        // Simulate async task
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            self.isShowing = false
            self.items.removeAll()
            self.getNetwork(page: self.page)
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
