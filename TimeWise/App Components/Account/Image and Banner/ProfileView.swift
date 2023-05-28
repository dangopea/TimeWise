//
//  ProfileView.swift
//  TimeWise
//
//  Created by Dhriti on 22/05/2566 BE.
//

import SwiftUI

struct ProfileView: View {
    @State private var isShowingProfileImagePicker = false
    @State private var selectedProfileImage: UIImage?
    @State private var hasSelectedProfileImage = false
    
    var body: some View {
        let profileHeight = size.height * 0.3
        let imageSize = CGSize(width: 100, height: 100)
        
        ZStack(alignment: .top) {
            Rectangle()
                .fill(Color.clear)
                .frame(width: size.width, height: profileHeight + imageSize.height/2)
                .offset(y: -imageSize.height/2)
            
            Circle()
                .fill(Color.white)
                .frame(width: imageSize.width + 10, height: imageSize.height + 10)
                .offset(y: -imageSize.height/2)
            
            
            if hasSelectedProfileImage {
                Image(uiImage: selectedProfileImage!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: imageSize.width, height: imageSize.height)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 4)
                    .padding(10)
                    .offset(y: -imageSize.height/2 - 4)
            } else {
                Circle()
                    .fill(Color(red: 193/255, green: 196/255, blue: 201/255))
                    .frame(width: imageSize.width, height: imageSize.height)
                    .overlay(
                        Image(systemName: "camera")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    )
                    .padding(10)
                    .offset(y: -imageSize.height/2 - 4)
            }
            
            Button(action: {
                self.isShowingProfileImagePicker = true
            }) {
                Image(systemName: "pencil")
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color.gray)
                    .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle())
            .offset(x: imageSize.width / 2 - 20, y: profileHeight / 2 - imageSize.height/2 - 30)
            .sheet(isPresented: $isShowingProfileImagePicker, onDismiss: loadProfileImage) {
                ImagePicker(image: self.$selectedProfileImage)
            }
        }
        .frame(width: size.width, height: profileHeight + imageSize.height/2)
    }
    
    private var size: CGSize
    private var safeArea: EdgeInsets
    
    init(size: CGSize, safeArea: EdgeInsets) {
        self.size = size
        self.safeArea = safeArea
    }
    
    private func loadProfileImage() {
        guard let selectedProfileImage = selectedProfileImage,
              let profileImageData = selectedProfileImage.jpegData(compressionQuality: 1)
        else { return }
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent("profile.jpg")
        
        do {
            try profileImageData.write(to: fileURL)
            hasSelectedProfileImage = true
            self.selectedProfileImage = UIImage(contentsOfFile: fileURL.path)
        } catch {
            print("Error saving image: \(error.localizedDescription)")
        }
        
        isShowingProfileImagePicker = false
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let size = CGSize(width: 300, height: 600)
        let safeArea = EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        return ProfileView(size: size, safeArea: safeArea)
    }
}
