//
//  NewsView.swift
//  CoolWeather
//
//  Created by RND on 2021/2/1.
//

import SwiftUI
import Kingfisher
import AVKit
import CoreImage
import CoreImage.CIFilterBuiltins

struct NewsView: View {
    
    @EnvironmentObject var store: Store
    var binding: Binding<AppState.News>{
        $store.appState.news
    }
    
    var body: some View {
        NavigationView{
            ScrollView(){
                ForEach(binding.items.wrappedValue){ item in
                    NavigationLink(
                        destination: NewsDetailView(data: item)){
                        NewsCell(item: item)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }.navigationBarTitle("新闻")
            .onAppear{
                print("我执行了几次")
                self.store.getNews()
            }
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    
    static var previews: some View {
        NewsView().environmentObject(Store.shared)
    }
}


// 新闻界面的Cell 查看
struct NewsCell: View {
    
    @EnvironmentObject var store: Store
    var binding: Binding<AppState.News>{
        $store.appState.news
    }
    
    let item: Datam
    
    @State private var isPresent = false
    
    var body: some View{

        VStack(alignment:.leading){
            // 新闻标题
            Text(item.title).font(.title3)
            // 新闻内容
            Group{
                // 第一种布局 address 为空的时候
                if item.address == "" {
                    VStack(alignment:.leading){
                        if item.news.count > 0 {
                            if item.news[0].c.count > 40 {
                                Text(item.news[0].c.prefix(40)+"...More")
                            }else{
                                Text(item.news[0].c)
                            }
                        }else{
                            Text("")
                        }
                        
                        Divider()

                        NewsImageCell(images: Store.shared.combineImage(news: item.news), width: UIScreen.main.bounds.width-30)
                            .onTapGesture{
                                self.isPresent.toggle()
                            }
                            .sheet(isPresented: $isPresent, content: {
                                DisplayImageView(images: Store.shared.combineImage(news: item.news))
                            })
                            
                    }.padding(5)
                }else{
                    // 第二种布局 如果 address 不为空的时候
                    // 文字显示
                    if item.news.count > 0 {
                        if item.news[0].c.count > 0 {
                            HStack{
                                if item.news[0].c.count > 40 {
                                    Text(item.news[0].c.prefix(40)+"...More")
                                }else{
                                    Text(item.news[0].c)
                                }
                                
                                Spacer()
                                
                                VStack{
                                    // 视频显示
                                    VideoPlayer(player: Store.shared.startPlayer(item.address)).onAppear()
                                }.frame(width: UIScreen.main.bounds.size.width/2-20, height: 130)
                            }
                            
                        }else{
                            VStack{
                                // 视频显示
                                VideoPlayer(player: Store.shared.startPlayer(item.address)).onAppear()
                            }.frame(width: UIScreen.main.bounds.size.width-30, height: 230)
                        }
                        
                    }else{
                        VStack{
                            // 视频显示
                            VideoPlayer(player: Store.shared.startPlayer(item.address)).onAppear()
                        }.frame(width: UIScreen.main.bounds.size.width-30, height: 230)
                    }
                }
            }
        }.padding(10)
    }
}


struct NewsImageCell: View {
    
    private let kImageSpace: CGFloat = 6
    
    let images: [String]
    let width: CGFloat
    
    var body: some View{
        Group{
            if images.count == 1 {
                // 显示图片
                KFImage(URL(string: images[0]))
                .resizable()
                .scaledToFill()
                .frame(width: width, height: width*0.75)
                .clipped()
            }else if images.count == 2 {
                NewsImageCellRow(images: images, width: width)
            }else if images.count == 3 {
                NewsImageCellRow(images: images, width: width)
            }else if images.count == 4 {
                VStack(spacing:kImageSpace){
                    NewsImageCell(images: Array(images[0...1]), width: width)
                    NewsImageCell(images: Array(images[2...3]), width: width)
                }
            }else if images.count == 5 {
                VStack(spacing:kImageSpace){
                    NewsImageCell(images: Array(images[0...1]), width: width)
                    NewsImageCell(images: Array(images[2...4]), width: width)
                }
            }else if images.count == 6 || images.count > 6 {
                VStack(spacing:kImageSpace){
                    NewsImageCell(images: Array(images[0...2]), width: width)
                    NewsImageCell(images: Array(images[3...5]), width: width)
                }
            }else{
                EmptyView().frame(height:20)
            }
        }
    }
}


struct NewsImageCellRow: View {
    
    private let kImageSpace: CGFloat = 6
    
    let images: [String]
    let width: CGFloat
    
    var body: some View{
        
        HStack(spacing:6){
            ForEach(images, id: \.self){
                image in
                KFImage(URL(string: image))
                    .resizable()
                    .scaledToFill()
                    .frame(width:(self.width-kImageSpace * CGFloat(self.images.count-1))/CGFloat(self.images.count), height: (self.width-kImageSpace * CGFloat(self.images.count-1))/CGFloat(self.images.count))
                    .clipped() //超出来的部分裁剪掉
            }
        }
    }
}

/**
    显示当前的图片
 */
struct DisplayImageView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var store: Store
    var binding: Binding<AppState.News>{
        $store.appState.news
    }
    
    var images: [String] = ["http://gank.io/images/f4f6d68bf30147e1bdd4ddbc6ad7c2a2",
    "http://gank.io/images/dc75cbde1d98448183e2f9514b4d1320",
    "http://gank.io/images/d237f507bf1946d2b0976e581f8aab9b",
    "http://gank.io/images/6b2efa591564475fb8bc32291fb0007c"]
    
    @State private var currentPage = 0
    
    var body: some View{
        
        NavigationView{
            VStack{
                TabView(selection: $currentPage){
                    ForEach(0..<self.images.count){ (index) in
                        DisplayNewsImageCell(image: self.images[index])
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }
            .navigationBarTitle("\(self.currentPage+1)/\(self.images.count)", displayMode: .inline)
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

struct DisplayNewsImageCell: View {
    
    var image: String? = ""
    @State private var scale: CGFloat = 1.0
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





/// ===============备用代码
/**
 
 //URL(string: "http://0.s3.envato.com/h264-video-previews/80fad324-9db4-11e3-bf3d-0050569255a8/490527.mp4")!
 //let player = AVPlayer(url: Bundle.main.url(forResource: "trump", withExtension: "mp4")!)
 
 //let player = AVPlayer(url: URL(string: "http://0.s3.envato.com/h264-video-previews/80fad324-9db4-11e3-bf3d-0050569255a8/490527.mp4")!)
 
 //@State private var currentFilter = 0
 
 //var filters : [CIFilter?] = [nil, CIFilter.sepiaTone(), CIFilter.pixellate(), CIFilter.comicEffect()]
 
 
 
 */
