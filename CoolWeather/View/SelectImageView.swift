//
//  SelectImageView.swift
//  CoolWeather
//
//  Created by RND on 2021/2/4.
//  查看图片界面

import SwiftUI
import Kingfisher

struct SelectImageView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var store: Store
    var binding: Binding<AppState.Gank>{
        $store.appState.gank
    }
    
    var images: [String] = ["http://gank.io/images/f4f6d68bf30147e1bdd4ddbc6ad7c2a2",
    "http://gank.io/images/dc75cbde1d98448183e2f9514b4d1320",
    "http://gank.io/images/d237f507bf1946d2b0976e581f8aab9b",
    "http://gank.io/images/6b2efa591564475fb8bc32291fb0007c"]
    
    @State private var currentPage = 0
    
    var body: some View {
        NavigationView{
            VStack{
                TabView(selection: $currentPage){
                    ForEach(0..<self.images.count){ (index) in
                        ImageCell(image: self.images[index])
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


struct SelectImageView_Previews: PreviewProvider {
    static var previews: some View {
        SelectImageView().environmentObject(Store.shared)
    }
}


struct ImageCell:View {
    
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
                    .scaledToFill()
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




//=============备份代码============
/**
 
 /*GeometryReader{ geometry in
     VStack(spacing:0) {
         ZStack {
             Color(.systemBackground)
                 .edgesIgnoringSafeArea(.top)
             
             ScrollView (.horizontal, showsIndicators: true) {
                 LazyHStack(spacing: 0){
                     //注意这里
                     ForEach(self.images, id: \.self){ item in
                         ImageCell(image: item)
                     }
                     
                 }.frame(width: geometry.size.width, height: geometry.size.height)
             }
         }
     }
 }
 .navigationBarTitle("1/10", displayMode: .inline)
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
}*/
 
 
 /*NavigationView{
     // 横向滚动
     ScrollView(.horizontal, showsIndicators: true){
         LazyVStack(spacing: 5){
             //注意这里
             ForEach(self.images, id: \.self){ item in
                 ImageCell(image: item)
             }
         }
     }
     .navigationBarTitle("1/10", displayMode: .inline)
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
}*/
 
 
 
 
 */

