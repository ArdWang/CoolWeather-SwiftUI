//
//  NewsDetailView.swift
//  CoolWeather
//
//  Created by RND on 2021/2/4.
//  新闻详情界面

import SwiftUI
import Kingfisher

struct NewsDetailView: View {
    
    @EnvironmentObject var store: Store
    var binding: Binding<AppState.News>{
        $store.appState.news
    }
    
    var data: Datam
    
    var body: some View {
        VStack{
            //内容区块
            ScrollView{
                // 新闻标题
                Text(data.title).font(.title3)
                
                VStack{
                    ForEach(data.news, id:\.self){ item in
                        DetailViewCell(new: item)
                    }
                }.padding(5)
            }
        }
    }
}

struct NewsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetailView(data: Datam()).environmentObject(Store.shared)
    }
}


struct DetailViewCell: View {
    
    var new: News
    
    let width = UIScreen.main.bounds.size.width - 50
    
    @State private var isPresent = false
    
    var body: some View{
        
        VStack{
            if new.c != "" {
                Text(new.c)
            }else{
                EmptyView().frame(height:5)
            }
            
            if new.j != "" {
                // 显示图片
                KFImage(URL(string: new.j))
                .resizable()
                .scaledToFill()
                    .frame(width: width, height: width*0.75)
                .clipped()
                    .onTapGesture{
                        self.isPresent.toggle()
                    }
                    .sheet(isPresented: $isPresent, content: {
                        DetailImageView(image: new.j)
                    })
                
            }else{
                EmptyView().frame(height:5)
            }
        }
    }
}

struct DetailImageView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var store: Store
    var binding: Binding<AppState.News>{
        $store.appState.news
    }
    
    var image: String
    
    @State private var currentPage = 0
    
    
    var body: some View{
        NavigationView{
            VStack{
                TabView(selection: $currentPage){
                    DetailImageCell(image: self.image)
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }
            .navigationBarTitle("\(self.currentPage+1)/\(1)", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action:{
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Image(systemName: "xmark.circle.fill")
                        .imageScale(.large)
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color(.white))
                        .cornerRadius(12)
                        .padding(10)
                        .colorMultiply(.black)
                }
            )
        }
    }
        
    
}

struct DetailImageCell:View {
    
    var image: String? = ""
    @State private var scale: CGFloat = 0.75
    @GestureState private var dragOffset = CGSize.zero
    @State private var position = CGSize.zero
    
    var body: some View{
        VStack(spacing:0){
            if let mimage = image, image != "" {
                KFImage(URL(string: mimage))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    //.scaledToFill()
                    .scaleEffect(scale)
                    .gesture(
                        MagnificationGesture()
                            .onChanged{ value in
                                self.scale = value.magnitude
                            }
                    )
                    .gesture(
                        DragGesture()
                            .updating($dragOffset, body: { (value, state, transaction) in
                                
                                state = value.translation
                            })
                            .onEnded({ (value) in
                                self.position.height += value.translation.height
                                self.position.width += value.translation.width
                            })
                    )
                    .gesture(
                        TapGesture()
                            .onEnded { _ in
                                self.scale += 0.1
                                print("\(self.scale)")
                            }
                    )
            }
        }
    }
}




