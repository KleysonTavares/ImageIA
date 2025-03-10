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
    
    private let listAspectRatios: [AspectRatio] = [
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
        return listAspectRatios.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AspectRatioCustomCell.identifier, for: indexPath) as! AspectRatioCustomCell
        let option = listAspectRatios[indexPath.row]
        cell.configureCell(with: option)
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
        let selectedOption = listAspectRatios[indexPath.row]
        delegate?.didSelectAspectRatio(selectedOption.aspectRatio)
    }
}

extension AspectRatioViewController: ViewCode {
    func addSubviews() {
        view.addSubview(collectionView)
    }

    func configure() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 120)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(AspectRatioCustomCell.self, forCellWithReuseIdentifier: AspectRatioCustomCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isUserInteractionEnabled = true

        // Adiciona um gesto de toque para depuração
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        collectionView.addGestureRecognizer(tapGesture)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setupStyle() {
        view.backgroundColor = .white
    }
}
