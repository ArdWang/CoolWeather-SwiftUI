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
    
    @EnvironmentObject var store: Store
    var binding: Binding<AppState.Gank>{
        $store.appState.gank
    }
    
    let columns:[GridItem] = Array(repeating: .init(.flexible()), count: 1)
    
    let transaction = Transaction(animation: .easeInOut(duration: 2.0))
    
    
    /*init(){
        //得到头部
        //getHeader()
        
        // 网络数据请求
        //getNetwork()
        print("我会执行嘛")
    }
    */
    

    func getHeader(){
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "ArialRoundedMTBold", size: 35)!]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "ArialRoundedMTBold", size: 20)!]
        navBarAppearance.backgroundColor = UIColor(hexString: "#353535", transparency: 1.0)
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
    }
    
    private var refreshListener: some View {
        // 一个任意视图，我们将把它添置在滚动列表的尾部
        LoadingView(isLoading: binding.isShowing.wrappedValue)
          .frame(width: 150, height: 35) // height: 如果有加载动画就设置，没有设置为0就可以
          .onAppear(perform: {
            binding.page.wrappedValue += 1
            print("page is:  \(binding.page.wrappedValue)")
            Store.shared.getNetwork(page: binding.page.wrappedValue)
          })
      }
    
    var body: some View {
        
        NavigationView {
            ScrollView{
                LazyVStack{
                    //注意这里
                    ForEach(binding.items.wrappedValue){ item in
                        GankCell(item: item)
                    }
                    
                    if !binding.noMore.wrappedValue {
                        if binding.isShowing.wrappedValue{
                            Text("正在加载").frame(height: 44)
                                .animation(.easeInOut)
                        }else{
                            Text("正在加载").frame(height: 44)
                                .animation(.easeInOut)
                                .onAppear{
                                    print("onAppear = \(Date())")
                                    Store.shared.loadMoreGank()
                                }
                                .onDisappear{
                                    print("onDisappear = \(Date())")
                                }
                        }
                    }else{
                        //Alert()
                        Text("没有更多了").frame(height:44)
                    }
                }
                .padding(.bottom, 10)
                .font(.system(size: 12))
                .foregroundColor(Color(.secondaryLabel))
            }
            .padding(.top, 10)
            .navigationBarTitle("干货")
            .onAppear{
                Store.shared.getNetwork(page: binding.page.wrappedValue)
            }
            .onDisappear{
                //
            }
        }
    }
}


struct GankView_Previews: PreviewProvider {
    static var previews: some View {
        GankView().environmentObject(Store.shared)
    }
}



struct GankCell: View {
    
    //@EnvironmentObject var store: Store
    /*var binding: Binding<AppState.Gank>{
     $store.appState.gank
     }*/
    
    var item: Gankum
    
    @State private var isPresent = false
    
    var body: some View{
        
        VStack{
            if let firstImage = item.images.first {
                KFImage(URL(string: firstImage))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            HStack{
                VStack(alignment: .leading) {
                    
                    Text(item.author)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                    
                    Text(item.desc)
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                .layoutPriority(100)
                //将VStack 推到左侧
                Spacer()
            }
            .padding(5)
        }
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
        )
        .padding([.top, .horizontal])
        .onTapGesture{
            self.isPresent.toggle()
        }
        .sheet(isPresented: $isPresent, content: {
            //images:item.images
            SelectImageView().environmentObject(Store.shared)
        })
    }
    
}


private struct LoadingView: View {
    
    var isLoading: Bool = true
    
    var body: some View{
        if isLoading {
            Text("正在加载更多...")
        }
    }
}




