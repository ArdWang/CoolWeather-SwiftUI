//
//  GankItemView.swift
//  CoolWeather
//
//  Created by RND on 2021/1/15.
//

import SwiftUI
import Kingfisher


struct GankItemView: View {
    
    //@State var items = [Gank]()
    
    @State var item = Gank()
    
    var body: some View {
        VStack{
            if let firstImage = item.images.first {
                KFImage(URL(string: firstImage))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
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
    }
    
}

struct GankItemView_Previews: PreviewProvider {
    static var previews: some View {
        GankItemView(item: Gank())
    }
}
