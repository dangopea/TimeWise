//
//  BannerView.swift
//  TimeWise
//
//  Created by Dhriti on 22/05/2566 BE.
//

import SwiftUI

struct BannerView: View {
        
    @State private var isShowingBannerImagePicker = false
    @State private var selectedBannerImage: UIImage?
    @State private var hasSelectedBannerImage = false
    
    var body: some View {
        let bannerHeight = size.height * 0.3
        let imageSize = CGSize(width: size.width, height: bannerHeight)
        
        ZStack {
            if hasSelectedBannerImage {
                Image(uiImage: selectedBannerImage!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: imageSize.width, height: imageSize.height)
                    .clipped()
                    .cornerRadius(10)
                    .padding(10)
            } else {
                Rectangle()
                    .fill(Color(red: 193/255, green: 196/255, blue: 201/255))
                    .cornerRadius(10)
                    .padding(5)
                    .overlay(
                        HStack {
                            Text("Select banner image")
                            Image(systemName: "camera")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                        }
                        .foregroundColor(.white)
                    )
            }
            
            Button(action: {
                self.isShowingBannerImagePicker = true
            }) {
                Image(systemName: "pencil")
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color.gray)
                    .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle())
            .offset(x: imageSize.width / 2 - 30, y: imageSize.height / 2 - 20) // adjust x offset value
            .sheet(isPresented: $isShowingBannerImagePicker, onDismiss: loadBannerImage) {
                ImagePicker(image: self.$selectedBannerImage)
            }
        }
        .frame(height: bannerHeight)
    }
    
    private var size: CGSize
    private var safeArea: EdgeInsets
    
    init(size: CGSize, safeArea: EdgeInsets) {
        self.size = size
        self.safeArea = safeArea
    }
    
    private func loadBannerImage() {
        guard let selectedBannerImage = selectedBannerImage,
              let bannerImageData = selectedBannerImage.jpegData(compressionQuality: 1)
        else { return }
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent("banner.jpg")
        
        do {
            try bannerImageData.write(to: fileURL)
            hasSelectedBannerImage = true
            self.selectedBannerImage = UIImage(contentsOfFile: fileURL.path)
        } catch {
            print("Error saving image: \(error.localizedDescription)")
        }
    }
}

struct BannerView_Previews: PreviewProvider {
    static var previews: some View {
        BannerView(size: CGSize(width: 300, height: 400), safeArea: EdgeInsets())
    }
}

