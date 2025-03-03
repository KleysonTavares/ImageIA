//
//  AspectRatioViewController.swift
//  ImageIA
//
//  Created by Kleyson Tavares on 02/03/25.
//

import UIKit

protocol AspectRatioViewControllerDelegate: AnyObject {
    func didSelectAspectRatio(_ aspectRatio: String)
}

final class AspectRatioViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    weak var delegate: AspectRatioViewControllerDelegate?
    
    private var collectionView: UICollectionView!
    private var selectedIndexPath: IndexPath? = IndexPath(row: 0, section: 0)
    
    let aspectRatios: [AspectRatio] = [
        AspectRatio(aspectRatio: "1:1", image: "aspect_1_1", label: "1:1"),
        AspectRatio(aspectRatio: "3:2", image: "aspect_3_2", label: "3:2"),
        AspectRatio(aspectRatio: "4:3", image: "aspect_4_3", label: "4:3"),
        AspectRatio(aspectRatio: "3:4", image: "aspect_3_4", label: "3:4"),
        AspectRatio(aspectRatio: "16:9", image: "aspect_16_9", label: "16:9"),
        AspectRatio(aspectRatio: "9:16", image: "aspect_9_16", label: "9:16")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 100, height: 120)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(AspectRatioCustomCell.self, forCellWithReuseIdentifier: AspectRatioCustomCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white

        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return aspectRatios.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AspectRatioCustomCell.identifier, for: indexPath) as! AspectRatioCustomCell
        let aspectRatio = aspectRatios[indexPath.row]
        cell.configureCell(with: aspectRatio)
        cell.setSelected(selectedIndexPath == indexPath)
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let previousIndexPath = selectedIndexPath {
            if let previousCell = collectionView.cellForItem(at: previousIndexPath) as? AspectRatioCustomCell {
                previousCell.setSelected(false)
            }
        }
        selectedIndexPath = indexPath
        if let cell = collectionView.cellForItem(at: indexPath) as? AspectRatioCustomCell {
            cell.setSelected(true)
        }
        let selectedAspectRatio = aspectRatios[indexPath.row]
        delegate?.didSelectAspectRatio(selectedAspectRatio.aspectRatio)
        dismiss(animated: true, completion: nil)
    }
}
