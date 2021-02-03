//
//  DemoView.swift
//  CoolWeather
//
//  Created by RND on 2021/2/3.
//

import SwiftUI

struct DemoView: View {
    // 数据源
     @State private var dataSource: [String] = []
     // 刷新状态绑定
     @State private var isRefreshing: Bool = false
     // 页码
     @State private var page: Int = 0

     private var refreshListener: some View {
       // 一个任意视图，我们将把它添置在滚动列表的尾部
        LoadingView(isLoading: isRefreshing)
         .frame(width: 150, height: 35) // height: 如果有加载动画就设置，没有设置为0就可以
         .onAppear(perform: {
             page += 1
             loadData()
         })
     }
     
     private func loadData() {
        isRefreshing = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
          // 伪代码，模拟数据网络加载
          dataSource += ["a","b","c"]
          isRefreshing = false
        }
     }
    
    
     
     var body: some View {
       // 1.如果使用ScrollView
       ScrollView(.vertical) {
         // 使用懒加载，确保滑动到再Appear。
         LazyVStack {
             ForEach(0..<dataSource.count, id: \.self) { index in
               Text("\(dataSource[index])")
             }
             // 加载更多
             refreshListener
         }
       }
       .onAppear {
         // 页面出现获取数据
         loadData()
       }
       
       // 2.如果使用List
     /*
       List {
         LazyVStack {
           ForEach(0..<dataSource.count, id: \.self) { index in
               Text("\(dataSource[index])")
             }
             // 加载更多
             refreshListener
         }
       }
       .onAppear {
         // 页面出现获取数据
         loadData()
       }
     */
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

struct DemoView_Previews: PreviewProvider {
    static var previews: some View {
        DemoView()
    }
}
