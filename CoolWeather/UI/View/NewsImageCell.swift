//
//  NewsImageCell.swift
//  CoolWeather
//
//  Created by RND on 2021/2/1.
//

import SwiftUI
import Kingfisher

private let kImageSpace: CGFloat = 6

struct NewsImageCell: View {
    
    let images: [String]
    let width: CGFloat
    
    //@EnvironmentObject var content: Content
    
    //@State private var images:[String]
     
    var body: some View {
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
            }
        }
    }
}


