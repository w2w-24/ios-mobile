//
//  BrandPictureSelecterView.swift
//  W2WMatch
//
//  Created by Игорь Крысин on 19.06.2024.
//

import SwiftUI
import PhotosUI

struct BrandPictureSelecterView: View {
    @State var photosPickerItem: PhotosPickerItem?
    @ObservedObject var photoItem: GalleryItem
    @MainActor @State private var isLoading = false
    //@EnvironmentObject var mainVm: MainViewModel
    
    
    
    let filter: PHPickerFilter = .not(.videos)
    
    var body: some View {
        ZStack {
            PhotosPicker(selection: $photosPickerItem, matching: filter) {
                Label("", image: "downloadImageView")
            }
            
            if let photoData = photoItem.PhotoData, let uiImage = UIImage(data: photoData) {
                let imageSize = 80.00
                
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                    .cornerRadius(10)
                    .offset(y: -10)
                
            }
            
//            PhotoView(photoData: photoItem.PhotoData)
//                .padding()
            
            if isLoading {
                ProgressView()
                    .tint(.w2WBlue)
            }
        }
        .padding()
        .onChange(of: photosPickerItem) { selectedPhotosPickerItem in
            guard let selectedPhotosPickerItem else { return }
            
            Task {
                isLoading = true
                await updatePhotosPickerItem(with: selectedPhotosPickerItem)
                isLoading = false
            }
        }
    }
}

extension BrandPictureSelecterView {
      // MARK: Private Functions
    private func updatePhotosPickerItem(with item: PhotosPickerItem) async {
        photosPickerItem = item

        if let photoData = try? await item.loadTransferable(type: Data.self) {
            photoItem.PhotoData = photoData
        }
    }
}

#Preview {
    BrandPictureSelecterView(photoItem: GalleryItem())
}
