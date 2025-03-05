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
    private var isEditingMode = false
    private var selectedImages = Set<Int>()

    override func loadView() {
        view = ImageView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Minhas Imagens"
        
        theView.collectionView.delegate = self
        theView.collectionView.dataSource = self
        theView.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Editar", style: .plain, target: self, action: #selector(toggleEditMode))
        loadImagesFromAlbum()
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

        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        cell.contentView.addSubview(imageView)

        // Se estiver no modo de edição, mostrar o overlay de seleção
        if isEditingMode {
            let overlay = UIView(frame: cell.bounds)
            overlay.backgroundColor = selectedImages.contains(indexPath.item) ? UIColor.black.withAlphaComponent(0.5) : UIColor.clear
            overlay.layer.cornerRadius = 10
            overlay.tag = 99 // Identificação do overlay
            cell.contentView.addSubview(overlay)
        } else {
            cell.contentView.viewWithTag(99)?.removeFromSuperview()
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard isEditingMode else { return }
        
        if selectedImages.contains(indexPath.item) {
            selectedImages.remove(indexPath.item)
        } else {
            selectedImages.insert(indexPath.item)
        }

        navigationItem.leftBarButtonItem?.isEnabled = !selectedImages.isEmpty

        collectionView.reloadItems(at: [indexPath])
    }
    
    @objc private func toggleEditMode() {
        isEditingMode.toggle()
        selectedImages.removeAll()
        
        navigationItem.rightBarButtonItem?.title = isEditingMode ? "Cancelar" : "Editar"

        if isEditingMode {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Excluir", style: .plain, target: self, action: #selector(deleteSelectedImages))
            navigationItem.leftBarButtonItem?.isEnabled = false // Só ativa quando houver seleção
        } else {
            navigationItem.leftBarButtonItem = nil
        }
        
        theView.collectionView.reloadData()
    }
    
    @objc private func deleteSelectedImages() {
        let sortedIndexes = selectedImages.sorted(by: >) // Ordenar para remover do final para o início
        for index in sortedIndexes {
            images.remove(at: index)
        }
        selectedImages.removeAll()
        toggleEditMode() // Sai do modo de edição
        theView.collectionView.reloadData()
    }
}
