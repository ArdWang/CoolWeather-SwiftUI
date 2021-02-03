//
//  NewsImageCellRow.swift
//  CoolWeather
//
//  Created by RND on 2021/2/1.
//

import SwiftUI
import Kingfisher

// 固定不变的量
private let kImageSpace: CGFloat = 6

struct NewsImageCellRow: View {
    
    let images: [String]
    let width: CGFloat
    
    var body: some View {
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

