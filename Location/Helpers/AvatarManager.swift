//
//  AvatarManager.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 04.11.2021.
//

import UIKit

protocol AvatarManager {
    func saveAvatarImage(_ image: UIImage)
    func readAvatarImage() -> UIImage?
}

final class AvatarManagerImpl: AvatarManager {
    
    private func getAvatarPath() -> URL? {
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return path.appendingPathComponent(Constants.avatarFile)
    }
    
    func saveAvatarImage(_ image: UIImage) {
        guard let path = getAvatarPath() else { return }
        if let data = image.pngData() {
            try? data.write(to: path)
        }
    }
    
    func readAvatarImage() -> UIImage? {
        guard let path = getAvatarPath(),
              let data = try? Data(contentsOf: path)
        else { return nil }
        
        return UIImage(data: data)
    }
}
