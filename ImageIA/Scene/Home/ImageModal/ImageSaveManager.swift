//
//  ImageManager.swift
//  ImageIA
//
//  Created by Kleyson Tavares on 12/02/25.
//

import Photos
import UIKit

final class ImageSaveManager {
    
    static let albumName = "ImageIA" // Nome do álbum
    static var albumPlaceholder: PHObjectPlaceholder?

    // Criar o álbum, caso não exista
    static func createAlbumIfNeeded(completion: @escaping (PHAssetCollection?) -> Void) {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
        let collection = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)

        if let existingAlbum = collection.firstObject {
            completion(existingAlbum)
            return
        }

        // Criar o álbum caso ele ainda não exista
        PHPhotoLibrary.shared().performChanges({
            let createAlbumRequest = PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: albumName)
            albumPlaceholder = createAlbumRequest.placeholderForCreatedAssetCollection
        }) { success, error in
            if success, let placeholder = albumPlaceholder {
                let collections = PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: [placeholder.localIdentifier], options: nil)
                completion(collections.firstObject)
            } else {
                completion(nil)
            }
        }
    }

    static func saveImageToAppAlbum(_ image: UIImage) {
        createAlbumIfNeeded { album in
            guard let album = album else {
                print("⚠️ Falha ao acessar o álbum.")
                return
            }
            if imageAuthorized() {
                PHPhotoLibrary.shared().performChanges({
                    let request = PHAssetChangeRequest.creationRequestForAsset(from: image)
                    let assetPlaceholder = request.placeholderForCreatedAsset
                    
                    if let assetPlaceholder = assetPlaceholder,
                       let albumChangeRequest = PHAssetCollectionChangeRequest(for: album) {
                        let fastEnumeration = NSArray(object: assetPlaceholder)
                        albumChangeRequest.addAssets(fastEnumeration)
                    }
                }) { success, error in
                    if success {
                        print("✅ Imagem salva no álbum específico.")
                    } else {
                        print("⚠️ Erro ao salvar a imagem: \(error?.localizedDescription ?? "Desconhecido")")
                    }
                }
            }
            
        }
    }
    
    static func imageAuthorized() -> Bool {
        let status = PHPhotoLibrary.authorizationStatus()
        var authorized = false
        switch status {
        case .authorized:
            authorized = true
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { newStatus in
                if newStatus == .authorized {
                    authorized = true
                }
            }
        default:
            authorized = false
        }
        return authorized
    }
}

