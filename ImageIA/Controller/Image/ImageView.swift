//
//  HomeView.swift
//  ImageIA
//
//  Created by Kleyson Tavares on 08/02/25.
//

import UIKit

protocol ImageViewDelegate: AnyObject {
    func didButtonPressed()
}

final class ImageView: UIView {

    let collectionView: UICollectionView

    override init(frame: CGRect) {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenItem = (screenSize.width - 40) / 2

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenItem, height: screenItem)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 8

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ImageView: ViewCode {
    func configure() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.layer.cornerRadius = 10
    }

    func addSubviews() {
        addSubview(collectionView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func setupStyle() {
        backgroundColor = .white
    }
}
