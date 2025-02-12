//
//  Image.swift
//  ImageIA
//
//  Created by Kleyson Tavares on 08/02/25.
//

import UIKit
import Photos

class ImageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var images: [UIImage] = []
    private var theView: ImageView {
        return view as! ImageView
    }
    
    override func loadView() {
        view = ImageView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Minhas Imagens"
        
        theView.collectionView.delegate = self
        theView.collectionView.dataSource = self
        theView.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadImagesFromAlbum()
    }

    private func loadImagesFromAlbum() {
        ImageSaveManager.createAlbumIfNeeded { album in
            guard let album = album else { return }
            
            let screenSize: CGRect = UIScreen.main.bounds
            let screenWidth = (screenSize.width - 40) / 2
            
            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)] // Ordena por data decrescente
            
            let assets = PHAsset.fetchAssets(in: album, options: fetchOptions)
            let imageManager = PHCachingImageManager()
            let targetSize = CGSize(width: screenWidth, height: screenWidth)
            
            var newImages: [UIImage] = []
            
            assets.enumerateObjects { asset, _, _ in
                imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: nil) { image, _ in
                    if let image = image {
                        newImages.append(image)
                        
                        // Apenas recarrega se houver novas imagens
                        if newImages.count != self.images.count {
                            self.images = newImages
                            DispatchQueue.main.async {
                                self.theView.collectionView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }


        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return images.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .white

            let imageView = UIImageView(image: images[indexPath.item])
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.frame = cell.bounds
            imageView.layer.cornerRadius = 10

            cell.contentView.subviews.forEach { $0.removeFromSuperview() } // Remove imagens antigas
            cell.contentView.addSubview(imageView)
            
            return cell
        }
    }
