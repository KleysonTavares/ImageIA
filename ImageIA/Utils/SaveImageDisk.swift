//
//  SaveImageDisk.swift
//  ImageIA
//
//  Created by Kleyson Tavares on 08/02/25.
//

import UIKit

struct SaveImageToDisk {
    // salvar a imagem no disco
    func saveImageToDisk(image: UIImage, fileName: String = "cachedImage.png") {
        if let data = image.pngData() {
            let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
            try? data.write(to: fileURL)
            print("Imagem salva em: \(fileURL.path)")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func loadCachedImage(fileName: String = "cachedImage.png") -> UIImage? {
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
        if let data = try? Data(contentsOf: fileURL) {
            return UIImage(data: data)
        }
        return nil
    }
    
}
