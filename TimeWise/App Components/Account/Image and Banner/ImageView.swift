//
//  ImageView.swift
//  TimeWise
//
//  Created by Dhriti on 4/22/2566 BE.
//

import SwiftUI

struct ImageView: View {
    var size: CGSize
    var safeArea: EdgeInsets
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack (spacing: 0) {
                    BannerView(size: size, safeArea: safeArea)
                    ProfileView(size: size, safeArea: safeArea)
                }
            }
        }
    }
}
