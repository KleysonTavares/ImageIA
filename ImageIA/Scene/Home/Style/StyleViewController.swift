//
//  StyleViewController.swift
//  ImageIA
//
//  Created by Kleyson Tavares on 16/02/25.
//

import UIKit

class StyleViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var collectionView: UICollectionView!
    private var selectedIndexPath: IndexPath? = IndexPath(row: 0, section: 0) // Pré-seleciona a primeira célula
    
    private let options: [Option] = [
        Option(style: "realistic", image: "realistic", label: "Realista"),
        Option(style: "anime", image: "anime", label: "Anime"),
        Option(style: "imagine-turbo", image: "imagine-turbo", label: "Versátil")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 120)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(StyleCustomCell.self, forCellWithReuseIdentifier: StyleCustomCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isUserInteractionEnabled = true
        
        // Adiciona um gesto de toque para depuração
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        collectionView.addGestureRecognizer(tapGesture)
        
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: collectionView)
        if let indexPath = collectionView.indexPathForItem(at: location) {
            print("Célula tocada: \(indexPath.row)")
            collectionView(collectionView, didSelectItemAt: indexPath)
        } else {
            print("Toque fora das células")
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StyleCustomCell.identifier, for: indexPath) as! StyleCustomCell
        let option = options[indexPath.row]
        cell.configureCell(with: option)
        cell.setSelected(selectedIndexPath == indexPath)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let previousIndexPath = selectedIndexPath {
            if let previousCell = collectionView.cellForItem(at: previousIndexPath) as? StyleCustomCell {
                previousCell.setSelected(false)
            }
        }
        selectedIndexPath = indexPath
        if let cell = collectionView.cellForItem(at: indexPath) as? StyleCustomCell {
            cell.setSelected(true)
        }
        let selectedOption = options[indexPath.row]
    }
}
